# Download all product images from Unsplash URLs to local directory

$productsFile = "C:\Users\grube\WebstormProjects\prem-lichtwerbung\directus\bootstrap\sample-data\products.json"
$outputDir = "C:\Users\grube\WebstormProjects\prem-lichtwerbung\directus\uploads\products"

Write-Host "Loading products data..."
$products = Get-Content $productsFile | ConvertFrom-Json

$imageTypes = @("primary_image", "day_image", "night_image", "before_image", "after_image")
$totalImages = 0
$successCount = 0
$failCount = 0

foreach ($product in $products) {
    Write-Host ""
    Write-Host "Processing Product $($product.id): $($product.name)"
    
    foreach ($imageType in $imageTypes) {
        $url = $product.$imageType
        if ($url) {
            $totalImages++
            $typeName = $imageType -replace "_image", ""
            $filename = "product-$($product.id)-$typeName.jpg"
            $outputPath = Join-Path $outputDir $filename
            
            try {
                Write-Host "  Downloading $typeName... " -NoNewline
                Invoke-WebRequest -Uri $url -OutFile $outputPath -UseBasicParsing -TimeoutSec 30
                Write-Host "OK" -ForegroundColor Green
                $successCount++
            }
            catch {
                Write-Host "FAILED" -ForegroundColor Red
                Write-Host "    Error: $($_.Exception.Message)" -ForegroundColor Red
                $failCount++
            }
        }
    }
}

Write-Host ""
Write-Host "=========================================="
Write-Host "Download Summary"
Write-Host "=========================================="
Write-Host "Total images: $totalImages"
Write-Host "Success: $successCount" -ForegroundColor Green
Write-Host "Failed: $failCount" -ForegroundColor Red
Write-Host "Output directory: $outputDir"
Write-Host "=========================================="
