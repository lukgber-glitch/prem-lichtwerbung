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

# Check if bootstrap has already been completed
BOOTSTRAP_FLAG="/directus/.bootstrap_complete"

if [ -f "$BOOTSTRAP_FLAG" ]; then
  echo ""
  echo "✅ Bootstrap already completed (flag file exists)"
  echo "🚀 Starting Directus server..."
  echo ""
  exec directus start
fi

echo ""
echo "🆕 First-time setup detected - running bootstrap..."

# Bootstrap Directus (create admin user and apply schema)
echo ""
echo "📦 Bootstrapping Directus..."
directus bootstrap

# Start Directus in background for data import
echo "Starting Directus server in background..."
directus start &
DIRECTUS_PID=$!

# Wait for Directus to be fully initialized
echo "⏳ Waiting for Directus to be ready..."
sleep 30

# Authenticate and get access token
echo "🔑 Authenticating with Directus..."
AUTH_RESPONSE=$(curl -s -X POST http://localhost:8055/auth/login \
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
    curl -X POST http://localhost:8055/collections \
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
      curl -X POST "http://localhost:8055/fields/$collection" \
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
    curl -X POST http://localhost:8055/relations \
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
    curl -X POST http://localhost:8055/roles \
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
    curl -X POST http://localhost:8055/items/categories \
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
    curl -X POST http://localhost:8055/items/tags \
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
    curl -X POST http://localhost:8055/items/products \
      -H "Content-Type: application/json" \
      -H "Authorization: Bearer $ACCESS_TOKEN" \
      --data "$product" > /dev/null 2>&1 || true
  done
elif [ -f "/directus/bootstrap/sample-data/products.json" ]; then
  echo "  - Importing products (fallback to template)..."
  products=$(cat /directus/bootstrap/sample-data/products.json | jq -c '.[]')
  echo "$products" | while IFS= read -r product; do
    curl -X POST http://localhost:8055/items/products \
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
    curl -X POST http://localhost:8055/items/products_categories \
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
    curl -X POST http://localhost:8055/items/customers \
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
    curl -X POST http://localhost:8055/items/orders \
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
    curl -X POST http://localhost:8055/items/pages \
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
