# Test Stability AI API key
$apiKey = "sk-YF6DgKcNQcBEBWPX1IY8JHA46qVpX9lec6lAQGNjqYkS5Icy"
$apiUrl = "https://api.stability.ai/v1/generation/stable-diffusion-xl-1024-v1-0/text-to-image"

Write-Host "=========================================="
Write-Host "TESTING STABILITY AI API"
Write-Host "=========================================="
Write-Host "API Endpoint: $apiUrl"
Write-Host ""

$testPrompt = "Professional LED lightbox sign on white background, product photography, 4k, no people"

Write-Host "Sending test request with prompt:"
Write-Host "  '$testPrompt'"
Write-Host ""

try {
    $body = @{
        text_prompts = @(
            @{
                text = $testPrompt
                weight = 1
            }
        )
        cfg_scale = 7
        height = 1024
        width = 1024
        steps = 30
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
        -TimeoutSec 60
    
    Write-Host "✅ SUCCESS! API key is valid" -ForegroundColor Green
    Write-Host ""
    Write-Host "Response structure:" -ForegroundColor Cyan
    Write-Host "  - artifacts: $($response.artifacts.Count) image(s)"
    
    if ($response.artifacts -and $response.artifacts.Count -gt 0) {
        Write-Host "  - base64 length: $($response.artifacts[0].base64.Length) characters"
        Write-Host "  - seed: $($response.artifacts[0].seed)"
        Write-Host "  - finishReason: $($response.artifacts[0].finishReason)"
    }
    
    Write-Host ""
    Write-Host "✅ API is working correctly!" -ForegroundColor Green
    Write-Host "Ready to generate all 50 product images." -ForegroundColor Green
    
} catch {
    Write-Host "❌ API TEST FAILED" -ForegroundColor Red
    Write-Host ""
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
    
    if ($_.Exception.Response) {
        $statusCode = $_.Exception.Response.StatusCode.value__
        Write-Host "Status Code: $statusCode" -ForegroundColor Red
        
        $reader = New-Object System.IO.StreamReader($_.Exception.Response.GetResponseStream())
        $responseBody = $reader.ReadToEnd()
        Write-Host "Response: $responseBody" -ForegroundColor Red
    }
}
