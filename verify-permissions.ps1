# Directus Public Role Permission Verification Script
# This script checks all permissions for the Public role and identifies configuration issues

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Directus Public Role Permission Checker" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

try {
    # Authenticate
    Write-Host "🔑 Authenticating..." -ForegroundColor Yellow
    $authResponse = Invoke-RestMethod -Uri "http://localhost:8055/auth/login" -Method POST -ContentType "application/json" -Body '{"email":"admin@example.com","password":"admin123"}'
    $token = $authResponse.data.access_token
    $headers = @{ "Authorization" = "Bearer $token" }
    Write-Host "✅ Authenticated successfully" -ForegroundColor Green
    Write-Host ""

    # Get all permissions
    Write-Host "📋 Fetching all permissions..." -ForegroundColor Yellow
    $permissions = Invoke-RestMethod -Uri "http://localhost:8055/permissions?limit=50" -Method GET -Headers $headers
    $publicPerms = $permissions.data | Where-Object { $null -eq $_.role }
    
    Write-Host "✅ Found $($publicPerms.Count) Public role permissions" -ForegroundColor Green
    Write-Host ""

    # Check required collections
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "Required Permissions Check" -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""

    $requiredRead = @(
        "products",
        "categories", 
        "tags",
        "products_categories",
        "products_tags",
        "reviews",
        "pages",
        "banners",
        "settings",
        "directus_files"
    )

    $requiredCreate = @(
        "customers",
        "orders"
    )

    foreach ($collection in $requiredRead) {
        $perm = $publicPerms | Where-Object { $_.collection -eq $collection -and $_.action -eq "read" }
        if ($perm) {
            $fields = if ($perm.fields -contains "*") { "All Fields (*)" } else { "$($perm.fields.Count) fields: $($perm.fields -join ', ')" }
            $filter = if ($null -eq $perm.permissions -or ($perm.permissions | ConvertTo-Json -Compress) -eq "{}") { "Empty ({})" } else { $perm.permissions | ConvertTo-Json -Compress }
            Write-Host "  ✅ $collection (read)" -ForegroundColor Green
            Write-Host "     Fields: $fields" -ForegroundColor Gray
            Write-Host "     Filter: $filter" -ForegroundColor Gray
        } else {
            Write-Host "  ❌ $collection (read) - MISSING!" -ForegroundColor Red
        }
    }

    Write-Host ""

    foreach ($collection in $requiredCreate) {
        $perm = $publicPerms | Where-Object { $_.collection -eq $collection -and $_.action -eq "create" }
        if ($perm) {
            $fields = "$($perm.fields.Count) fields: $($perm.fields -join ', ')"
            Write-Host "  ✅ $collection (create)" -ForegroundColor Green
            Write-Host "     Fields: $fields" -ForegroundColor Gray
        } else {
            Write-Host "  ❌ $collection (create) - MISSING!" -ForegroundColor Red
        }
    }

    Write-Host ""
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "Junction Table Field Check" -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""

    # Check products_categories fields
    $prodCatPerm = $publicPerms | Where-Object { $_.collection -eq "products_categories" -and $_.action -eq "read" }
    if ($prodCatPerm) {
        Write-Host "products_categories permission:" -ForegroundColor Yellow
        if ($prodCatPerm.fields -contains "*") {
            Write-Host "  ⚠️  Using 'All Fields' (*)" -ForegroundColor Yellow
            Write-Host "  💡 Recommendation: Change to explicit fields: id, products_id, categories_id" -ForegroundColor Cyan
        } else {
            $hasId = $prodCatPerm.fields -contains "id"
            $hasProductsId = $prodCatPerm.fields -contains "products_id"
            $hasCategoriesId = $prodCatPerm.fields -contains "categories_id"
            
            if ($hasId -and $hasProductsId -and $hasCategoriesId) {
                Write-Host "  ✅ Correct explicit fields: $($prodCatPerm.fields -join ', ')" -ForegroundColor Green
            } else {
                Write-Host "  ❌ Missing required fields!" -ForegroundColor Red
                Write-Host "     Current: $($prodCatPerm.fields -join ', ')" -ForegroundColor Gray
                Write-Host "     Required: id, products_id, categories_id" -ForegroundColor Gray
            }
        }
    }
    Write-Host ""

    # Check products_tags fields
    $prodTagsPerm = $publicPerms | Where-Object { $_.collection -eq "products_tags" -and $_.action -eq "read" }
    if ($prodTagsPerm) {
        Write-Host "products_tags permission:" -ForegroundColor Yellow
        if ($prodTagsPerm.fields -contains "*") {
            Write-Host "  ⚠️  Using 'All Fields' (*)" -ForegroundColor Yellow
            Write-Host "  💡 Recommendation: Change to explicit fields: id, products_id, tags_id" -ForegroundColor Cyan
        } else {
            $hasId = $prodTagsPerm.fields -contains "id"
            $hasProductsId = $prodTagsPerm.fields -contains "products_id"
            $hasTagsId = $prodTagsPerm.fields -contains "tags_id"
            
            if ($hasId -and $hasProductsId -and $hasTagsId) {
                Write-Host "  ✅ Correct explicit fields: $($prodTagsPerm.fields -join ', ')" -ForegroundColor Green
            } else {
                Write-Host "  ❌ Missing required fields!" -ForegroundColor Red
                Write-Host "     Current: $($prodTagsPerm.fields -join ', ')" -ForegroundColor Gray
                Write-Host "     Required: id, products_id, tags_id" -ForegroundColor Gray
            }
        }
    }
    Write-Host ""

    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "Summary" -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Total permissions: $($publicPerms.Count)" -ForegroundColor White
    Write-Host "Expected: 12 (10 read + 2 create)" -ForegroundColor White
    Write-Host ""

    if ($publicPerms.Count -eq 12) {
        Write-Host "✅ Permission count is correct" -ForegroundColor Green
    } else {
        Write-Host "⚠️  Permission count mismatch!" -ForegroundColor Yellow
    }

} catch {
    Write-Host "❌ Error: $($_.Exception.Message)" -ForegroundColor Red
}
