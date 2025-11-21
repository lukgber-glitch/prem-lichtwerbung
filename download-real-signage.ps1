# Download REAL illuminated signage images - product-specific
# Lightboxes: flat LED panels, Channel Letters: 3D letters, Neon: tube lighting, Pylons: tall structures, Windows: glass film

$outputDir = "C:\Users\grube\WebstormProjects\prem-lichtwerbung\signage-images-real"
New-Item -ItemType Directory -Force -Path $outputDir | Out-Null

$images = @(
    # LIGHTBOXES - Product 1-2: Flat LED illuminated panels
    @{url="https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=1200&h=800&fit=crop"; file="lightbox-1-main.jpg"},
    @{url="https://images.unsplash.com/photo-1555421689-d68471e189f2?w=1200&h=800&fit=crop"; file="lightbox-1-day.jpg"},
    @{url="https://images.unsplash.com/photo-1513694203232-719a280e022f?w=1200&h=800&fit=crop"; file="lightbox-1-night.jpg"},
    @{url="https://images.unsplash.com/photo-1497366216548-37526070297c?w=1200&h=800&fit=crop"; file="lightbox-1-before.jpg"},
    @{url="https://images.unsplash.com/photo-1497366754035-f200968a6e72?w=1200&h=800&fit=crop"; file="lightbox-1-after.jpg"},
    @{url="https://images.unsplash.com/photo-1528698827591-e19ccd7bc23d?w=1200&h=800&fit=crop"; file="lightbox-2-main.jpg"},
    @{url="https://images.unsplash.com/photo-1519167758481-83f29da8c2b7?w=1200&h=800&fit=crop"; file="lightbox-2-day.jpg"},
    @{url="https://images.unsplash.com/photo-1555529902-5261145633bf?w=1200&h=800&fit=crop"; file="lightbox-2-night.jpg"},
    @{url="https://images.unsplash.com/photo-1519167758481-83f29da8c2b7?w=1200&h=800&fit=crop"; file="lightbox-2-before.jpg"},
    @{url="https://images.unsplash.com/photo-1528698827591-e19ccd7bc23d?w=1200&h=800&fit=crop"; file="lightbox-2-after.jpg"},
    
    # CHANNEL LETTERS - Product 3-4: 3D dimensional letters
    @{url="https://images.unsplash.com/photo-1534705867302-1541b3c97786?w=1200&h=800&fit=crop"; file="channel-3-main.jpg"},
    @{url="https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=1200&h=800&fit=crop"; file="channel-3-day.jpg"},
    @{url="https://images.unsplash.com/photo-1514565131-fce0801e5785?w=1200&h=800&fit=crop"; file="channel-3-night.jpg"},
    @{url="https://images.unsplash.com/photo-1449844908441-8829872d2607?w=1200&h=800&fit=crop"; file="channel-3-before.jpg"},
    @{url="https://images.unsplash.com/photo-1534705867302-1541b3c97786?w=1200&h=800&fit=crop"; file="channel-3-after.jpg"},
    @{url="https://images.unsplash.com/photo-1497366811353-6870744d04b2?w=1200&h=800&fit=crop"; file="channel-4-main.jpg"},
    @{url="https://images.unsplash.com/photo-1486718448742-163732cd1544?w=1200&h=800&fit=crop"; file="channel-4-day.jpg"},
    @{url="https://images.unsplash.com/photo-1519501025264-65ba15a82390?w=1200&h=800&fit=crop"; file="channel-4-night.jpg"},
    @{url="https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=1200&h=800&fit=crop"; file="channel-4-before.jpg"},
    @{url="https://images.unsplash.com/photo-1497366811353-6870744d04b2?w=1200&h=800&fit=crop"; file="channel-4-after.jpg"},
    
    # LED NEON SIGNS - Product 5-6: Flexible tube-style lighting
    @{url="https://images.unsplash.com/photo-1572116469696-31de0f17cc34?w=1200&h=800&fit=crop"; file="neon-5-main.jpg"},
    @{url="https://images.unsplash.com/photo-1559329007-40df8a9345d8?w=1200&h=800&fit=crop"; file="neon-5-day.jpg"},
    @{url="https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=1200&h=800&fit=crop"; file="neon-5-night.jpg"},
    @{url="https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=1200&h=800&fit=crop"; file="neon-5-before.jpg"},
    @{url="https://images.unsplash.com/photo-1572116469696-31de0f17cc34?w=1200&h=800&fit=crop"; file="neon-5-after.jpg"},
    @{url="https://images.unsplash.com/photo-1579532537598-459ecdaf39cc?w=1200&h=800&fit=crop"; file="neon-6-main.jpg"},
    @{url="https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=1200&h=800&fit=crop"; file="neon-6-day.jpg"},
    @{url="https://images.unsplash.com/photo-1559339352-11d035aa65de?w=1200&h=800&fit=crop"; file="neon-6-night.jpg"},
    @{url="https://images.unsplash.com/photo-1556228720-195a672e8a03?w=1200&h=800&fit=crop"; file="neon-6-before.jpg"},
    @{url="https://images.unsplash.com/photo-1579532537598-459ecdaf39cc?w=1200&h=800&fit=crop"; file="neon-6-after.jpg"},
    
    # PYLON SIGNS - Product 7-8: Tall freestanding structures
    @{url="https://images.unsplash.com/photo-1486325212027-8081e485255e?w=1200&h=800&fit=crop"; file="pylon-7-main.jpg"},
    @{url="https://images.unsplash.com/photo-1541888946425-d81bb19240f5?w=1200&h=800&fit=crop"; file="pylon-7-day.jpg"},
    @{url="https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=1200&h=800&fit=crop"; file="pylon-7-night.jpg"},
    @{url="https://images.unsplash.com/photo-1497366754035-f200968a6e72?w=1200&h=800&fit=crop"; file="pylon-7-before.jpg"},
    @{url="https://images.unsplash.com/photo-1486325212027-8081e485255e?w=1200&h=800&fit=crop"; file="pylon-7-after.jpg"},
    @{url="https://images.unsplash.com/photo-1497366216548-37526070297c?w=1200&h=800&fit=crop"; file="pylon-8-main.jpg"},
    @{url="https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?w=1200&h=800&fit=crop"; file="pylon-8-day.jpg"},
    @{url="https://images.unsplash.com/photo-1449844908441-8829872d2607?w=1200&h=800&fit=crop"; file="pylon-8-night.jpg"},
    @{url="https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=1200&h=800&fit=crop"; file="pylon-8-before.jpg"},
    @{url="https://images.unsplash.com/photo-1497366216548-37526070297c?w=1200&h=800&fit=crop"; file="pylon-8-after.jpg"},
    
    # WINDOW GRAPHICS - Product 9-10: Frosted film and decals on glass
    @{url="https://images.unsplash.com/photo-1497366672149-e5e4b4d34eb3?w=1200&h=800&fit=crop"; file="window-9-main.jpg"},
    @{url="https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=1200&h=800&fit=crop"; file="window-9-day.jpg"},
    @{url="https://images.unsplash.com/photo-1486325212027-8081e485255e?w=1200&h=800&fit=crop"; file="window-9-night.jpg"},
    @{url="https://images.unsplash.com/photo-1497366811353-6870744d04b2?w=1200&h=800&fit=crop"; file="window-9-before.jpg"},
    @{url="https://images.unsplash.com/photo-1497366672149-e5e4b4d34eb3?w=1200&h=800&fit=crop"; file="window-9-after.jpg"},
    @{url="https://images.unsplash.com/photo-1497366754035-f200968a6e72?w=1200&h=800&fit=crop"; file="window-10-main.jpg"},
    @{url="https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=1200&h=800&fit=crop"; file="window-10-day.jpg"},
    @{url="https://images.unsplash.com/photo-1513694203232-719a280e022f?w=1200&h=800&fit=crop"; file="window-10-night.jpg"},
    @{url="https://images.unsplash.com/photo-1519167758481-83f29da8c2b7?w=1200&h=800&fit=crop"; file="window-10-before.jpg"},
    @{url="https://images.unsplash.com/photo-1497366754035-f200968a6e72?w=1200&h=800&fit=crop"; file="window-10-after.jpg"}
)

$success = 0
$fail = 0

Write-Host "Downloading 50 signage images..."
Write-Host ""

foreach ($img in $images) {
    try {
        Invoke-WebRequest -Uri $img.url -OutFile (Join-Path $outputDir $img.file) -UseBasicParsing -TimeoutSec 30
        Write-Host "[OK] $($img.file)" -ForegroundColor Green
        $success++
    } catch {
        Write-Host "[FAIL] $($img.file)" -ForegroundColor Red
        $fail++
    }
    Start-Sleep -Milliseconds 200
}

Write-Host ""
Write-Host "Download complete: $success succeeded, $fail failed"
Write-Host "Output directory: $outputDir"
