#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const FormData = require('form-data');
const fetch = require('node-fetch');

const DIRECTUS_URL = process.env.PUBLIC_URL || 'http://localhost:8055';
const ADMIN_EMAIL = process.env.ADMIN_EMAIL || 'admin@example.com';
const ADMIN_PASSWORD = process.env.ADMIN_PASSWORD || 'admin123';
const IMAGES_DIR = '/directus/bootstrap/images/products';
const OUTPUT_FILE = '/directus/bootstrap/image-uuid-map.json';

let accessToken = null;

// Authenticate with Directus
async function authenticate() {
  console.log('🔑 Authenticating with Directus...');
  
  try {
    const response = await fetch(`${DIRECTUS_URL}/auth/login`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        email: ADMIN_EMAIL,
        password: ADMIN_PASSWORD
      })
    });

    if (!response.ok) {
      throw new Error(`Authentication failed: ${response.status}`);
    }

    const data = await response.json();
    accessToken = data.data.access_token;
    
    if (!accessToken) {
      throw new Error('No access token received');
    }

    console.log('✅ Authentication successful');
    return accessToken;
  } catch (error) {
    console.error('❌ Authentication error:', error.message);
    throw error;
  }
}

// Upload a single image file
async function uploadImage(filePath, filename, retries = 3) {
  for (let attempt = 1; attempt <= retries; attempt++) {
    try {
      const form = new FormData();
      form.append('file', fs.createReadStream(filePath), filename);

      const response = await fetch(`${DIRECTUS_URL}/files`, {
        method: 'POST',
        headers: {
          'Authorization': `Bearer ${accessToken}`
        },
        body: form
      });

      if (!response.ok) {
        const errorText = await response.text();
        throw new Error(`Upload failed (${response.status}): ${errorText}`);
      }

      const data = await response.json();
      const fileId = data.data.id;

      if (!fileId) {
        throw new Error('No file ID returned');
      }

      return fileId;
    } catch (error) {
      if (attempt < retries) {
        console.log(`  ⚠️  Attempt ${attempt} failed, retrying... (${error.message})`);
        await new Promise(resolve => setTimeout(resolve, 1000 * attempt));
      } else {
        throw error;
      }
    }
  }
}

// Main upload process
async function uploadAllImages() {
  console.log('');
  console.log('==========================================');
  console.log('📸 UPLOADING PRODUCT IMAGES TO DIRECTUS');
  console.log('==========================================');
  console.log('');

  try {
    // Authenticate
    await authenticate();

    // Get all image files
    console.log(`📂 Reading images from: ${IMAGES_DIR}`);
    const files = fs.readdirSync(IMAGES_DIR)
      .filter(f => f.endsWith('.jpg') || f.endsWith('.jpeg') || f.endsWith('.png'))
      .sort();

    if (files.length === 0) {
      console.log('⚠️  No image files found');
      return;
    }

    console.log(`📊 Found ${files.length} images to upload`);
    console.log('');

    // Upload each image
    const uuidMapping = {};
    let successCount = 0;
    let failCount = 0;

    for (const filename of files) {
      const filePath = path.join(IMAGES_DIR, filename);
      process.stdout.write(`  Uploading ${filename}... `);

      try {
        const uuid = await uploadImage(filePath, filename);
        uuidMapping[filename] = uuid;
        console.log(`✅ OK (${uuid})`);
        successCount++;
      } catch (error) {
        console.log(`❌ FAILED (${error.message})`);
        failCount++;
      }

      // Small delay to avoid rate limiting
      await new Promise(resolve => setTimeout(resolve, 200));
    }

    // Save UUID mapping
    console.log('');
    console.log(`💾 Saving UUID mapping to: ${OUTPUT_FILE}`);
    fs.writeFileSync(OUTPUT_FILE, JSON.stringify(uuidMapping, null, 2));
    console.log('✅ UUID mapping saved');

    // Summary
    console.log('');
    console.log('==========================================');
    console.log('📊 UPLOAD SUMMARY');
    console.log('==========================================');
    console.log(`Total images: ${files.length}`);
    console.log(`Success: ${successCount}`);
    console.log(`Failed: ${failCount}`);
    console.log('==========================================');
    console.log('');

    if (failCount > 0) {
      console.log('⚠️  Some uploads failed. Continuing with available images...');
    } else {
      console.log('✅ All images uploaded successfully!');
    }
    console.log('');

  } catch (error) {
    console.error('❌ Upload process failed:', error.message);
    process.exit(1);
  }
}

// Run if called directly
if (require.main === module) {
  uploadAllImages()
    .then(() => {
      console.log('✅ Image upload complete');
      process.exit(0);
    })
    .catch(error => {
      console.error('❌ Fatal error:', error.message);
      process.exit(1);
    });
}

module.exports = { uploadAllImages };
