# Manual Image Upload and Assignment Guide

## Overview
This guide provides step-by-step instructions for manually uploading real illuminated signage images to Directus and assigning them to products via the admin panel.

**Date**: 2025-11-20  
**Total Images**: 50 (5 images per product × 10 products)  
**Image Location**: `C:\Users\grube\WebstormProjects\prem-lichtwerbung\signage-images-real\`

---

## Image Categories

### Product Types and Required Images

Each product needs 5 images:
1. **main** - Primary product photo (clean professional shot)
2. **day** - Product in daylight (bright, daytime lighting)
3. **night** - Product illuminated at night (glowing, dark background)
4. **before** - Before installation (plain facade/location)
5. **after** - After installation (with product installed)

### Downloaded Images by Category

**LIGHTBOXES (Products 1-2)**: Flat LED illuminated panels
- `lightbox-1-main.jpg`, `lightbox-1-day.jpg`, `lightbox-1-night.jpg`, `lightbox-1-before.jpg`, `lightbox-1-after.jpg`
- `lightbox-2-main.jpg`, `lightbox-2-day.jpg`, `lightbox-2-night.jpg`, `lightbox-2-before.jpg`, `lightbox-2-after.jpg`

**CHANNEL LETTERS (Products 3-4)**: 3D dimensional letters on buildings
- `channel-3-main.jpg`, `channel-3-day.jpg`, `channel-3-night.jpg`, `channel-3-before.jpg`, `channel-3-after.jpg`
- `channel-4-main.jpg`, `channel-4-day.jpg`, `channel-4-night.jpg`, `channel-4-before.jpg`, `channel-4-after.jpg`

**LED NEON SIGNS (Products 5-6)**: Flexible tube-style lighting
- `neon-5-main.jpg`, `neon-5-day.jpg`, `neon-5-night.jpg`, `neon-5-before.jpg`, `neon-5-after.jpg`
- `neon-6-main.jpg`, `neon-6-day.jpg`, `neon-6-night.jpg`, `neon-6-before.jpg`, `neon-6-after.jpg`

**PYLON SIGNS (Products 7-8)**: Tall freestanding structures
- `pylon-7-main.jpg`, `pylon-7-day.jpg`, `pylon-7-night.jpg`, `pylon-7-before.jpg`, `pylon-7-after.jpg`
- `pylon-8-main.jpg`, `pylon-8-day.jpg`, `pylon-8-night.jpg`, `pylon-8-before.jpg`, `pylon-8-after.jpg`

**WINDOW GRAPHICS (Products 9-10)**: Frosted film and decals on glass
- `window-9-main.jpg`, `window-9-day.jpg`, `window-9-night.jpg`, `window-9-before.jpg`, `window-9-after.jpg`
- `window-10-main.jpg`, `window-10-day.jpg`, `window-10-night.jpg`, `window-10-before.jpg`, `window-10-after.jpg`

---

## STEP 1: Login to Directus Admin Panel

1. Open your web browser
2. Navigate to: **http://localhost:8055**
3. Login credentials:
   - **Email**: `admin@example.com`
   - **Password**: `admin123`
4. Click **Sign In**

---

## STEP 2: Review Current File Library (OPTIONAL)

1. In the left sidebar, click **Content**
2. Click **Files**
3. Review the existing 50 images (general business photos)
4. Note: These will be replaced with product-specific signage images

**Option A - Keep Old Images**: If you want to keep the old images for reference, you can organize them into a folder called "Old Images" before uploading new ones.

**Option B - Delete Old Images**: If you want to start fresh, you can select and delete the old images now (see Step 3).

---

## STEP 3: Delete Old Non-Signage Images (OPTIONAL)

⚠️ **Warning**: Only delete images if you're certain you want to remove them. This action cannot be undone.

1. In **Content → Files**, select all existing images (or just the ones you want to replace)
2. Click the **Delete** button (trash icon)
3. Confirm deletion
4. File library should now be empty (or contain only images you want to keep)

**Alternative**: Skip deletion and simply upload new images. When assigning to products, you'll select the new images instead of the old ones.

---

## STEP 4: Upload Lightbox Images (Products 1-2)

### Upload Process

1. In **Content → Files**, click the **Upload Files** button (top right)
2. Click **Choose Files** or drag and drop
3. Navigate to: `C:\Users\grube\WebstormProjects\prem-lichtwerbung\signage-images-real\`
4. Select the following 10 files:
   - `lightbox-1-main.jpg`
   - `lightbox-1-day.jpg`
   - `lightbox-1-night.jpg`
   - `lightbox-1-before.jpg`
   - `lightbox-1-after.jpg`
   - `lightbox-2-main.jpg`
   - `lightbox-2-day.jpg`
   - `lightbox-2-night.jpg`
   - `lightbox-2-before.jpg`
   - `lightbox-2-after.jpg`
5. Click **Open** or **Upload**
6. Wait for upload progress to complete
7. Verify all 10 lightbox images appear in the file library with thumbnails

**Optional**: Create a folder called "Lightboxes" and move these 10 images into it for better organization.

---

## STEP 5: Upload Channel Letter Images (Products 3-4)

1. Click **Upload Files** button again
2. Select the following 10 files:
   - `channel-3-main.jpg`
   - `channel-3-day.jpg`
   - `channel-3-night.jpg`
   - `channel-3-before.jpg`
   - `channel-3-after.jpg`
   - `channel-4-main.jpg`
   - `channel-4-day.jpg`
   - `channel-4-night.jpg`
   - `channel-4-before.jpg`
   - `channel-4-after.jpg`
3. Upload and verify thumbnails show 3D dimensional letters/building facades

**Optional**: Create a folder called "Channel Letters" for organization.

---

## STEP 6: Upload Neon Sign Images (Products 5-6)

1. Click **Upload Files** button
2. Select the following 10 files:
   - `neon-5-main.jpg` through `neon-5-after.jpg`
   - `neon-6-main.jpg` through `neon-6-after.jpg`
3. Upload and verify thumbnails show neon/colorful lighting

**Optional**: Create a folder called "Neon Signs" for organization.

---

## STEP 7: Upload Pylon Sign Images (Products 7-8)

1. Click **Upload Files** button
2. Select the following 10 files:
   - `pylon-7-main.jpg` through `pylon-7-after.jpg`
   - `pylon-8-main.jpg` through `pylon-8-after.jpg`
3. Upload and verify thumbnails show tall structures/buildings

**Optional**: Create a folder called "Pylons" for organization.

---

## STEP 8: Upload Window Graphics Images (Products 9-10)

1. Click **Upload Files** button
2. Select the following 10 files:
   - `window-9-main.jpg` through `window-9-after.jpg`
   - `window-10-main.jpg` through `window-10-after.jpg`
3. Upload and verify thumbnails show office buildings/glass windows

**Optional**: Create a folder called "Window Graphics" for organization.

---

## STEP 9: Verify All 50 Images Uploaded

1. In **Content → Files**, check the total count
2. Should see **50 new images** (plus any old images if you didn't delete them)
3. All thumbnails should be visible and loading correctly
4. Image names should be recognizable (lightbox-1-main, channel-3-night, etc.)

---

## STEP 10: Assign Images to Product 1 - Single-Sided LED Lightbox

1. In the left sidebar, click **Content**
2. Click **products**
3. Find and click **"Single-Sided LED Lightbox"** (Product ID 1)
4. Click the **Edit** button (pencil icon)

### Assign Each Image Field:

**Primary Image**:
1. Scroll to the `primary_image` field
2. Click the **file picker dropdown** icon (folder icon)
3. Search for or scroll to find `lightbox-1-main.jpg`
4. Click on the image thumbnail to select it
5. Verify the image preview appears in the field

**Day Image**:
1. Scroll to the `day_image` field
2. Click the file picker
3. Select `lightbox-1-day.jpg`
4. Verify preview

**Night Image**:
1. Scroll to the `night_image` field
2. Click the file picker
3. Select `lightbox-1-night.jpg`
4. Verify preview shows illuminated/glowing image

**Before Image**:
1. Scroll to the `before_image` field
2. Click the file picker
3. Select `lightbox-1-before.jpg`
4. Verify preview shows plain building/facade

**After Image**:
1. Scroll to the `after_image` field
2. Click the file picker
3. Select `lightbox-1-after.jpg`
4. Verify preview shows building with lightbox installed

### Save Product:
1. Scroll to the top of the page
2. Click the **Save** button (checkmark icon, top right)
3. Wait for "Item saved" confirmation
4. Go back to the products list

---

## STEP 11: Assign Images to Product 2 - Double-Sided LED Lightbox

1. Click **"Double-Sided LED Lightbox"** (Product ID 2)
2. Click **Edit**
3. Assign images using the file picker:
   - `primary_image` → `lightbox-2-main.jpg`
   - `day_image` → `lightbox-2-day.jpg`
   - `night_image` → `lightbox-2-night.jpg`
   - `before_image` → `lightbox-2-before.jpg`
   - `after_image` → `lightbox-2-after.jpg`
4. Verify all selections show LIGHTBOX images (not other product types)
5. **Save** the product

---

## STEP 12: Assign Images to Product 3 - Front-Lit Channel Letters

1. Click **"Illuminated Front-Lit Channel Letters"** (Product ID 3)
2. Click **Edit**
3. Assign images:
   - `primary_image` → `channel-3-main.jpg`
   - `day_image` → `channel-3-day.jpg`
   - `night_image` → `channel-3-night.jpg`
   - `before_image` → `channel-3-before.jpg`
   - `after_image` → `channel-3-after.jpg`
4. Verify thumbnails show 3D dimensional letters (NOT flat lightboxes)
5. **Save**

---

## STEP 13: Assign Images to Product 4 - Halo-Lit Channel Letters

1. Click **"Halo-Lit Channel Letters"** (Product ID 4)
2. Click **Edit**
3. Assign images:
   - `primary_image` → `channel-4-main.jpg`
   - `day_image` → `channel-4-day.jpg`
   - `night_image` → `channel-4-night.jpg` (should show backlit glow effect)
   - `before_image` → `channel-4-before.jpg`
   - `after_image` → `channel-4-after.jpg`
4. Verify dimensional letter appearance
5. **Save**

---

## STEP 14: Assign Images to Product 5 - Custom LED Neon Sign

1. Click **"Custom LED Neon Sign"** (Product ID 5)
2. Click **Edit**
3. Assign images:
   - `primary_image` → `neon-5-main.jpg`
   - `day_image` → `neon-5-day.jpg`
   - `night_image` → `neon-5-night.jpg` (vibrant glowing tubes)
   - `before_image` → `neon-5-before.jpg`
   - `after_image` → `neon-5-after.jpg`
4. Verify flexible tube neon style (NOT rigid letters)
5. **Save**

---

## STEP 15: Assign Images to Product 6 - LED Neon Open Sign

1. Click **"LED Neon Open Sign"** (Product ID 6)
2. Click **Edit**
3. Assign images:
   - `primary_image` → `neon-6-main.jpg`
   - `day_image` → `neon-6-day.jpg`
   - `night_image` → `neon-6-night.jpg`
   - `before_image` → `neon-6-before.jpg`
   - `after_image` → `neon-6-after.jpg`
4. Verify neon tube appearance
5. **Save**

---

## STEP 16: Assign Images to Product 7 - Single-Post Pylon Sign

1. Click **"Single-Post Pylon Sign"** (Product ID 7)
2. Click **Edit**
3. Assign images:
   - `primary_image` → `pylon-7-main.jpg`
   - `day_image` → `pylon-7-day.jpg`
   - `night_image` → `pylon-7-night.jpg`
   - `before_image` → `pylon-7-before.jpg`
   - `after_image` → `pylon-7-after.jpg`
4. Verify tall freestanding structure (NOT building-mounted)
5. **Save**

---

## STEP 17: Assign Images to Product 8 - Monument Sign

1. Click **"Monument Sign"** (Product ID 8)
2. Click **Edit**
3. Assign images:
   - `primary_image` → `pylon-8-main.jpg`
   - `day_image` → `pylon-8-day.jpg`
   - `night_image` → `pylon-8-night.jpg`
   - `before_image` → `pylon-8-before.jpg`
   - `after_image` → `pylon-8-after.jpg`
4. Verify monument/pylon structure
5. **Save**

---

## STEP 18: Assign Images to Product 9 - Frosted Window Film

1. Click **"Frosted Window Film"** (Product ID 9)
2. Click **Edit**
3. Assign images:
   - `primary_image` → `window-9-main.jpg`
   - `day_image` → `window-9-day.jpg`
   - `night_image` → `window-9-night.jpg`
   - `before_image` → `window-9-before.jpg` (plain glass)
   - `after_image` → `window-9-after.jpg` (frosted film applied)
4. Verify glass window application
5. **Save**

---

## STEP 19: Assign Images to Product 10 - Window Decals

1. Click **"Full-Color Window Decals"** (Product ID 10)
2. Click **Edit**
3. Assign images:
   - `primary_image` → `window-10-main.jpg`
   - `day_image` → `window-10-day.jpg`
   - `night_image` → `window-10-night.jpg`
   - `before_image` → `window-10-before.jpg`
   - `after_image` → `window-10-after.jpg`
4. Verify printed graphics on glass windows
5. **Save**

---

## STEP 20: Verify All Products Have Correct Images

Go through each product and verify:
1. All 5 image fields have thumbnails (NOT empty)
2. Primary image matches the product type
3. Day and night images are visibly different (lighting change)
4. Before/after images show transformation
5. No construction worker photos or unrelated signage types

### Product-Image Match Checklist:
- ✓ Product 1-2: Lightbox images (flat panels)
- ✓ Product 3-4: Channel letter images (3D dimensional letters)
- ✓ Product 5-6: Neon sign images (flexible tube lighting)
- ✓ Product 7-8: Pylon images (tall freestanding structures)
- ✓ Product 9-10: Window graphics images (glass applications)

---

## STEP 21: Configure Public Permissions (If Not Already Done)

⚠️ **CRITICAL**: Without public permissions, the frontend cannot display images.

1. In Directus admin, go to **Settings** (gear icon in sidebar)
2. Click **Access Control**
3. Click **Public** role
4. Add **READ** permission for:
   - `products`
   - `categories`
   - `directus_files` ← **CRITICAL FOR IMAGES**
   - `products_categories`
   - Other collections as needed
5. Click **Save**

---

## STEP 22: Test Frontend Image Display

1. Open your web browser
2. Navigate to: **http://localhost:3000**
3. Click **Products** in navigation
4. Verify:
   - Product cards show real signage images (not placeholders)
   - Hover over product cards triggers day/night image switch
   - All 10 products display with correct images

### Click on "Single-Sided LED Lightbox" Product:
1. Verify primary image shows lightbox signage
2. Check thumbnail gallery shows all 4 images (primary, day, night, after)
3. Click thumbnails to switch between images
4. Verify images load correctly (no 403 or 404 errors)

### Test Day/Night Switcher:
- Hover over product cards on Products page
- Image should switch from day to night view
- Verify visible difference in lighting

### Test Other Products:
- Click through products 2-10
- Verify each shows its correct category images
- Verify before/after slider works (if implemented)

---

## STEP 23: Troubleshooting

### Images Not Displaying in Frontend

**Problem**: Images show as broken icons or 403/404 errors

**Solutions**:
1. Check public permissions for `directus_files` collection
2. Clear browser cache (Ctrl+Shift+Delete)
3. Verify image UUIDs are correctly assigned in Directus
4. Check browser console (F12) for error messages

### Wrong Images Assigned to Products

**Problem**: Lightbox product shows neon sign images, etc.

**Solution**:
1. Go back to Directus admin
2. Edit the affected product
3. Click the file picker for each image field
4. Select the CORRECT images matching the product type
5. Save the product

### Images Not in Directus File Library

**Problem**: Can't find uploaded images when using file picker

**Solution**:
1. Go to Content → Files
2. Check if images are in a folder (expand folders)
3. If missing, re-upload the images following Steps 4-8
4. Verify upload completed successfully (check file count)

### Day/Night Switcher Not Working

**Problem**: Hover doesn't change image on product cards

**Solution**:
1. Verify `day_image` and `night_image` fields are both assigned
2. Check that the two images are visibly different
3. Clear browser cache and hard reload (Ctrl+F5)
4. Inspect ProductCard.vue component for errors

---

## Summary

### What You've Accomplished:
✅ Reviewed current Directus file library  
✅ Uploaded 50 real professional signage images to Directus  
✅ Organized images by product category (optional folders)  
✅ Manually assigned 5 images to each of 10 products using file picker  
✅ Verified product-image matching (lightboxes get lightbox images, etc.)  
✅ Configured public permissions for image access  
✅ Tested frontend displays correct images  

### Benefits of This Approach:
- ✅ **User-friendly**: Client can change images via Directus admin UI
- ✅ **No coding required**: All changes through admin panel
- ✅ **Professional images**: Real signage photos instead of placeholders
- ✅ **Scalable**: Easy to add more images or products in the future
- ✅ **Flexible**: Can upload from any device with file picker

### Next Steps (For Production):
1. Replace generic business photos with actual product photography
2. Consider hiring photographer for product-specific signage images
3. Add more before/after comparison images
4. Organize file library with folders and descriptive tags
5. Set up automated image optimization (resizing, compression)

---

**End of Manual Upload Guide**
