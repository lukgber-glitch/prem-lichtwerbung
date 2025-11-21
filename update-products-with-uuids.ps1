# Update products.json to use UUID file references instead of text paths

$mappingFile = "C:\Users\grube\WebstormProjects\prem-lichtwerbung\image-uuid-mapping.json"
$productsFile = "C:\Users\grube\WebstormProjects\prem-lichtwerbung\directus\bootstrap\sample-data\products.json"

Write-Host "=========================================="
Write-Host "UPDATING PRODUCTS WITH UUID REFERENCES"
Write-Host "=========================================="
Write-Host ""

# Load UUID mapping
Write-Host "Loading UUID mapping..." -NoNewline
try {
    $uuidMapping = Get-Content $mappingFile | ConvertFrom-Json
    Write-Host " OK" -ForegroundColor Green
    Write-Host "Loaded $($uuidMapping.PSObject.Properties.Count) UUID mappings" -ForegroundColor Gray
}
catch {
    Write-Host " FAILED" -ForegroundColor Red
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

# Load products data
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
Write-Host "Updating image references..."
Write-Host ""

$imageFields = @("primary_image", "day_image", "night_image", "before_image", "after_image")
$updateCount = 0

foreach ($product in $products) {
    $productId = $product.id
    $productName = $product.name
    
    Write-Host "Product $productId - $productName"
    
    foreach ($field in $imageFields) {
        $currentValue = $product.$field
        
        if ($currentValue -and $currentValue -like "/images/products/*") {
            # Extract filename from path
            $filename = $currentValue -replace "/images/products/", ""
            
            # Look up UUID for this filename
            $uuid = $uuidMapping.$filename
            
            if ($uuid) {
                $product.$field = $uuid
                Write-Host "  $field : $filename -> $uuid" -ForegroundColor Green
                $updateCount++
            }
            else {
                Write-Host "  $field : $filename -> UUID NOT FOUND!" -ForegroundColor Red
            }
        }
        elseif ($currentValue) {
            Write-Host "  $field : Already has value: $currentValue" -ForegroundColor Yellow
        }
    }
    
    Write-Host ""
}

# Save updated products
Write-Host "Saving updated products.json..." -NoNewline
try {
    $products | ConvertTo-Json -Depth 10 | Set-Content $productsFile
    Write-Host " OK" -ForegroundColor Green
}
catch {
    Write-Host " FAILED" -ForegroundColor Red
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "=========================================="
Write-Host "UPDATE SUMMARY"
Write-Host "=========================================="
Write-Host "Total products: $($products.Count)"
Write-Host "Image fields updated: $updateCount"
Write-Host "Products file: $productsFile"
Write-Host "=========================================="
Write-Host ""
Write-Host "✅ Products updated with UUID references!" -ForegroundColor Green
Write-Host ""
Write-Host "Next step: Re-import products to Directus" -ForegroundColor Cyan
