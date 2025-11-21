# Upload all 50 product images to Directus file library via API
# Captures UUID file IDs for updating products.json

$directusUrl = "http://localhost:8055"
$adminEmail = "admin@example.com"
$adminPassword = "admin123"
$imagesDir = "C:\Users\grube\WebstormProjects\prem-lichtwerbung\frontend\public\images\products"
$outputFile = "C:\Users\grube\WebstormProjects\prem-lichtwerbung\image-uuid-mapping.json"

Write-Host "=========================================="
Write-Host "UPLOADING IMAGES TO DIRECTUS FILE LIBRARY"
Write-Host "=========================================="
Write-Host ""

# Step 1: Authenticate
Write-Host "Authenticating with Directus..." -NoNewline
try {
    $authBody = @{
        email = $adminEmail
        password = $adminPassword
    } | ConvertTo-Json

    $authResponse = Invoke-WebRequest -Uri "$directusUrl/auth/login" `
        -Method POST `
        -ContentType "application/json" `
        -Body $authBody `
        -UseBasicParsing

    $token = ($authResponse.Content | ConvertFrom-Json).data.access_token
    
    if (-not $token) {
        throw "Failed to get access token"
    }
    
    Write-Host " OK" -ForegroundColor Green
    Write-Host "Access token obtained: $($token.Substring(0,20))..." -ForegroundColor Gray
}
catch {
    Write-Host " FAILED" -ForegroundColor Red
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

# Step 2: Get all image files
Write-Host ""
Write-Host "Scanning images directory..." -NoNewline
$imageFiles = Get-ChildItem -Path $imagesDir -Filter "*.jpg" | Sort-Object Name

if ($imageFiles.Count -eq 0) {
    Write-Host " FAILED" -ForegroundColor Red
    Write-Host "No image files found in $imagesDir" -ForegroundColor Red
    exit 1
}

Write-Host " OK" -ForegroundColor Green
Write-Host "Found $($imageFiles.Count) images to upload" -ForegroundColor Gray
Write-Host ""

# Step 3: Upload images and capture UUIDs
$headers = @{
    Authorization = "Bearer $token"
}

$uuidMapping = @{}
$successCount = 0
$failCount = 0

foreach ($imageFile in $imageFiles) {
    $filename = $imageFile.Name
    $filepath = $imageFile.FullName
    
    Write-Host "Uploading $filename... " -NoNewline
    
    try {
        # Create multipart form data
        $boundary = [System.Guid]::NewGuid().ToString()
        $fileBin = [System.IO.File]::ReadAllBytes($filepath)
        $enc = [System.Text.Encoding]::GetEncoding("iso-8859-1")
        
        $bodyLines = @(
            "--$boundary",
            "Content-Disposition: form-data; name=`"file`"; filename=`"$filename`"",
            "Content-Type: image/jpeg",
            "",
            $enc.GetString($fileBin),
            "--$boundary--"
        ) -join "`r`n"
        
        $response = Invoke-WebRequest -Uri "$directusUrl/files" `
            -Method POST `
            -Headers $headers `
            -ContentType "multipart/form-data; boundary=$boundary" `
            -Body $bodyLines `
            -UseBasicParsing
        
        $fileData = ($response.Content | ConvertFrom-Json).data
        $fileId = $fileData.id
        
        if ($fileId) {
            $uuidMapping[$filename] = $fileId
            Write-Host "OK (UUID: $fileId)" -ForegroundColor Green
            $successCount++
        }
        else {
            throw "No file ID returned"
        }
    }
    catch {
        Write-Host "FAILED" -ForegroundColor Red
        Write-Host "  Error: $($_.Exception.Message)" -ForegroundColor Red
        $failCount++
    }
    
    Start-Sleep -Milliseconds 200
}

# Step 4: Save UUID mapping to JSON file
Write-Host ""
Write-Host "Saving UUID mapping to $outputFile..." -NoNewline
try {
    $uuidMapping | ConvertTo-Json -Depth 10 | Set-Content $outputFile
    Write-Host " OK" -ForegroundColor Green
}
catch {
    Write-Host " FAILED" -ForegroundColor Red
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
}

# Summary
Write-Host ""
Write-Host "=========================================="
Write-Host "UPLOAD SUMMARY"
Write-Host "=========================================="
Write-Host "Total images: $($imageFiles.Count)"
Write-Host "Success: $successCount" -ForegroundColor Green
Write-Host "Failed: $failCount" -ForegroundColor Red
Write-Host "Mapping saved to: $outputFile"
Write-Host "=========================================="
Write-Host ""

if ($successCount -gt 0) {
    Write-Host "Sample UUID mappings:" -ForegroundColor Cyan
    $uuidMapping.GetEnumerator() | Select-Object -First 5 | ForEach-Object {
        Write-Host "  $($_.Key) -> $($_.Value)" -ForegroundColor Gray
    }
}
