# Import products with UUID references to Directus via API

$directusUrl = "http://localhost:8055"
$adminEmail = "admin@example.com"
$adminPassword = "admin123"
$productsFile = "C:\Users\grube\WebstormProjects\prem-lichtwerbung\directus\bootstrap\sample-data\products.json"
$relationshipsFile = "C:\Users\grube\WebstormProjects\prem-lichtwerbung\directus\bootstrap\sample-data\products_categories.json"

Write-Host "=========================================="
Write-Host "IMPORTING PRODUCTS TO DIRECTUS"
Write-Host "=========================================="
Write-Host ""

# Step 1: Authenticate
Write-Host "Authenticating with Directus..." -NoNewline
try {
    $authBody = @{
        email = $adminEmail
        password = $adminPassword
    } | ConvertTo-Json

    $authResponse = Invoke-WebRequest -Uri "$directusUrl/auth/login" `
        -Method POST `
        -ContentType "application/json" `
        -Body $authBody `
        -UseBasicParsing

    $token = ($authResponse.Content | ConvertFrom-Json).data.access_token
    
    if (-not $token) {
        throw "Failed to get access token"
    }
    
    Write-Host " OK" -ForegroundColor Green
}
catch {
    Write-Host " FAILED" -ForegroundColor Red
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

$headers = @{
    Authorization = "Bearer $token"
}

# Step 2: Load products data
Write-Host "Loading products data..." -NoNewline
try {
    $products = Get-Content $productsFile | ConvertFrom-Json
    Write-Host " OK" -ForegroundColor Green
    Write-Host "Loaded $($products.Count) products" -ForegroundColor Gray
}
catch {
    Write-Host " FAILED" -ForegroundColor Red
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "Importing products..."
Write-Host ""

$successCount = 0
$failCount = 0

foreach ($product in $products) {
    $productName = $product.name
    $productId = $product.id
    
    Write-Host "Importing Product $productId - $productName... " -NoNewline
    
    try {
        $productJson = $product | ConvertTo-Json -Depth 10 -Compress
        
        $response = Invoke-WebRequest -Uri "$directusUrl/items/products" `
            -Method POST `
            -Headers $headers `
            -ContentType "application/json" `
            -Body $productJson `
            -UseBasicParsing
        
        Write-Host "OK" -ForegroundColor Green
        $successCount++
    }
    catch {
        Write-Host "FAILED" -ForegroundColor Red
        Write-Host "  Error: $($_.Exception.Message)" -ForegroundColor Red
        $failCount++
    }
    
    Start-Sleep -Milliseconds 200
}

# Step 3: Import M2M relationships
Write-Host ""
Write-Host "Loading products_categories relationships..." -NoNewline
try {
    $relationships = Get-Content $relationshipsFile | ConvertFrom-Json
    Write-Host " OK" -ForegroundColor Green
    Write-Host "Loaded $($relationships.Count) relationships" -ForegroundColor Gray
}
catch {
    Write-Host " FAILED" -ForegroundColor Red
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "Importing M2M relationships..."
Write-Host ""

$relSuccessCount = 0
$relFailCount = 0

foreach ($rel in $relationships) {
    Write-Host "Importing Product $($rel.products_id) -> Category $($rel.categories_id)... " -NoNewline
    
    try {
        $relJson = $rel | ConvertTo-Json -Compress
        
        $response = Invoke-WebRequest -Uri "$directusUrl/items/products_categories" `
            -Method POST `
            -Headers $headers `
            -ContentType "application/json" `
            -Body $relJson `
            -UseBasicParsing
        
        Write-Host "OK" -ForegroundColor Green
        $relSuccessCount++
    }
    catch {
        Write-Host "FAILED" -ForegroundColor Red
        Write-Host "  Error: $($_.Exception.Message)" -ForegroundColor Red
        $relFailCount++
    }
    
    Start-Sleep -Milliseconds 100
}

# Summary
Write-Host ""
Write-Host "=========================================="
Write-Host "IMPORT SUMMARY"
Write-Host "=========================================="
Write-Host "Products:"
Write-Host "  Total: $($products.Count)"
Write-Host "  Success: $successCount" -ForegroundColor Green
Write-Host "  Failed: $failCount" -ForegroundColor Red
Write-Host ""
Write-Host "Relationships:"
Write-Host "  Total: $($relationships.Count)"
Write-Host "  Success: $relSuccessCount" -ForegroundColor Green
Write-Host "  Failed: $relFailCount" -ForegroundColor Red
Write-Host "=========================================="
Write-Host ""

if ($successCount -eq $products.Count -and $relSuccessCount -eq $relationships.Count) {
    Write-Host "✅ All products and relationships imported successfully!" -ForegroundColor Green
}
else {
    Write-Host "⚠️  Some imports failed. Check errors above." -ForegroundColor Yellow
}
