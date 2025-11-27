# Generate Header Images for Pages using Stability AI API
$apiKey = "sk-YF6DgKcNQcBEBWPX1IY8JHA46qVpX9lec6lAQGNjqYkS5Icy"
$apiUrl = "https://api.stability.ai/v1/generation/stable-diffusion-xl-1024-v1-0/text-to-image"

Write-Host "=========================================="
Write-Host "GENERATING HEADER IMAGES"
Write-Host "=========================================="
Write-Host ""

# Create output directory
$outputDir = "frontend\public\headers"
if (-not (Test-Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir -Force | Out-Null
    Write-Host "✅ Created directory: $outputDir" -ForegroundColor Green
}

# Define header images to generate
$headerImages = @(
    @{
        name = "home-hero"
        prompt = "Cinematic wide shot of illuminated business signage at dusk, modern LED channel letters and lightboxes glowing on contemporary building facades, professional commercial photography, dramatic blue hour lighting, premium architectural photography, ultra wide angle, 8K quality, shallow depth of field"
        filename = "home-hero.jpg"
    },
    @{
        name = "about-hero"
        prompt = "Professional workshop interior with illuminated signage being crafted, LED channel letters and lightboxes in production, skilled craftsmen working, modern manufacturing facility, warm industrial lighting, professional commercial photography, ultra wide angle, 8K quality"
        filename = "about-hero.jpg"
    },
    @{
        name = "products-hero"
        prompt = "Stunning variety of illuminated signage products display, LED lightboxes, neon signs, channel letters, pylon signs showcased together, professional product photography, dramatic lighting, modern commercial setting, ultra wide angle, 8K quality, premium presentation"
        filename = "products-hero.jpg"
    },
    @{
        name = "contact-hero"
        prompt = "Welcoming modern storefront with elegant illuminated signage at evening, warm inviting glow from LED signs and lights, professional commercial photography, contemporary architecture, blue hour lighting, ultra wide angle, 8K quality, inviting atmosphere"
        filename = "contact-hero.jpg"
    }
)

$successCount = 0
$failCount = 0

foreach ($image in $headerImages) {
    Write-Host "----------------------------------------"
    Write-Host "Generating: $($image.name)" -ForegroundColor Cyan
    Write-Host "Prompt: $($image.prompt)" -ForegroundColor Gray
    Write-Host ""
    
    try {
        $body = @{
            text_prompts = @(
                @{
                    text = $image.prompt
                    weight = 1
                }
            )
            cfg_scale = 7
            height = 640
            width = 1536
            steps = 40
            samples = 1
        } | ConvertTo-Json -Depth 10
        
        $headers = @{
            "Authorization" = "Bearer $apiKey"
            "Content-Type" = "application/json"
            "Accept" = "application/json"
        }
        
        Write-Host "Making API request..." -ForegroundColor Yellow
        
        $response = Invoke-RestMethod -Uri $apiUrl `
            -Method POST `
            -Headers $headers `
            -Body $body `
            -TimeoutSec 90
        
        if ($response.artifacts -and $response.artifacts.Count -gt 0) {
            # Decode base64 image and save
            $base64Image = $response.artifacts[0].base64
            $imageBytes = [Convert]::FromBase64String($base64Image)
            $outputPath = Join-Path $outputDir $image.filename
            [IO.File]::WriteAllBytes($outputPath, $imageBytes)
            
            Write-Host "✅ SUCCESS: Saved to $outputPath" -ForegroundColor Green
            Write-Host "   Seed: $($response.artifacts[0].seed)" -ForegroundColor Gray
            $successCount++
        } else {
            Write-Host "❌ FAILED: No image data in response" -ForegroundColor Red
            $failCount++
        }
        
        # Brief pause between API calls
        Start-Sleep -Seconds 2
        
    } catch {
        Write-Host "❌ FAILED: $($_.Exception.Message)" -ForegroundColor Red
        
        if ($_.Exception.Response) {
            $statusCode = $_.Exception.Response.StatusCode.value__
            Write-Host "   Status Code: $statusCode" -ForegroundColor Red
            
            try {
                $reader = New-Object System.IO.StreamReader($_.Exception.Response.GetResponseStream())
                $responseBody = $reader.ReadToEnd()
                Write-Host "   Response: $responseBody" -ForegroundColor Red
            } catch {
                # Ignore stream read errors
            }
        }
        $failCount++
    }
    
    Write-Host ""
}

Write-Host "=========================================="
Write-Host "GENERATION COMPLETE"
Write-Host "=========================================="
Write-Host "✅ Success: $successCount images" -ForegroundColor Green
Write-Host "❌ Failed: $failCount images" -ForegroundColor Red
Write-Host ""
Write-Host "Images saved to: $outputDir"
