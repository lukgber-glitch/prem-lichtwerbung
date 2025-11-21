#!/usr/bin/env node

const fs = require('fs');
const path = require('path');

const PRODUCTS_TEMPLATE = '/directus/bootstrap/sample-data/products.json';
const UUID_MAPPING_FILE = '/directus/bootstrap/image-uuid-map.json';
const OUTPUT_FILE = '/directus/bootstrap/sample-data/products-final.json';

// Map product IDs to image filename prefixes (AI-generated images use product-{id} format)
const PRODUCT_IMAGE_MAPPING = {
  1: 'product-1',
  2: 'product-2',
  3: 'product-3',
  4: 'product-4',
  5: 'product-5',
  6: 'product-6',
  7: 'product-7',
  8: 'product-8',
  9: 'product-9',
  10: 'product-10'
};

// Map image field names to filename suffixes (AI-generated images use primary.jpg)
const IMAGE_FIELD_MAPPING = {
  'primary_image': 'primary.jpg',
  'day_image': 'day.jpg',
  'night_image': 'night.jpg',
  'before_image': 'before.jpg',
  'after_image': 'after.jpg'
};

function prepareProducts() {
  console.log('');
  console.log('==========================================');
  console.log('🔧 PREPARING PRODUCTS WITH IMAGE UUIDS');
  console.log('==========================================');
  console.log('');

  try {
    // Read UUID mapping
    console.log(`📂 Reading UUID mapping from: ${UUID_MAPPING_FILE}`);
    if (!fs.existsSync(UUID_MAPPING_FILE)) {
      throw new Error('UUID mapping file not found. Run upload-images.js first.');
    }
    const uuidMapping = JSON.parse(fs.readFileSync(UUID_MAPPING_FILE, 'utf8'));
    console.log(`✅ Loaded ${Object.keys(uuidMapping).length} UUID mappings`);

    // Read products template
    console.log(`📂 Reading products template from: ${PRODUCTS_TEMPLATE}`);
    if (!fs.existsSync(PRODUCTS_TEMPLATE)) {
      throw new Error('Products template file not found.');
    }
    const products = JSON.parse(fs.readFileSync(PRODUCTS_TEMPLATE, 'utf8'));
    console.log(`✅ Loaded ${products.length} products`);
    console.log('');

    // Process each product
    console.log('🔄 Replacing image references with UUIDs...');
    let updatedCount = 0;
    let missingCount = 0;

    for (const product of products) {
      const productId = product.id;
      const imagePrefix = PRODUCT_IMAGE_MAPPING[productId];

      if (!imagePrefix) {
        console.log(`  ⚠️  Product ${productId}: No image mapping defined`);
        continue;
      }

      console.log(`  Product ${productId} (${product.name}):`);

      // Update each image field
      for (const [fieldName, suffix] of Object.entries(IMAGE_FIELD_MAPPING)) {
        const filename = `${imagePrefix}-${suffix}`;
        const uuid = uuidMapping[filename];

        if (uuid) {
          product[fieldName] = uuid;
          console.log(`    ${fieldName}: ${filename} → ${uuid}`);
          updatedCount++;
        } else {
          console.log(`    ${fieldName}: ${filename} → ⚠️  UUID NOT FOUND`);
          product[fieldName] = null;
          missingCount++;
        }
      }
    }

    // Save updated products
    console.log('');
    console.log(`💾 Saving updated products to: ${OUTPUT_FILE}`);
    fs.writeFileSync(OUTPUT_FILE, JSON.stringify(products, null, 2));
    console.log('✅ Products file saved');

    // Summary
    console.log('');
    console.log('==========================================');
    console.log('📊 PREPARATION SUMMARY');
    console.log('==========================================');
    console.log(`Total products: ${products.length}`);
    console.log(`Image fields updated: ${updatedCount}`);
    console.log(`Missing UUIDs: ${missingCount}`);
    console.log('==========================================');
    console.log('');

    if (missingCount > 0) {
      console.log('⚠️  Some image UUIDs were not found. Products will have null image fields.');
    } else {
      console.log('✅ All products prepared successfully!');
    }
    console.log('');

  } catch (error) {
    console.error('❌ Preparation failed:', error.message);
    process.exit(1);
  }
}

// Run if called directly
if (require.main === module) {
  prepareProducts();
}

module.exports = { prepareProducts };
