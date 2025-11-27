# Generate favicons from colored logo
Add-Type -AssemblyName System.Drawing

$sourcePath = "C:\Users\grube\WebstormProjects\prem-lichtwerbung\frontend\public\logo.png"
$outputDir = "C:\Users\grube\WebstormProjects\prem-lichtwerbung\frontend\public"

# Favicon sizes to generate
$sizes = @(16, 32, 192, 512)

Write-Host "=========================================="
Write-Host "GENERATING FAVICONS"
Write-Host "=========================================="
Write-Host "Source: $sourcePath"
Write-Host "Output directory: $outputDir"
Write-Host ""

try {
    # Load the source logo
    $sourceImage = [System.Drawing.Image]::FromFile($sourcePath)
    
    Write-Host "Source image dimensions: $($sourceImage.Width)x$($sourceImage.Height)" -ForegroundColor Yellow
    Write-Host ""
    
    foreach ($size in $sizes) {
        $outputPath = Join-Path $outputDir "favicon-${size}x${size}.png"
        
        Write-Host "Generating ${size}x${size}..." -ForegroundColor Cyan
        
        # Create a square canvas with the target size
        $favicon = New-Object System.Drawing.Bitmap($size, $size)
        $graphics = [System.Drawing.Graphics]::FromImage($favicon)
        
        # Set high quality rendering
        $graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
        $graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
        $graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
        $graphics.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
        
        # Fill with transparent background
        $graphics.Clear([System.Drawing.Color]::Transparent)
        
        # Calculate scaling to fit logo in square while maintaining aspect ratio
        $sourceAspect = $sourceImage.Width / $sourceImage.Height
        $targetAspect = 1.0 # Square
        
        if ($sourceAspect -gt $targetAspect) {
            # Source is wider - fit to width
            $drawWidth = $size
            $drawHeight = [int]($size / $sourceAspect)
            $drawX = 0
            $drawY = [int](($size - $drawHeight) / 2)
        } else {
            # Source is taller or equal - fit to height
            $drawHeight = $size
            $drawWidth = [int]($size * $sourceAspect)
            $drawX = [int](($size - $drawWidth) / 2)
            $drawY = 0
        }
        
        # Draw the logo centered in the square
        $destRect = New-Object System.Drawing.Rectangle($drawX, $drawY, $drawWidth, $drawHeight)
        $srcRect = New-Object System.Drawing.Rectangle(0, 0, $sourceImage.Width, $sourceImage.Height)
        
        $graphics.DrawImage($sourceImage, $destRect, $srcRect, [System.Drawing.GraphicsUnit]::Pixel)
        
        # Save the favicon
        $favicon.Save($outputPath, [System.Drawing.Imaging.ImageFormat]::Png)
        
        Write-Host "  ✅ Saved: favicon-${size}x${size}.png" -ForegroundColor Green
        
        # Clean up
        $graphics.Dispose()
        $favicon.Dispose()
    }
    
    # Generate favicon.ico (16x16 + 32x32 combined)
    Write-Host ""
    Write-Host "Generating favicon.ico (multi-resolution)..." -ForegroundColor Cyan
    
    # Load the 16x16 and 32x32 versions
    $icon16Path = Join-Path $outputDir "favicon-16x16.png"
    $icon32Path = Join-Path $outputDir "favicon-32x32.png"
    
    # Note: PowerShell doesn't have native .ico creation with multiple sizes
    # We'll create a simple 32x32 .ico file
    $icon32 = [System.Drawing.Image]::FromFile($icon32Path)
    $iconPath = Join-Path $outputDir "favicon.ico"
    
    # Convert to icon format (simple 32x32)
    $icon32.Save($iconPath, [System.Drawing.Imaging.ImageFormat]::Icon)
    $icon32.Dispose()
    
    Write-Host "  ✅ Saved: favicon.ico" -ForegroundColor Green
    
    # Clean up
    $sourceImage.Dispose()
    
    Write-Host ""
    Write-Host "=========================================="
    Write-Host "✅ ALL FAVICONS GENERATED SUCCESSFULLY!" -ForegroundColor Green
    Write-Host "=========================================="
    Write-Host "Generated files:" -ForegroundColor Cyan
    Write-Host "  - favicon.ico (32x32)"
    Write-Host "  - favicon-16x16.png"
    Write-Host "  - favicon-32x32.png"
    Write-Host "  - favicon-192x192.png (Android)"
    Write-Host "  - favicon-512x512.png (Android/PWA)"
    
} catch {
    Write-Host "❌ Error generating favicons: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}
