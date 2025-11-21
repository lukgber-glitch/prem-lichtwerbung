# Update products.json to use local image paths instead of Unsplash URLs

$productsFile = "C:\Users\grube\WebstormProjects\prem-lichtwerbung\directus\bootstrap\sample-data\products.json"

Write-Host "Loading products data..."
$products = Get-Content $productsFile | ConvertFrom-Json

$imageTypes = @("primary_image", "day_image", "night_image", "before_image", "after_image")
$updateCount = 0

Write-Host "Updating image paths..."

foreach ($product in $products) {
    Write-Host "Product $($product.id): $($product.name)"
    
    foreach ($imageType in $imageTypes) {
        if ($product.$imageType) {
            $typeName = $imageType -replace "_image", ""
            $localPath = "/uploads/products/product-$($product.id)-$typeName.jpg"
            $product.$imageType = $localPath
            $updateCount++
            Write-Host "  $imageType -> $localPath"
        }
    }
}

Write-Host ""
Write-Host "Saving updated products.json..."
$products | ConvertTo-Json -Depth 10 | Set-Content $productsFile

Write-Host ""
Write-Host "=========================================="
Write-Host "Update Complete"
Write-Host "=========================================="
Write-Host "Total image paths updated: $updateCount"
Write-Host "File: $productsFile"
Write-Host "=========================================="
