#!/bin/sh

set -e

echo "========================================"
echo "🚀 Starting Directus Bootstrap Process"
echo "========================================"

# Wait for PostgreSQL to be ready
echo "⏳ Waiting for PostgreSQL..."
until nc -z postgres 5432; do
  echo "PostgreSQL is unavailable - sleeping"
  sleep 2
done
echo "✅ PostgreSQL is ready"

# Function to check if database is already populated
check_database_populated() {
  echo "🔍 Checking if database is already populated..."
  echo "   Connection: ${DB_USER}@${DB_HOST}:${DB_PORT}/${DB_DATABASE}"
  
  # First, check if products table exists
  TABLE_EXISTS=$(PGPASSWORD="${DB_PASSWORD}" psql -h "${DB_HOST}" -p "${DB_PORT}" -U "${DB_USER}" -d "${DB_DATABASE}" \
    -t -c "SELECT EXISTS (SELECT FROM information_schema.tables WHERE table_name = 'products');" 2>/dev/null | xargs)
  
  if [ "$TABLE_EXISTS" != "t" ]; then
    echo "   Products table does not exist - fresh database"
    return 1
  fi
  
  # Table exists, check if it has data
  PRODUCT_COUNT=$(PGPASSWORD="${DB_PASSWORD}" psql -h "${DB_HOST}" -p "${DB_PORT}" -U "${DB_USER}" -d "${DB_DATABASE}" \
    -t -c "SELECT COUNT(*) FROM products;" 2>&1 | xargs)
  
  # Check if query succeeded and returned a number
  if echo "$PRODUCT_COUNT" | grep -qE '^[0-9]+$'; then
    if [ "$PRODUCT_COUNT" -gt 0 ]; then
      echo "✅ Database already populated (found $PRODUCT_COUNT products)"
      return 0
    else
      echo "   Products table exists but is empty"
      return 1
    fi
  else
    echo "   Database query failed or returned non-numeric result: $PRODUCT_COUNT"
    return 1
  fi
}

# Check if bootstrap has already been completed
# Note: Using /tmp instead of /directus to avoid conflict with Railway volume mounts
BOOTSTRAP_FLAG="/tmp/.bootstrap_complete"

if [ -f "$BOOTSTRAP_FLAG" ]; then
  echo ""
  echo "✅ Bootstrap already completed (flag file exists)"
  echo "🚀 Starting Directus server..."
  echo ""
  exec directus start
fi

# Check if database is already populated (fallback if flag file missing)
if check_database_populated; then
  echo ""
  echo "✅ Bootstrap already completed (database has data)"
  echo "🚀 Starting Directus server..."
  echo ""
  exec directus start
fi

echo ""
echo "🆕 First-time setup detected - running bootstrap..."

# Explicitly export environment variables for Directus subprocess
export DB_CLIENT="${DB_CLIENT}"
export DB_HOST="${DB_HOST}"
export DB_PORT="${DB_PORT}"
export DB_DATABASE="${DB_DATABASE}"
export DB_USER="${DB_USER}"
export DB_PASSWORD="${DB_PASSWORD}"
export KEY="${KEY}"
export SECRET="${SECRET}"
export ADMIN_EMAIL="${ADMIN_EMAIL}"
export ADMIN_PASSWORD="${ADMIN_PASSWORD}"
export PUBLIC_URL="${PUBLIC_URL}"
export CORS_ENABLED="${CORS_ENABLED}"
export CORS_ORIGIN="${CORS_ORIGIN}"

# Bootstrap Directus (create admin user and apply schema)
echo ""
echo "📦 Bootstrapping Directus..."
echo "🔍 Debug: Environment variables check:"
echo "   DB_CLIENT=${DB_CLIENT}"
echo "   DB_HOST=${DB_HOST}"
echo "   DB_PORT=${DB_PORT}"
echo "   DB_DATABASE=${DB_DATABASE}"
echo "   DB_USER=${DB_USER}"
echo "   KEY=${KEY}"
echo "   SECRET=${SECRET}"
echo ""
echo "📋 All environment variables:"
env | grep -E '^(DB_|KEY|SECRET|ADMIN_|PUBLIC_|CORS_)' | sort
echo ""
directus bootstrap

# Start Directus in background for data import
echo "Starting Directus server in background..."
directus start &
DIRECTUS_PID=$!

# Determine the correct port (Railway uses PORT env var, defaults to 8055)
DIRECTUS_PORT=${PORT:-8055}
echo "🔍 Directus is running on port: $DIRECTUS_PORT"

# Wait for Directus to be fully initialized with retry loop
echo "⏳ Waiting for Directus to be ready..."
MAX_RETRIES=30
RETRY_COUNT=0
HEALTH_URL="http://localhost:$DIRECTUS_PORT/server/health"

while [ $RETRY_COUNT -lt $MAX_RETRIES ]; do
  HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$HEALTH_URL" || echo "000")
  
  if [ "$HTTP_CODE" = "200" ]; then
    echo "✅ Directus is ready (responded with HTTP 200)"
    break
  else
    RETRY_COUNT=$((RETRY_COUNT + 1))
    echo "   Attempt $RETRY_COUNT/$MAX_RETRIES - Directus not ready yet (HTTP $HTTP_CODE), waiting 5 seconds..."
    sleep 5
  fi
done

if [ $RETRY_COUNT -eq $MAX_RETRIES ]; then
  echo "❌ Directus failed to become ready after $MAX_RETRIES attempts"
  echo "   Last HTTP status: $HTTP_CODE"
  exit 1
fi

# Additional wait to ensure authentication subsystem is fully initialized
echo "⏸️  Waiting 45 seconds for Directus authentication subsystem to initialize..."
sleep 45

# Authenticate and get access token
echo "🔑 Authenticating with Directus..."
AUTH_RESPONSE=$(curl -s -X POST http://localhost:$DIRECTUS_PORT/auth/login \
  -H "Content-Type: application/json" \
  --data "{\"email\":\"$ADMIN_EMAIL\",\"password\":\"$ADMIN_PASSWORD\"}")

ACCESS_TOKEN=$(echo "$AUTH_RESPONSE" | jq -r '.data.access_token')

if [ -z "$ACCESS_TOKEN" ] || [ "$ACCESS_TOKEN" = "null" ]; then
  echo "❌ Failed to authenticate with Directus"
  echo "Response: $AUTH_RESPONSE"
  exit 1
fi

echo "✅ Successfully authenticated with Directus"
echo "✅ Directus is ready for data import"

# Import collections
if [ -f "/directus/bootstrap/collections.json" ]; then
  echo ""
  echo "📋 Importing collections..."
  collections=$(cat /directus/bootstrap/collections.json | jq -c '.[]')
  echo "$collections" | while IFS= read -r collection; do
    curl -X POST http://localhost:$DIRECTUS_PORT/collections \
      -H "Content-Type: application/json" \
      -H "Authorization: Bearer $ACCESS_TOKEN" \
      --data "$collection" || echo "Collection already exists or import failed"
  done
fi

# Import fields
if [ -f "/directus/bootstrap/fields.json" ]; then
  echo ""
  echo "🔧 Importing fields..."
  for collection in $(cat /directus/bootstrap/fields.json | jq -r 'keys[]'); do
    fields=$(cat /directus/bootstrap/fields.json | jq -c ".\"$collection\"[]")
    echo "$fields" | while IFS= read -r field; do
      curl -X POST "http://localhost:$DIRECTUS_PORT/fields/$collection" \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer $ACCESS_TOKEN" \
        --data "$field" || echo "Field already exists or import failed"
    done
  done
fi

# Import relations
if [ -f "/directus/bootstrap/relations.json" ]; then
  echo ""
  echo "🔗 Importing relations..."
  relations=$(cat /directus/bootstrap/relations.json | jq -c '.[]')
  echo "$relations" | while IFS= read -r relation; do
    curl -X POST http://localhost:$DIRECTUS_PORT/relations \
      -H "Content-Type: application/json" \
      -H "Authorization: Bearer $ACCESS_TOKEN" \
      --data "$relation" || echo "Relation already exists or import failed"
  done
fi

# Import roles
if [ -f "/directus/bootstrap/roles.json" ]; then
  echo ""
  echo "👥 Importing roles..."
  roles=$(cat /directus/bootstrap/roles.json | jq -c '.[]')
  echo "$roles" | while IFS= read -r role; do
    curl -X POST http://localhost:$DIRECTUS_PORT/roles \
      -H "Content-Type: application/json" \
      -H "Authorization: Bearer $ACCESS_TOKEN" \
      --data "$role" || echo "Role already exists or import failed"
  done
fi

# Public Access Permissions - Manual Configuration Required
echo ""
echo "⚠️  PUBLIC ACCESS PERMISSIONS - MANUAL CONFIGURATION REQUIRED"
echo "================================================================"
echo ""
echo "Directus 11.x Security Limitation:"
echo "  The Public role cannot be modified via API (returns 403 Forbidden)"
echo "  even with admin credentials. This is a Directus security restriction."
echo ""
echo "📝 You must configure public permissions manually via the admin panel:"
echo "  1. Open http://localhost:8055 in your browser"
echo "  2. Log in with: $ADMIN_EMAIL / $ADMIN_PASSWORD"
echo "  3. Go to Settings → Access Control → Public"
echo "  4. Add read permissions for: products, categories, tags,"
echo "     products_categories, products_tags, reviews, pages, banners, settings"
echo "  5. Add create permissions for: customers, orders"
echo ""
echo "✅ This is a ONE-TIME setup that persists across container restarts."
echo ""
echo "📖 See README.md 'Troubleshooting' section for detailed step-by-step"
echo "   instructions with screenshots and troubleshooting tips."
echo ""
echo "================================================================"
echo ""

# Upload product images and generate UUID mapping
echo ""
echo "📸 Uploading product images to Directus..."
if [ -f "/directus/bootstrap/upload-images.js" ]; then
  node /directus/bootstrap/upload-images.js
  if [ $? -ne 0 ]; then
    echo "⚠️  Image upload failed, but continuing with bootstrap..."
  fi
else
  echo "⚠️  Image upload script not found, skipping..."
fi

# Prepare products with image UUIDs
echo ""
echo "🔧 Preparing products with image UUIDs..."
if [ -f "/directus/bootstrap/prepare-products.js" ]; then
  node /directus/bootstrap/prepare-products.js
  if [ $? -ne 0 ]; then
    echo "⚠️  Products preparation failed, but continuing with bootstrap..."
  fi
else
  echo "⚠️  Products preparation script not found, skipping..."
fi

# Import sample data
echo ""
echo "📊 Importing sample data..."

# Import categories
if [ -f "/directus/bootstrap/sample-data/categories.json" ]; then
  echo "  - Importing categories..."
  categories=$(cat /directus/bootstrap/sample-data/categories.json | jq -c '.[]')
  echo "$categories" | while IFS= read -r category; do
    curl -X POST http://localhost:$DIRECTUS_PORT/items/categories \
      -H "Content-Type: application/json" \
      -H "Authorization: Bearer $ACCESS_TOKEN" \
      --data "$category" > /dev/null 2>&1 || true
  done
fi

# Import tags
if [ -f "/directus/bootstrap/sample-data/tags.json" ]; then
  echo "  - Importing tags..."
  tags=$(cat /directus/bootstrap/sample-data/tags.json | jq -c '.[]')
  echo "$tags" | while IFS= read -r tag; do
    curl -X POST http://localhost:$DIRECTUS_PORT/items/tags \
      -H "Content-Type: application/json" \
      -H "Authorization: Bearer $ACCESS_TOKEN" \
      --data "$tag" > /dev/null 2>&1 || true
  done
fi

# Import products
if [ -f "/directus/bootstrap/sample-data/products-final.json" ]; then
  echo "  - Importing products (with image UUIDs)..."
  products=$(cat /directus/bootstrap/sample-data/products-final.json | jq -c '.[]')
  echo "$products" | while IFS= read -r product; do
    curl -X POST http://localhost:$DIRECTUS_PORT/items/products \
      -H "Content-Type: application/json" \
      -H "Authorization: Bearer $ACCESS_TOKEN" \
      --data "$product" > /dev/null 2>&1 || true
  done
elif [ -f "/directus/bootstrap/sample-data/products.json" ]; then
  echo "  - Importing products (fallback to template)..."
  products=$(cat /directus/bootstrap/sample-data/products.json | jq -c '.[]')
  echo "$products" | while IFS= read -r product; do
    curl -X POST http://localhost:$DIRECTUS_PORT/items/products \
      -H "Content-Type: application/json" \
      -H "Authorization: Bearer $ACCESS_TOKEN" \
      --data "$product" > /dev/null 2>&1 || true
  done
fi

# Import products_categories junction data
if [ -f "/directus/bootstrap/sample-data/products_categories.json" ]; then
  echo "  - Importing products_categories (M2M relations)..."
  products_categories=$(cat /directus/bootstrap/sample-data/products_categories.json | jq -c '.[]')
  echo "$products_categories" | while IFS= read -r junction; do
    curl -X POST http://localhost:$DIRECTUS_PORT/items/products_categories \
      -H "Content-Type: application/json" \
      -H "Authorization: Bearer $ACCESS_TOKEN" \
      --data "$junction" > /dev/null 2>&1 || true
  done
fi

# Import customers
if [ -f "/directus/bootstrap/sample-data/customers.json" ]; then
  echo "  - Importing customers..."
  customers=$(cat /directus/bootstrap/sample-data/customers.json | jq -c '.[]')
  echo "$customers" | while IFS= read -r customer; do
    curl -X POST http://localhost:$DIRECTUS_PORT/items/customers \
      -H "Content-Type: application/json" \
      -H "Authorization: Bearer $ACCESS_TOKEN" \
      --data "$customer" > /dev/null 2>&1 || true
  done
fi

# Import orders
if [ -f "/directus/bootstrap/sample-data/orders.json" ]; then
  echo "  - Importing orders..."
  orders=$(cat /directus/bootstrap/sample-data/orders.json | jq -c '.[]')
  echo "$orders" | while IFS= read -r order; do
    curl -X POST http://localhost:$DIRECTUS_PORT/items/orders \
      -H "Content-Type: application/json" \
      -H "Authorization: Bearer $ACCESS_TOKEN" \
      --data "$order" > /dev/null 2>&1 || true
  done
fi

# Import pages
if [ -f "/directus/bootstrap/sample-data/pages.json" ]; then
  echo "  - Importing pages..."
  pages=$(cat /directus/bootstrap/sample-data/pages.json | jq -c '.[]')
  echo "$pages" | while IFS= read -r page; do
    curl -X POST http://localhost:$DIRECTUS_PORT/items/pages \
      -H "Content-Type: application/json" \
      -H "Authorization: Bearer $ACCESS_TOKEN" \
      --data "$page" > /dev/null 2>&1 || true
  done
fi

echo ""
echo "========================================"
echo "✅ Directus Bootstrap Complete!"
echo "========================================"
echo ""
echo "🌐 Directus is running at: http://localhost:8055"
echo "👤 Admin email: $ADMIN_EMAIL"
echo "🔑 Admin password: $ADMIN_PASSWORD"
echo ""

# Create flag file to prevent re-running bootstrap on restart
touch "$BOOTSTRAP_FLAG"
echo "📝 Created bootstrap completion flag: $BOOTSTRAP_FLAG"
echo ""

# Keep Directus running in foreground
echo "Directus server is running..."
wait $DIRECTUS_PID
