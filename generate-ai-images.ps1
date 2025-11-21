# Generate AI images for all 50 product images using Stability AI API
# Working PowerShell script with validated API key

$apiKey = "sk-YF6DgKcNQcBEBWPX1IY8JHA46qVpX9lec6lAQGNjqYkS5Icy"
$apiUrl = "https://api.stability.ai/v1/generation/stable-diffusion-xl-1024-v1-0/text-to-image"
$outputDir = "C:\Users\grube\WebstormProjects\prem-lichtwerbung\ai-generated-images"

# Ensure output directory exists
New-Item -ItemType Directory -Force -Path $outputDir | Out-Null

Write-Host "=========================================="
Write-Host "AI IMAGE GENERATION - STABILITY AI"
Write-Host "=========================================="
Write-Host "Output directory: $outputDir"
Write-Host "API: Stability AI (stable-diffusion-xl)"
Write-Host ""

# Define all 50 prompts as simple array
$prompts = @(
    # Product 1: Single-Sided LED Lightbox
    @{file="product-1-primary.jpg"; prompt="Professional LED lightbox sign, flat illuminated panel on storefront facade, rectangular aluminum frame with even backlight, modern commercial signage, product photography on white background, 4k, ultra realistic, no people"},
    @{file="product-1-day.jpg"; prompt="LED lightbox mounted on modern storefront, daytime exterior view, bright sunlight, business signage visible but not glowing, commercial building facade, professional architectural photography, no people"},
    @{file="product-1-night.jpg"; prompt="Illuminated LED lightbox glowing at night, bright even panel lighting, storefront exterior, dark evening background, sign stands out dramatically, commercial photography, no people"},
    @{file="product-1-before.jpg"; prompt="Plain modern commercial building facade, no signage, clean architectural exterior, daytime, professional photography, no people"},
    @{file="product-1-after.jpg"; prompt="Same building facade with LED lightbox sign installed, branded storefront, professional signage upgrade, daytime, architectural photography, no people"},
    
    # Product 2: Double-Sided LED Lightbox
    @{file="product-2-primary.jpg"; prompt="Double-sided LED lightbox hanging sign, suspended from ceiling, visible from both sides, mall or shopping center installation, product photography, 4k, no people"},
    @{file="product-2-day.jpg"; prompt="Double-sided lightbox in shopping mall, daytime interior, natural and artificial lighting, hanging sign visible from below, commercial space, no people"},
    @{file="product-2-night.jpg"; prompt="Double-sided LED lightbox illuminated at night, glowing from both faces, suspended sign in commercial space, dramatic lighting, no people"},
    @{file="product-2-before.jpg"; prompt="Shopping mall interior without signage, clean modern space, architectural photography, no people"},
    @{file="product-2-after.jpg"; prompt="Same mall with double-sided lightbox installed, hanging branded signage, commercial upgrade, no people"},
    
    # Product 3: Front-Lit Channel Letters
    @{file="product-3-primary.jpg"; prompt="3D illuminated channel letters, dimensional letters mounted on building, front-lit LED signage, individual letter installation, professional signage photography, 4k, no people"},
    @{file="product-3-day.jpg"; prompt="3D channel letters on building facade, daytime exterior, dimensional letters visible with depth and shadow, modern commercial building, architectural photography, no people"},
    @{file="product-3-night.jpg"; prompt="Front-lit channel letters glowing at night, 3D illuminated letters on building, bright LED faces, dark background, commercial signage at night, no people"},
    @{file="product-3-before.jpg"; prompt="Commercial building facade without signage, clean modern exterior wall, architectural photography, no people"},
    @{file="product-3-after.jpg"; prompt="Same building with 3D channel letters installed, dimensional illuminated signage, professional upgrade, no people"},
    
    # Product 4: Halo-Lit Channel Letters
    @{file="product-4-primary.jpg"; prompt="Halo-lit channel letters with backlit glow effect, 3D dimensional letters with light halo behind each letter, premium signage, professional photography, 4k, no people"},
    @{file="product-4-day.jpg"; prompt="Halo-lit channel letters on premium building, daytime, 3D letters with visible mounting standoffs, modern corporate facade, architectural photography, no people"},
    @{file="product-4-night.jpg"; prompt="Halo-lit channel letters glowing at night, backlit halo glow effect around each letter, 3D dimensional signage, dark background, elegant lighting, no people"},
    @{file="product-4-before.jpg"; prompt="Premium commercial building facade without signage, modern architectural exterior, clean wall surface, no people"},
    @{file="product-4-after.jpg"; prompt="Same building with halo-lit channel letters installed, backlit glow signage, premium upgrade, no people"},
    
    # Product 5: Custom LED Neon Sign
    @{file="product-5-primary.jpg"; prompt="Custom LED neon sign, flexible tube-style lighting forming text or logo, modern LED neon technology, colorful vibrant glow, product photography on dark background, 4k, no people"},
    @{file="product-5-day.jpg"; prompt="LED neon sign in business interior, daytime with natural light, neon visible but not glowing strongly, window or wall mounting, commercial space, no people"},
    @{file="product-5-night.jpg"; prompt="LED neon sign glowing at night, vibrant colorful tubes, dramatic glow in dark interior, business signage illuminated, commercial photography, no people"},
    @{file="product-5-before.jpg"; prompt="Plain business interior wall or window, no signage, modern commercial space, no people"},
    @{file="product-5-after.jpg"; prompt="Same space with custom LED neon sign installed, colorful glowing signage, business branding upgrade, no people"},
    
    # Product 6: LED Neon Open Sign
    @{file="product-6-primary.jpg"; prompt="LED neon OPEN sign, classic open signage design, flexible neon tube style, bright colorful glow, product photography, 4k, no people"},
    @{file="product-6-day.jpg"; prompt="LED neon OPEN sign in storefront window, daytime exterior view, sign visible in window, retail shop, no people"},
    @{file="product-6-night.jpg"; prompt="LED neon OPEN sign glowing at night, bright colorful tubes spelling OPEN, storefront window, dark background, vibrant illumination, no people"},
    @{file="product-6-before.jpg"; prompt="Storefront window without signage, plain glass exterior, retail shop facade, no people"},
    @{file="product-6-after.jpg"; prompt="Same storefront with LED neon OPEN sign in window, welcoming signage, retail upgrade, no people"},
    
    # Product 7: Single-Post Pylon Sign
    @{file="product-7-primary.jpg"; prompt="Tall freestanding pylon sign, single post support, illuminated cabinet sign, 15-30 feet tall structure, professional signage photography, blue sky background, 4k, no people, no vehicles"},
    @{file="product-7-day.jpg"; prompt="Tall pylon sign at business park entrance, daytime, freestanding monument structure, blue sky, commercial property signage, architectural photography, no people"},
    @{file="product-7-night.jpg"; prompt="Illuminated pylon sign at night, tall glowing structure visible from distance, freestanding monument sign, dark sky background, commercial lighting, no people"},
    @{file="product-7-before.jpg"; prompt="Business park entrance without signage, plain property access road, landscape photography, no people"},
    @{file="product-7-after.jpg"; prompt="Same entrance with tall pylon sign installed, prominent wayfinding signage, commercial property upgrade, no people"},
    
    # Product 8: Monument Sign
    @{file="product-8-primary.jpg"; prompt="Low-profile monument sign, ground-level freestanding structure, stone or brick facade with illuminated panel, elegant corporate signage, professional photography, 4k, no people"},
    @{file="product-8-day.jpg"; prompt="Monument sign at corporate campus entrance, daytime, ground-level structure with stone facade, professional landscaping, architectural photography, no people"},
    @{file="product-8-night.jpg"; prompt="Illuminated monument sign at night, ground-level structure with lit panel, elegant lighting, corporate entrance signage, dark background, no people"},
    @{file="product-8-before.jpg"; prompt="Corporate campus entrance without signage, landscaped property access, architectural photography, no people"},
    @{file="product-8-after.jpg"; prompt="Same entrance with monument sign installed, elegant low-profile signage, corporate upgrade, no people"},
    
    # Product 9: Frosted Window Film
    @{file="product-9-primary.jpg"; prompt="Frosted window film with business logo, translucent privacy film on glass, modern office branding, partial window coverage, professional photography, 4k, no people"},
    @{file="product-9-day.jpg"; prompt="Frosted window film on storefront glass, daytime exterior view, privacy film with logo, modern commercial building, architectural photography, no people"},
    @{file="product-9-night.jpg"; prompt="Frosted window film with interior lighting, evening exterior view, backlit effect on glass, office or retail space, commercial photography, no people"},
    @{file="product-9-before.jpg"; prompt="Plain glass windows on commercial building, clear transparent glass, storefront or office exterior, no people"},
    @{file="product-9-after.jpg"; prompt="Same windows with frosted film applied, branded privacy glass, professional window graphics, no people"},
    
    # Product 10: Full-Color Window Decals
    @{file="product-10-primary.jpg"; prompt="Full-color printed window decals on storefront glass, vibrant graphics and branding, commercial window application, professional photography, 4k, no people"},
    @{file="product-10-day.jpg"; prompt="Window decals on storefront, daytime exterior view, full-color printed graphics on glass, retail or business facade, architectural photography, no people"},
    @{file="product-10-night.jpg"; prompt="Window decals with interior lighting at night, backlit graphics on glass, colorful window branding, commercial exterior, no people"},
    @{file="product-10-before.jpg"; prompt="Plain storefront windows without graphics, clear glass exterior, commercial building facade, no people"},
    @{file="product-10-after.jpg"; prompt="Same storefront with full-color window decals applied, vibrant branded graphics, commercial upgrade, no people"}
)

Write-Host "Total prompts defined: $($prompts.Count)"
Write-Host ""

$successCount = 0
$failCount = 0
$skippedCount = 0

foreach ($item in $prompts) {
    $filename = $item.file
    $prompt = $item.prompt
    $outputPath = Join-Path $outputDir $filename
    
    # Check if file already exists
    if (Test-Path $outputPath) {
        Write-Host "[SKIP] $filename (already exists)" -ForegroundColor Yellow
        $skippedCount++
        continue
    }
    
    Write-Host "Generating $filename..." -NoNewline
    
    try {
        # Prepare API request body (Stability AI format)
        $body = @{
            text_prompts = @(
                @{
                    text = $prompt
                    weight = 1
                }
            )
            cfg_scale = 7
            height = 1024
            width = 1024
            steps = 30
            samples = 1
        } | ConvertTo-Json -Depth 10
        
        # Make API request
        $response = Invoke-RestMethod -Uri $apiUrl `
            -Method POST `
            -Headers @{
                "Authorization" = "Bearer $apiKey"
                "Content-Type" = "application/json"
                "Accept" = "application/json"
            } `
            -Body $body `
            -TimeoutSec 60
        
        # Check if base64 image is in response
        if ($response.artifacts -and $response.artifacts[0].base64) {
            $base64Image = $response.artifacts[0].base64
            
            # Decode base64 and save to file
            $imageBytes = [Convert]::FromBase64String($base64Image)
            [System.IO.File]::WriteAllBytes($outputPath, $imageBytes)
            
            Write-Host " OK" -ForegroundColor Green
            $successCount++
        }
        else {
            throw "No base64 image in API response"
        }
        
        # Rate limiting - wait 3 seconds between requests
        Start-Sleep -Seconds 3
    }
    catch {
        Write-Host " FAILED" -ForegroundColor Red
        Write-Host "  Error: $($_.Exception.Message)" -ForegroundColor Red
        $failCount++
        
        # If rate limited, wait longer
        if ($_.Exception.Message -like "*rate limit*" -or $_.Exception.Message -like "*429*") {
            Write-Host "  Rate limited - waiting 60 seconds..." -ForegroundColor Yellow
            Start-Sleep -Seconds 60
        }
    }
}

Write-Host ""
Write-Host "=========================================="
Write-Host "GENERATION SUMMARY"
Write-Host "=========================================="
Write-Host "Total prompts: $($prompts.Count)"
Write-Host "Success: $successCount" -ForegroundColor Green
Write-Host "Skipped (already exist): $skippedCount" -ForegroundColor Yellow
Write-Host "Failed: $failCount" -ForegroundColor Red
Write-Host "Output directory: $outputDir"
Write-Host "=========================================="
Write-Host ""

if ($successCount -gt 0) {
    Write-Host "✅ Generated $successCount new images successfully!" -ForegroundColor Green
}

if ($failCount -gt 0) {
    Write-Host "⚠️  $failCount images failed to generate. You can re-run the script to retry." -ForegroundColor Yellow
}
