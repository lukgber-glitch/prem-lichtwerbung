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
sleep 10

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

# Import permissions
# Note: Skipping permissions import - Directus 11.x uses a different permissions API
# Public access can be configured through the Directus admin panel after setup
# For now, admin token provides full access during bootstrap
# if [ -f "/directus/bootstrap/permissions.json" ]; then
#   echo ""
#   echo "🔐 Importing permissions..."
#   permissions=$(cat /directus/bootstrap/permissions.json | jq -c '.[]')
#   echo "$permissions" | while IFS= read -r permission; do
#     curl -X POST http://localhost:8055/permissions \
#       -H "Content-Type: application/json" \
#       -H "Authorization: Bearer $ACCESS_TOKEN" \
#       --data "$permission" || echo "Permission already exists or import failed"
#   done
# fi
echo ""
echo "🔐 Skipping permissions import (configure via Directus admin panel)"

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
if [ -f "/directus/bootstrap/sample-data/products.json" ]; then
  echo "  - Importing products..."
  products=$(cat /directus/bootstrap/sample-data/products.json | jq -c '.[]')
  echo "$products" | while IFS= read -r product; do
    curl -X POST http://localhost:8055/items/products \
      -H "Content-Type: application/json" \
      -H "Authorization: Bearer $ACCESS_TOKEN" \
      --data "$product" > /dev/null 2>&1 || true
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

echo ""
echo "========================================"
echo "✅ Directus Bootstrap Complete!"
echo "========================================"
echo ""
echo "🌐 Directus is running at: http://localhost:8055"
echo "👤 Admin email: $ADMIN_EMAIL"
echo "🔑 Admin password: $ADMIN_PASSWORD"
echo ""

# Keep Directus running in foreground
echo "Directus server is running..."
wait $DIRECTUS_PID
