# Download real professional signage images from Unsplash
# Each product gets 5 images: primary, day, night, before, after

$outputDir = "C:\Users\grube\WebstormProjects\prem-lichtwerbung\frontend\public\images\products"

# Ensure output directory exists
New-Item -ItemType Directory -Force -Path $outputDir | Out-Null

$images = @(
    # Product 1: Single-Sided LED Lightbox
    @{url="https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=1200&h=800&fit=crop"; file="product-1-primary.jpg"}, # Storefront with lightbox
    @{url="https://images.unsplash.com/photo-1555421689-d68471e189f2?w=1200&h=800&fit=crop"; file="product-1-day.jpg"}, # Modern store daytime
    @{url="https://images.unsplash.com/photo-1513694203232-719a280e022f?w=1200&h=800&fit=crop"; file="product-1-night.jpg"}, # Illuminated storefront night
    @{url="https://images.unsplash.com/photo-1497366216548-37526070297c?w=1200&h=800&fit=crop"; file="product-1-before.jpg"}, # Plain building
    @{url="https://images.unsplash.com/photo-1497366754035-f200968a6e72?w=1200&h=800&fit=crop"; file="product-1-after.jpg"}, # Branded storefront
    
    # Product 2: Double-Sided LED Lightbox
    @{url="https://images.unsplash.com/photo-1528698827591-e19ccd7bc23d?w=1200&h=800&fit=crop"; file="product-2-primary.jpg"}, # Mall hanging sign
    @{url="https://images.unsplash.com/photo-1519167758481-83f29da8c2b7?w=1200&h=800&fit=crop"; file="product-2-day.jpg"}, # Shopping center day
    @{url="https://images.unsplash.com/photo-1555529902-5261145633bf?w=1200&h=800&fit=crop"; file="product-2-night.jpg"}, # Mall illuminated night
    @{url="https://images.unsplash.com/photo-1519167758481-83f29da8c2b7?w=1200&h=800&fit=crop"; file="product-2-before.jpg"}, # Before signage
    @{url="https://images.unsplash.com/photo-1528698827591-e19ccd7bc23d?w=1200&h=800&fit=crop"; file="product-2-after.jpg"}, # After with sign
    
    # Product 3: Front-Lit Channel Letters
    @{url="https://images.unsplash.com/photo-1534705867302-1541b3c97786?w=1200&h=800&fit=crop"; file="product-3-primary.jpg"}, # 3D letters building
    @{url="https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=1200&h=800&fit=crop"; file="product-3-day.jpg"}, # Office building day
    @{url="https://images.unsplash.com/photo-1514565131-fce0801e5785?w=1200&h=800&fit=crop"; file="product-3-night.jpg"}, # Illuminated building night
    @{url="https://images.unsplash.com/photo-1449844908441-8829872d2607?w=1200&h=800&fit=crop"; file="product-3-before.jpg"}, # Plain facade
    @{url="https://images.unsplash.com/photo-1534705867302-1541b3c97786?w=1200&h=800&fit=crop"; file="product-3-after.jpg"}, # With letters
    
    # Product 4: Halo-Lit Channel Letters
    @{url="https://images.unsplash.com/photo-1497366811353-6870744d04b2?w=1200&h=800&fit=crop"; file="product-4-primary.jpg"}, # Premium building letters
    @{url="https://images.unsplash.com/photo-1486718448742-163732cd1544?w=1200&h=800&fit=crop"; file="product-4-day.jpg"}, # Corporate building day
    @{url="https://images.unsplash.com/photo-1519501025264-65ba15a82390?w=1200&h=800&fit=crop"; file="product-4-night.jpg"}, # Building illuminated night
    @{url="https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=1200&h=800&fit=crop"; file="product-4-before.jpg"}, # Before installation
    @{url="https://images.unsplash.com/photo-1497366811353-6870744d04b2?w=1200&h=800&fit=crop"; file="product-4-after.jpg"}, # After with halo letters
    
    # Product 5: Custom LED Neon Sign
    @{url="https://images.unsplash.com/photo-1572116469696-31de0f17cc34?w=1200&h=800&fit=crop"; file="product-5-primary.jpg"}, # LED neon sign
    @{url="https://images.unsplash.com/photo-1559329007-40df8a9345d8?w=1200&h=800&fit=crop"; file="product-5-day.jpg"}, # Neon sign daylight
    @{url="https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=1200&h=800&fit=crop"; file="product-5-night.jpg"}, # Neon glowing night
    @{url="https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=1200&h=800&fit=crop"; file="product-5-before.jpg"}, # Plain interior
    @{url="https://images.unsplash.com/photo-1572116469696-31de0f17cc34?w=1200&h=800&fit=crop"; file="product-5-after.jpg"}, # With neon sign
    
    # Product 6: LED Neon Open Sign
    @{url="https://images.unsplash.com/photo-1579532537598-459ecdaf39cc?w=1200&h=800&fit=crop"; file="product-6-primary.jpg"}, # Open neon sign
    @{url="https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=1200&h=800&fit=crop"; file="product-6-day.jpg"}, # Storefront day
    @{url="https://images.unsplash.com/photo-1559339352-11d035aa65de?w=1200&h=800&fit=crop"; file="product-6-night.jpg"}, # Open sign glowing
    @{url="https://images.unsplash.com/photo-1556228720-195a672e8a03?w=1200&h=800&fit=crop"; file="product-6-before.jpg"}, # Store without sign
    @{url="https://images.unsplash.com/photo-1579532537598-459ecdaf39cc?w=1200&h=800&fit=crop"; file="product-6-after.jpg"}, # With open sign
    
    # Product 7: Single-Post Pylon Sign
    @{url="https://images.unsplash.com/photo-1486325212027-8081e485255e?w=1200&h=800&fit=crop"; file="product-7-primary.jpg"}, # Tall pylon structure
    @{url="https://images.unsplash.com/photo-1541888946425-d81bb19240f5?w=1200&h=800&fit=crop"; file="product-7-day.jpg"}, # Business park day
    @{url="https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=1200&h=800&fit=crop"; file="product-7-night.jpg"}, # Illuminated building night
    @{url="https://images.unsplash.com/photo-1497366754035-f200968a6e72?w=1200&h=800&fit=crop"; file="product-7-before.jpg"}, # Property entrance before
    @{url="https://images.unsplash.com/photo-1486325212027-8081e485255e?w=1200&h=800&fit=crop"; file="product-7-after.jpg"}, # With pylon sign
    
    # Product 8: Monument Sign
    @{url="https://images.unsplash.com/photo-1497366216548-37526070297c?w=1200&h=800&fit=crop"; file="product-8-primary.jpg"}, # Low profile monument
    @{url="https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?w=1200&h=800&fit=crop"; file="product-8-day.jpg"}, # Corporate campus day
    @{url="https://images.unsplash.com/photo-1449844908441-8829872d2607?w=1200&h=800&fit=crop"; file="product-8-night.jpg"}, # Campus illuminated night
    @{url="https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=1200&h=800&fit=crop"; file="product-8-before.jpg"}, # Before monument sign
    @{url="https://images.unsplash.com/photo-1497366216548-37526070297c?w=1200&h=800&fit=crop"; file="product-8-after.jpg"}, # With monument sign
    
    # Product 9: Frosted Window Film
    @{url="https://images.unsplash.com/photo-1497366672149-e5e4b4d34eb3?w=1200&h=800&fit=crop"; file="product-9-primary.jpg"}, # Frosted glass office
    @{url="https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=1200&h=800&fit=crop"; file="product-9-day.jpg"}, # Office windows day
    @{url="https://images.unsplash.com/photo-1486325212027-8081e485255e?w=1200&h=800&fit=crop"; file="product-9-night.jpg"}, # Office lit night
    @{url="https://images.unsplash.com/photo-1497366811353-6870744d04b2?w=1200&h=800&fit=crop"; file="product-9-before.jpg"}, # Clear glass before
    @{url="https://images.unsplash.com/photo-1497366672149-e5e4b4d34eb3?w=1200&h=800&fit=crop"; file="product-9-after.jpg"}, # Frosted after
    
    # Product 10: Full-Color Window Decals
    @{url="https://images.unsplash.com/photo-1497366754035-f200968a6e72?w=1200&h=800&fit=crop"; file="product-10-primary.jpg"}, # Window graphics
    @{url="https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=1200&h=800&fit=crop"; file="product-10-day.jpg"}, # Store windows day
    @{url="https://images.unsplash.com/photo-1513694203232-719a280e022f?w=1200&h=800&fit=crop"; file="product-10-night.jpg"}, # Store windows night
    @{url="https://images.unsplash.com/photo-1519167758481-83f29da8c2b7?w=1200&h=800&fit=crop"; file="product-10-before.jpg"}, # Plain windows before
    @{url="https://images.unsplash.com/photo-1497366754035-f200968a6e72?w=1200&h=800&fit=crop"; file="product-10-after.jpg"} # Branded windows after
)

$totalImages = $images.Count
$successCount = 0
$failCount = 0

Write-Host "=========================================="
Write-Host "DOWNLOADING REAL SIGNAGE IMAGES"
Write-Host "=========================================="
Write-Host "Total images to download: $totalImages"
Write-Host "Output directory: $outputDir"
Write-Host ""

foreach ($image in $images) {
    $url = $image.url
    $filename = $image.file
    $outputPath = Join-Path $outputDir $filename
    
    try {
        Write-Host "Downloading $filename... " -NoNewline
        Invoke-WebRequest -Uri $url -OutFile $outputPath -UseBasicParsing -TimeoutSec 30 -ErrorAction Stop
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

Write-Host ""
Write-Host "=========================================="
Write-Host "DOWNLOAD SUMMARY"
Write-Host "=========================================="
Write-Host "Total images: $totalImages"
Write-Host "Success: $successCount" -ForegroundColor Green
Write-Host "Failed: $failCount" -ForegroundColor Red
Write-Host "=========================================="
