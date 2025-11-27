# Recolor logo from white to primary red (#ab3930)
Add-Type -AssemblyName System.Drawing

$sourcePath = "C:\Users\grube\Downloads\logo_lichtwerbung.png"
$outputPath = "C:\Users\grube\WebstormProjects\prem-lichtwerbung\frontend\public\logo.png"

# Target color: primary red #ab3930
$targetR = 0xab
$targetG = 0x39
$targetB = 0x30

Write-Host "Recoloring logo..." -ForegroundColor Cyan
Write-Host "Source: $sourcePath"
Write-Host "Output: $outputPath"
Write-Host "Target color: #ab3930 (RGB: $targetR, $targetG, $targetB)"
Write-Host ""

try {
    # Load the source image
    $sourceImage = [System.Drawing.Image]::FromFile($sourcePath)
    $bitmap = New-Object System.Drawing.Bitmap($sourceImage)
    
    Write-Host "Image dimensions: $($bitmap.Width)x$($bitmap.Height)" -ForegroundColor Yellow
    Write-Host "Processing pixels..." -ForegroundColor Yellow
    
    $pixelsChanged = 0
    
    # Process each pixel
    for ($y = 0; $y -lt $bitmap.Height; $y++) {
        for ($x = 0; $x -lt $bitmap.Width; $x++) {
            $pixel = $bitmap.GetPixel($x, $y)
            
            # Check if pixel is white or near-white (handles anti-aliasing)
            if ($pixel.R -gt 200 -and $pixel.G -gt 200 -and $pixel.B -gt 200 -and $pixel.A -gt 0) {
                # Calculate brightness factor to preserve anti-aliasing
                $brightnessFactor = ($pixel.R + $pixel.G + $pixel.B) / (255 * 3)
                
                # Apply target color with brightness factor
                $newR = [Math]::Min(255, [int]($targetR * $brightnessFactor))
                $newG = [Math]::Min(255, [int]($targetG * $brightnessFactor))
                $newB = [Math]::Min(255, [int]($targetB * $brightnessFactor))
                
                $newColor = [System.Drawing.Color]::FromArgb($pixel.A, $newR, $newG, $newB)
                $bitmap.SetPixel($x, $y, $newColor)
                $pixelsChanged++
            }
        }
    }
    
    Write-Host "Pixels recolored: $pixelsChanged" -ForegroundColor Green
    
    # Ensure output directory exists
    $outputDir = Split-Path -Parent $outputPath
    if (-not (Test-Path $outputDir)) {
        New-Item -ItemType Directory -Path $outputDir -Force | Out-Null
    }
    
    # Save the recolored image
    $bitmap.Save($outputPath, [System.Drawing.Imaging.ImageFormat]::Png)
    
    # Clean up
    $bitmap.Dispose()
    $sourceImage.Dispose()
    
    Write-Host ""
    Write-Host "✅ Logo recolored successfully!" -ForegroundColor Green
    Write-Host "Saved to: $outputPath"
    
} catch {
    Write-Host "❌ Error recoloring logo: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}
