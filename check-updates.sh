#!/bin/bash

echo "========================================"
echo "NPM DEPENDENCY UPDATE CHECK"
echo "========================================"
echo ""

# Check Frontend Dependencies
if [ -d "/app/frontend" ]; then
  echo "📦 Checking FRONTEND dependencies..."
  cd /app/frontend
  if [ -f "package.json" ]; then
    npm outdated || true
    echo ""
    echo "Run 'npm-check-updates' for detailed upgrade paths:"
    npx npm-check-updates || true
  else
    echo "⚠️  No package.json found in frontend"
  fi
  echo ""
fi

# Check Directus Dependencies
if [ -d "/app/directus" ]; then
  echo "📦 Checking DIRECTUS dependencies..."
  cd /app/directus
  if [ -f "package.json" ]; then
    npm outdated || true
    echo ""
    echo "Run 'npm-check-updates' for detailed upgrade paths:"
    npx npm-check-updates || true
  else
    echo "⚠️  No package.json found in directus"
  fi
  echo ""
fi

echo "========================================"
echo "✅ Dependency check complete"
echo "========================================"
