# Managing Page Images in Directus Backend

**Date**: 2025-11-27  
**Purpose**: Guide for uploading and managing images for Home, About, and Contact pages in Directus

---

## Current Status

✅ **Text Content**: Home and About pages now fetch text from Directus backend  
❌ **Images**: Currently hardcoded as Unsplash URLs in templates  
🔧 **Solution**: Upload images to Directus and link them to pages collection

---

## How to Upload Images to Directus

### Step 1: Access Directus Admin Panel

1. Open: **http://localhost:8055**
2. Login with:
   - Email: `admin@example.com`
   - Password: `admin123`

### Step 2: Upload Images to File Library

1. In Directus sidebar, click **File Library**
2. Click **"Upload Files"** button (top right)
3. Select and upload your images:
   - For Home page: 6 images (3 for Services section, 3 for Expertise section)
   - For About page: 3 images (1 large, 2 small for Narrative section)
   - For Contact page: Optional hero image
4. After upload, each image will have a unique UUID

### Step 3: Link Images to Pages Collection

#### Option A: Using the Images Gallery Field

1. Go to **Content → Pages**
2. Click on the page you want to edit (e.g., "Home", "About Us")
3. Scroll to the **"Images"** field (M2M gallery)
4. Click **"+"** to add images
5. Select images from the file library
6. **Important**: Add images in the correct order:
   - **About page**: 
     - Image 1: Large image (800x600)
     - Image 2: Small left image (400x400)
     - Image 3: Small right image (400x400)
   - **Home page Services section**:
     - Image 1: Large image (800x600)
     - Image 2: Small left image (400x400)
     - Image 3: Small right image (400x400)
   - **Home page Expertise section**:
     - Image 4: Large image (800x600)
     - Image 5: Small left image (400x400)
     - Image 6: Small right image (400x400)
7. Click **"Save"**

#### Option B: Using Hero Image Field

1. Go to **Content → Pages**
2. Click on the page
3. Scroll to **"Hero Image"** field
4. Click to select or upload a hero/banner image
5. Click **"Save"**

---

## Current Template Image References

### About.vue (Lines 33-57)

Currently uses **hardcoded Unsplash URLs**:
```vue
<!-- Narrative Section Images -->
<img src="https://images.unsplash.com/photo-1541888946425-d81bb19240f5?w=800&h=600&fit=crop" />
<img src="https://images.unsplash.com/photo-1504805572947-34fad45aed93?w=400&h=400&fit=crop" />
<img src="https://images.unsplash.com/photo-1553877522-43269d4ea984?w=400&h=400&fit=crop" />
```

### Home.vue

**Services Section (Lines 76-99)** - hardcoded URLs:
```vue
<img src="https://images.unsplash.com/photo-1541888946425-d81bb19240f5?w=800&h=600&fit=crop" />
<img src="https://images.unsplash.com/photo-1565008576549-57569a49371d?w=400&h=400&fit=crop" />
<img src="https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400&h=400&fit=crop" />
```

**Expertise Section (Lines 177-200)** - hardcoded URLs:
```vue
<img src="https://images.unsplash.com/photo-1504805572947-34fad45aed93?w=800&h=600&fit=crop" />
<img src="https://images.unsplash.com/photo-1553877522-43269d4ea984?w=400&h=400&fit=crop" />
<img src="https://images.unsplash.com/photo-1600880292203-757bb62b4baf?w=400&h=400&fit=crop" />
```

---

## Solution: Use Directus Gallery Images

The `usePageContent` composable already provides `galleryImages` computed property:

```typescript
const { content, galleryImages } = usePageContent('about')
```

Returns:
```javascript
galleryImages = [
  {
    id: "uuid-1",
    url: "http://localhost:8055/assets/uuid-1",
    title: "Image title"
  },
  {
    id: "uuid-2", 
    url: "http://localhost:8055/assets/uuid-2",
    title: "Image title"
  }
]
```

### How to Update Templates

#### About.vue Example

**Before (hardcoded)**:
```vue
<img src="https://images.unsplash.com/photo-1541888946425-d81bb19240f5?w=800&h=600&fit=crop" />
```

**After (from Directus)**:
```vue
<img v-if="galleryImages[0]" :src="galleryImages[0].url" :alt="galleryImages[0].title" />
```

#### Complete Pattern

```vue
<template>
  <!-- Large image -->
  <div v-if="galleryImages[0]" class="overflow-hidden rounded-sm">
    <img
      :src="galleryImages[0].url"
      :alt="galleryImages[0].title || 'Image'"
      class="w-full rounded-sm transition-transform duration-500 hover:scale-105"
    />
  </div>
  
  <!-- Small images grid -->
  <div class="grid grid-cols-2 gap-6">
    <div v-if="galleryImages[1]" class="overflow-hidden rounded-sm">
      <img
        :src="galleryImages[1].url"
        :alt="galleryImages[1].title || 'Image'"
        class="w-full rounded-sm transition-transform duration-500 hover:scale-105"
      />
    </div>
    <div v-if="galleryImages[2]" class="overflow-hidden rounded-sm">
      <img
        :src="galleryImages[2].url"
        :alt="galleryImages[2].title || 'Image'"
        class="w-full rounded-sm transition-transform duration-500 hover:scale-105"
      />
    </div>
  </div>
</template>

<script setup lang="ts">
const { content, galleryImages } = usePageContent('about')
</script>
```

---

## Quick Start Steps

### 1. Upload Images to Directus

1. Go to **File Library** in Directus
2. Upload your images (recommended: signage/lighting themed photos)
3. Note the order for each page

### 2. Link Images to Pages

1. Go to **Content → Pages**
2. Edit "About Us" page
3. Add 3 images to the **Images** field
4. Save
5. Edit "Home" page
6. Add 6 images to the **Images** field
7. Save

### 3. Update Templates (Optional)

The templates can be updated to use `galleryImages` array instead of hardcoded URLs. See the pattern above.

**OR** you can keep hardcoded URLs for now and just upload images to Directus for future use.

---

## Testing

### Verify Images in Directus

1. Go to **Content → Pages**
2. Click on a page (e.g., "About Us")
3. Check the **Images** field shows your uploaded images
4. Copy one image UUID

### Test Image URL

Open in browser:
```
http://localhost:8055/assets/YOUR-IMAGE-UUID
```

Should display the image.

### Test Frontend (After Template Update)

1. Open: http://localhost:3000/about
2. Images should load from Directus instead of Unsplash
3. Edit images in Directus → Refresh page → Changes should appear

---

## Benefits

✅ **No code changes needed** - Upload and manage images in Directus admin  
✅ **Multi-page support** - Each page has its own image gallery  
✅ **Easy updates** - Change images anytime without redeploying  
✅ **Automatic setup** - Schema already configured, just upload images  
✅ **Image library** - Reuse images across multiple pages

---

## Summary

**Current State:**
- Text: ✅ Managed in Directus (Home and About pages)
- Images: ❌ Hardcoded Unsplash URLs

**Solution:**
1. Upload images to Directus File Library
2. Link images to pages via "Images" field
3. Optionally update templates to use `galleryImages` array

**Access:**
- Directus: http://localhost:8055
- Frontend: http://localhost:3000
- Login: admin@example.com / admin123

---

**Next Step**: Upload your custom images to Directus and link them to the pages collection!
