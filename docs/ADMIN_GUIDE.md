# Prem-Lichtwerbung Admin Guide

Complete guide for managing the Prem-Lichtwerbung webshop through the Directus admin panel.

---

## Table of Contents

1. [Accessing the Admin Panel](#accessing-the-admin-panel)
2. [Dashboard Overview](#dashboard-overview)
3. [Managing Products](#managing-products)
4. [Product Configurator Options](#product-configurator-options)
5. [Managing Categories](#managing-categories)
6. [Managing Orders](#managing-orders)
7. [Managing Customers](#managing-customers)
8. [Homepage Banners & Content](#homepage-banners--content)
9. [Managing Static Pages](#managing-static-pages)
10. [Site Settings](#site-settings)
11. [Best Practices](#best-practices)
12. [Pricing Strategy Guidelines](#pricing-strategy-guidelines)
13. [Lead Time Management](#lead-time-management)
14. [SEO Optimization](#seo-optimization)

---

## Accessing the Admin Panel

### Login Credentials

**URL**: `http://localhost:8055` (local) or `https://yourdomain.com/admin` (production)

**Default Credentials**:
- Email: `admin@example.com`
- Password: `admin123`

⚠️ **IMPORTANT**: Change the default password immediately after first login!

### First Login Checklist

1. ✅ Change admin password
2. ✅ Update admin email to your real email address
3. ✅ Configure public API permissions (one-time setup)
4. ✅ Review and customize site settings
5. ✅ Test product creation workflow

---

## Dashboard Overview

### Main Sections

The Directus admin panel is organized into collections (similar to database tables):

- **Products** - All signage products
- **Categories** - Product categories (hierarchical)
- **Product Configurator** - Customization options for products
- **Orders** - Customer orders and order tracking
- **Customers** - Customer accounts and information
- **Tags** - Product tags for filtering
- **Reviews** - Product reviews and ratings (if enabled)
- **Files** - Media library (images, videos, PDFs)

### Quick Actions

- **+ Create New**: Top-right corner to add new items
- **Filter**: Left sidebar to filter collections
- **Search**: Top search bar for quick item lookup
- **Insights**: Analytics dashboard (if configured)

---

## Managing Products

### Adding a New Product

1. **Navigate to Products**
   - Click "Products" in the left sidebar
   - Click "+ Create New" in the top-right

2. **Basic Information**
   - **Name** (required): Full product name (e.g., "Premium Single-Sided LED Lightbox")
   - **Slug** (required): URL-friendly name (auto-generated, e.g., `premium-single-sided-led-lightbox`)
   - **SKU**: Unique product code (e.g., `LBOX-SS-001`)
   - **Status**: Published/Draft/Archived

3. **Pricing**
   - **Base Price** (€): Starting price for standard configuration
   - **Sale Price** (€): Optional discount price (leave empty if not on sale)
   - **Currency**: EUR (default)

4. **Description**
   - **Short Description**: 1-2 sentence summary (displayed on product cards)
   - **Long Description**: Full product description with features, benefits, use cases
   - Use the content templates from `docs/CONTENT_TEMPLATE.md` for consistency

5. **Images** (REQUIRED)
   - **Day Image** (required): Well-lit product photo showing construction
   - **Night Image** (required): Product illuminated in low light
   - **Gallery Images**: Additional images (minimum 3-5 recommended)
   - Recommended resolution: 2000x2000 pixels
   - Format: JPG or PNG
   - Drag files into the upload area or click to browse

6. **Technical Specifications**
   - **Dimensions**: Width × Height × Depth (in cm or mm)
   - **Weight**: Product weight in kg
   - **Illumination Type**: LED, Neon, Fluorescent, etc.
   - **Power Consumption**: Wattage (W)
   - **IP Rating**: Weather resistance (e.g., IP65 for outdoor)
   - **Mounting Type**: Wall-mounted, Freestanding, Ceiling-hung, etc.
   - **Material**: Aluminum, Acrylic, Steel, etc.
   - **Warranty**: Years of warranty coverage

7. **Inventory & Availability**
   - **Stock Quantity**: Current inventory count (0 = out of stock)
   - **Lead Time**: Production time in days (e.g., 10-14 days)
   - **In Stock**: Toggle on/off based on availability

8. **Customization Settings**
   - **Customizable**: Toggle ON if product supports customization
   - **Min Customization Price**: Minimum price for custom work (€)
   - **Max Customization Price**: Maximum price estimate (€)
   - If customizable, link to Product Configurator options

9. **Categories & Tags**
   - **Categories**: Select one or more categories (many-to-many relation)
   - **Tags**: Add relevant tags for filtering (e.g., "outdoor", "energy-efficient", "bestseller")

10. **SEO Settings**
    - **Meta Title**: 50-60 characters (include product name + key benefit)
    - **Meta Description**: 150-160 characters (compelling summary with CTA)
    - **Keywords**: Comma-separated list of relevant search terms

11. **Save & Publish**
    - Click "Save" to create draft
    - Set Status to "Published" to make visible on website

### Editing Existing Products

1. Navigate to Products
2. Click on the product name to open
3. Make changes as needed
4. Click "Save" to update

### Bulk Actions

- **Select multiple products**: Use checkboxes on the left
- **Bulk Edit**: Change status, categories, or tags for multiple products
- **Bulk Delete**: Remove multiple products (use with caution!)

### Product Best Practices

✅ **Always include both day and night images** - This is a key differentiator
✅ **Write detailed descriptions** - Help customers understand value
✅ **Use consistent SKU format** - E.g., `LBOX-SS-001`, `CHAN-3D-005`
✅ **Set realistic lead times** - Better to over-estimate than under-deliver
✅ **Add multiple categories** - Improves discoverability
✅ **Keep stock quantities updated** - Avoid disappointing customers
✅ **Test customization options** - Ensure price calculator works correctly

---

## Product Configurator Options

The Product Configurator allows customers to customize products with real-time price updates.

### Creating Configurator Options

1. **Navigate to Product Configurator**
2. **Click "+ Create New"**

3. **Option Details**
   - **Option Name**: E.g., "Size", "LED Color", "Mounting Type"
   - **Option Type**: Dropdown, Radio buttons, Checkbox, Color picker
   - **Required**: Toggle ON if customer must select this option

4. **Values**
   - Add multiple values for the option
   - Example for "Size":
     - Small (50cm × 50cm) - +€0
     - Medium (100cm × 100cm) - +€150
     - Large (150cm × 150cm) - +€300
     - Extra Large (200cm × 200cm) - +€500

5. **Price Modifiers**
   - Each value can have a price modifier (positive or negative)
   - Use `+€150` to add to base price
   - Use `-€50` to discount from base price

6. **Link to Products**
   - Assign configurator option groups to specific products
   - Products can have multiple option groups

### Example: Lightbox Configurator

**Option Group: Lightbox Customization**

1. **Size** (Required, Dropdown)
   - 50cm × 50cm: +€0
   - 75cm × 75cm: +€120
   - 100cm × 100cm: +€250
   - 150cm × 150cm: +€450

2. **LED Color Temperature** (Required, Radio)
   - Warm White (3000K): +€0
   - Natural White (4000K): +€0
   - Cool White (6000K): +€0
   - RGB Color Changing: +€180

3. **Mounting Hardware** (Required, Dropdown)
   - Standard Wall Mount: +€0
   - Heavy Duty Wall Mount: +€45
   - Ceiling Suspension Kit: +€120
   - Freestanding Base: +€200

4. **Power Supply** (Required, Radio)
   - Standard EU Plug: +€0
   - Hardwired Installation: +€30
   - Solar Powered (outdoor): +€350

5. **Additional Features** (Optional, Checkboxes)
   - Dimmable Control: +€80
   - Motion Sensor: +€60
   - Timer Function: +€40
   - Remote Control: +€50

### Testing the Configurator

1. Navigate to the product page on the frontend
2. Use the configurator to select different options
3. Verify that the price updates correctly in real-time
4. Test the "Add to Cart" functionality with customizations

---

## Managing Categories

### Category Hierarchy

Categories are organized hierarchically with parent-child relationships:

```
Lightboxes (Parent)
├── Single-Sided Lightboxes (Child)
├── Double-Sided Lightboxes (Child)
└── LED Lightboxes (Child)

Channel Letters (Parent)
├── Front-Lit Channel Letters (Child)
├── Back-Lit (Halo) Channel Letters (Child)
└── Combination Channel Letters (Child)
```

### Creating a Category

1. **Navigate to Categories**
2. **Click "+ Create New"**

3. **Basic Information**
   - **Name** (required): Category display name
   - **Slug** (required): URL-friendly version (auto-generated)
   - **Parent Category**: Select if this is a subcategory (optional)
   - **Status**: Published/Draft

4. **Description**
   - Write a compelling category description (2-3 paragraphs)
   - Use the category template from `docs/CONTENT_TEMPLATE.md`
   - Explain what products are in this category and their benefits

5. **Category Image**
   - Upload a representative image for the category
   - Recommended size: 1200×800 pixels
   - Should showcase multiple products from this category

6. **Display Settings**
   - **Display Order**: Numeric value (lower numbers appear first)
   - **Show on Homepage**: Toggle ON to feature on main page
   - **Icon**: Optional icon class for navigation menus

7. **SEO Settings**
   - **Meta Title**: Category name + key benefit
   - **Meta Description**: Brief overview with keywords
   - **Keywords**: Relevant search terms

### Assigning Products to Categories

Products can belong to multiple categories (many-to-many relationship).

**Method 1: From Product**
1. Edit the product
2. Scroll to "Categories" section
3. Click "+ Add" and select categories
4. Save product

**Method 2: From Category**
1. Edit the category
2. Scroll to "Products" section
3. Click "+ Add" and select products
4. Save category

### Category Best Practices

✅ **Keep hierarchy simple** - Maximum 2 levels (parent → child)
✅ **Use descriptive names** - Clear, benefit-focused names
✅ **Add rich descriptions** - Help SEO and customer understanding
✅ **Use high-quality images** - Professional category hero images
✅ **Set logical display order** - Most popular categories first
✅ **Assign multiple categories** - Products can appear in multiple places

---

## Managing Orders

### Order Workflow

Orders progress through these statuses:

1. **Pending** - Order placed, awaiting payment confirmation
2. **Processing** - Payment confirmed, order being prepared
3. **In Production** - Custom signage being manufactured
4. **Quality Check** - Product inspection before shipping
5. **Ready for Delivery** - Packaged and ready to ship
6. **Shipped** - In transit to customer
7. **Delivered** - Successfully delivered
8. **Cancelled** - Order cancelled by customer or admin
9. **Refunded** - Payment refunded to customer

### Viewing Orders

1. **Navigate to Orders**
2. **Filter by Status**: Use sidebar to filter by order status
3. **Search**: Search by order number, customer name, or email
4. **Sort**: Click column headers to sort by date, total, status, etc.

### Order Details

Click on an order to view:

- **Order Number**: Unique identifier (e.g., ORD-1234567890-ABC)
- **Order Date**: When order was placed
- **Customer Information**: Name, email, phone, shipping address
- **Order Items**: Products, quantities, prices, customizations
- **Order Total**: Subtotal, shipping, tax, total
- **Payment Status**: Paid, Pending, Failed
- **Payment Method**: Stripe, Bank Transfer, etc.
- **Order Notes**: Customer comments or admin notes

### Updating Order Status

1. Open the order
2. Change "Status" field to next status in workflow
3. Add an admin note explaining the status change
4. Click "Save"
5. Customer receives automated email notification (if configured)

### Order Notes

Add internal notes to track order progress:
- Production updates
- Customer communication log
- Special requests or modifications
- Shipping tracking numbers

### Cancelling Orders

1. Open the order
2. Change status to "Cancelled"
3. Add note with cancellation reason
4. Click "Save"
5. Process refund through payment provider if needed

### Order Management Best Practices

✅ **Update status promptly** - Keep customers informed
✅ **Add detailed notes** - Document all communications and changes
✅ **Include tracking numbers** - Add to notes when shipped
✅ **Handle refunds quickly** - Good customer service builds loyalty
✅ **Review orders daily** - Don't let orders sit unprocessed

---

## Managing Customers

### Customer Information

Customer records store:
- **Personal Information**: Name, email, phone
- **Account Status**: Active, Suspended
- **Order History**: List of all past orders
- **Addresses**: Saved shipping and billing addresses
- **Customer Notes**: Admin notes about customer

### Creating Customer Accounts

Customers typically register themselves, but admins can create accounts:

1. **Navigate to Customers**
2. **Click "+ Create New"**
3. **Fill in customer details**
4. **Set password** (customer will be prompted to change)
5. **Save**

### Editing Customer Information

1. Navigate to Customers
2. Click on customer name
3. Update information as needed
4. Save changes

### Customer Communication

- Use email addresses to send order updates
- Add notes to customer record for future reference
- Mark important customers (VIP flag if available)

### Customer Best Practices

✅ **Protect customer data** - Never share personal information
✅ **Document interactions** - Keep detailed notes
✅ **Handle complaints promptly** - Turn issues into opportunities
✅ **Reward loyal customers** - Consider VIP discounts

---

## Homepage Banners & Content

### Managing Hero Banners

Homepage hero banners are the large featured images/slides at the top of the page.

1. **Navigate to Files**
2. **Upload banner images**
   - Recommended size: 1920×800 pixels
   - Format: JPG or PNG
   - Optimize for web (under 500KB)

3. **Create Banner Entries** (if using a Banners collection)
   - Title: Banner headline
   - Subtitle: Supporting text
   - Image: Select uploaded image
   - Call-to-Action Text: Button text (e.g., "Shop Now")
   - Call-to-Action Link: Button destination URL
   - Display Order: Numeric order for multiple banners

### Featured Products

If using a Featured Products section:

1. Edit products and toggle "Featured" flag
2. Or create a "Featured Products" collection and link products
3. Set display order for carousel/grid

### Homepage Sections

Common homepage sections to manage:

- **Hero Banner/Carousel**: Main visual showcase
- **Featured Categories**: Top 3-6 category cards
- **Featured Products**: Bestsellers or new arrivals
- **Benefits Section**: Why choose Prem-Lichtwerbung
- **Portfolio/Projects**: Recent installations
- **Testimonials**: Customer reviews and quotes
- **CTA Section**: Contact or quote request

---

## Managing Static Pages

### About Page

1. **Navigate to Pages** (or edit directly in code for custom layouts)
2. **Edit "About" page**
3. **Content Sections**:
   - Company history and mission
   - Team members and expertise
   - Certifications and awards
   - Manufacturing process
   - Quality commitment

### Contact Page

1. **Edit "Contact" page**
2. **Update contact information**:
   - Business address
   - Phone number(s)
   - Email address(es)
   - Business hours
   - Map embed (Google Maps)
3. **Form configuration** (if customizable)

### Portfolio Page

1. **Create Portfolio Projects collection** (if not exists)
2. **Add projects with**:
   - Client name (or anonymous)
   - Project description
   - Products used
   - Before/after images
   - Results/testimonial

---

## Site Settings

### General Settings

Create a "Site Settings" singleton collection for global settings:

- **Site Name**: Prem-Lichtwerbung
- **Tagline**: "Your Brand Deserves to Shine"
- **Contact Email**: Main business email
- **Contact Phone**: Main business phone
- **Business Address**: Full address with postcode
- **Business Hours**: Open hours for each day
- **Social Media Links**: Facebook, Instagram, LinkedIn, YouTube

### Brand Colors (Reference)

While colors are set in code, document them for consistency:

- **Electric Blue**: #00D9FF (Main accent)
- **Deep Navy**: #0A1628 (Backgrounds, headers)
- **Warm White**: #FFF8E7 (Text on dark)
- **Neon Pink**: #FF006E (CTAs, special offers)
- **Electric Yellow**: #FFD600 (Highlights, badges)

### Shipping Settings

- **Shipping Zones**: Countries/regions you ship to
- **Shipping Rates**: Flat rate, weight-based, or free shipping thresholds
- **Free Shipping Threshold**: Order amount for free shipping (e.g., €500+)
- **International Shipping**: Enable/disable

### Tax Settings

- **VAT Rate**: Default tax rate (e.g., 19% for Germany)
- **Tax Display**: Show prices with or without tax
- **Tax Calculation**: Based on shipping address or billing address

### Payment Settings

- **Stripe Publishable Key**: For live payments
- **Stripe Secret Key**: Backend configuration
- **Payment Methods**: Credit card, bank transfer, PayPal, etc.
- **Currency**: EUR (default)

---

## Best Practices

### Product Photography

✅ **Professional quality**: Invest in good photography or hire a professional
✅ **Consistent style**: Similar backgrounds, lighting, angles across all products
✅ **Day AND night images**: This is your unique selling point
✅ **Multiple angles**: Front, side, detail, installed views
✅ **Real installations**: Include customer installation photos when possible

### Product Descriptions

✅ **Focus on benefits**, not just features
✅ **Use clear, concise language** - Avoid jargon
✅ **Include technical specs** - Customers need details
✅ **Add dimensions and scale** - Help customers visualize size
✅ **Address common questions** - Reduce support inquiries

### Inventory Management

✅ **Update stock regularly** - Avoid selling out-of-stock items
✅ **Set realistic lead times** - Better to over-estimate
✅ **Mark seasonal products** - Adjust for seasonal demand
✅ **Low stock alerts** - Know when to reorder

### Customer Service

✅ **Respond within 24 hours** - Fast response builds trust
✅ **Be transparent about lead times** - Manage expectations
✅ **Offer professional mockups** - Help customers visualize custom designs
✅ **Follow up after delivery** - Request reviews and photos

### SEO Basics

✅ **Unique meta descriptions** - Don't duplicate across products
✅ **Descriptive URLs** - Use keyword-rich slugs
✅ **Alt text for all images** - Describe what's in the image
✅ **Internal linking** - Link related products and categories
✅ **Fresh content** - Regularly update product descriptions and add new products

---

## Pricing Strategy Guidelines

### Base Pricing

**Cost-Plus Method**:
```
Base Price = (Material Cost + Labor Cost + Overhead) × Markup
Markup typically 2.0-3.0x for custom signage
```

**Example**:
- Material Cost: €200
- Labor Cost: €150
- Overhead (20%): €70
- Total Cost: €420
- Markup (2.5x): €1,050 base price

### Customization Pricing

**Size Multipliers**:
- Small (50cm): 1.0x base
- Medium (100cm): 1.8x base
- Large (150cm): 2.8x base
- Extra Large (200cm+): 4.0x base

**Complexity Surcharges**:
- Simple design: +€0
- Moderate complexity: +15%
- High complexity: +30%
- Very high complexity: +50%

### Volume Discounts

Encourage larger orders:
- 2-4 units: 5% discount
- 5-9 units: 10% discount
- 10+ units: 15% discount
- Contact for bulk pricing on 50+ units

### Seasonal Promotions

- **New Customer**: 10% off first order
- **Holiday Sales**: Black Friday, New Year (15-20% off)
- **End of Season**: Clearance on discontinued models (30-50% off)
- **Referral Program**: Discount for referrals

### Professional Installation

Price installation separately:
- **Standard Installation**: 20-30% of product price
- **Complex Installation**: 40-50% of product price
- **High-Altitude/Difficult Access**: Custom quote required

---

## Lead Time Management

### Standard Lead Times

Set realistic production and delivery timeframes:

**Product Type** | **Production** | **Shipping** | **Total Lead Time**
---|---|---|---
Lightboxes (standard) | 7-10 days | 3-5 days | 10-15 days
Channel Letters | 14-21 days | 3-5 days | 17-26 days
LED Neon Signs | 10-14 days | 3-5 days | 13-19 days
Pylons/Totems | 21-30 days | 5-7 days | 26-37 days
Custom/Complex | 30-45 days | 5-7 days | 35-52 days

### Factors Affecting Lead Time

- **Customization Level**: More custom = longer lead time
- **Size**: Larger products require more production time
- **Complexity**: Intricate designs take longer
- **Order Volume**: Bulk orders may extend lead time
- **Seasonal Demand**: Busy seasons (holidays) extend timelines
- **Material Availability**: Special materials may need ordering

### Communicating Lead Times

✅ **Display clearly on product pages**: Set customer expectations upfront
✅ **Add buffer time**: Better to deliver early than late
✅ **Update customers proactively**: Email when production starts, during production, when shipped
✅ **Offer rush service**: Expedited production for +20-30% fee
✅ **Be honest about delays**: Communicate immediately if issues arise

### Rush Orders

Offer expedited service for urgent projects:
- **Standard Rush** (50% faster): +20% fee
- **Priority Rush** (75% faster): +40% fee
- **Emergency Rush** (as fast as possible): +60% fee + feasibility approval

---

## SEO Optimization

### On-Page SEO

#### Product Pages

**Title Tag** (50-60 chars):
```
[Product Name] | [Key Benefit] | Prem-Lichtwerbung
```

**Meta Description** (150-160 chars):
```
[Action verb] [product] for [use case]. [Key benefit]. [Call-to-action].
```

**Heading Structure**:
- H1: Product name (only one per page)
- H2: Key features, Specifications, Related products
- H3: Sub-sections within H2 content

**Image Optimization**:
- File name: descriptive-keyword-rich-name.jpg
- Alt text: Descriptive text with keywords
- Caption: Additional context if relevant

#### Category Pages

Similar structure to product pages but focused on category-level content.

### Technical SEO

✅ **Fast loading times**: Optimize images, use lazy loading
✅ **Mobile responsive**: Google prioritizes mobile-friendly sites
✅ **Clean URLs**: `/products/led-lightbox` not `/products?id=123`
✅ **XML sitemap**: Auto-generated by Directus
✅ **Robots.txt**: Allow search engine crawling
✅ **Structured data**: Product schema markup (JSON-LD)

### Content Strategy

**Blog Topics** (if blog is added):
- "How to Choose the Right Lightbox for Your Storefront"
- "LED vs Traditional Neon: Which is Better?"
- "5 Ways Illuminated Signage Increases Foot Traffic"
- "Installation Tips for Channel Letters"
- "Maintaining Your LED Signs: Best Practices"

**Regular Updates**:
- Add new products monthly
- Update product descriptions quarterly
- Refresh category content twice yearly
- Add portfolio projects as completed

### Local SEO

For local businesses:
- **Google My Business**: Claim and optimize listing
- **Local Keywords**: "LED signage Berlin", "lightbox shop Germany"
- **NAP Consistency**: Name, Address, Phone must match everywhere
- **Local Directories**: List in relevant business directories
- **Customer Reviews**: Encourage Google and Facebook reviews

### Link Building

- **Partner Links**: Collaborate with complementary businesses
- **Supplier Links**: Get listed on supplier websites
- **Industry Associations**: Join and get directory listings
- **Press Releases**: Announce major projects or milestones
- **Portfolio Sharing**: Case studies that clients may link to

---

## Troubleshooting

### Common Issues

**Problem**: Product not showing on website
- ✅ Check Status is set to "Published"
- ✅ Verify at least one category is assigned
- ✅ Check public permissions are configured
- ✅ Ensure day_image and night_image are uploaded

**Problem**: Images not loading
- ✅ Check file upload was successful
- ✅ Verify image permissions in Directus
- ✅ Check image file size (under 5MB recommended)
- ✅ Try re-uploading the image

**Problem**: Price calculator not working
- ✅ Verify product has "customizable" flag enabled
- ✅ Check configurator options are properly linked
- ✅ Ensure price modifiers are correctly formatted
- ✅ Test in browser console for JavaScript errors

**Problem**: Orders not appearing
- ✅ Check Stripe webhook configuration
- ✅ Verify order collection permissions
- ✅ Check logs for API errors
- ✅ Test with demo/test orders

### Getting Help

- **Documentation**: Check Directus official docs at directus.io/docs
- **Community**: Directus Discord community
- **Developer**: Contact your development team
- **Support**: Email support@prem-lichtwerbung.com (if configured)

---

## Security Best Practices

✅ **Change default passwords immediately**
✅ **Use strong passwords** (12+ characters, mixed case, numbers, symbols)
✅ **Enable two-factor authentication** (if available)
✅ **Limit admin access** - Only trusted staff
✅ **Regular backups** - Daily automated backups
✅ **Keep Directus updated** - Apply security patches
✅ **Monitor access logs** - Watch for suspicious activity
✅ **Use HTTPS** - SSL certificate for encrypted connections

---

## Maintenance Schedule

### Daily Tasks
- [ ] Check new orders and update status
- [ ] Respond to customer inquiries
- [ ] Review stock levels

### Weekly Tasks
- [ ] Update product lead times if needed
- [ ] Review and approve new customer reviews
- [ ] Check for out-of-stock products
- [ ] Analyze order trends

### Monthly Tasks
- [ ] Add new products
- [ ] Update seasonal promotions
- [ ] Review pricing strategy
- [ ] Export sales reports
- [ ] Update homepage banners/featured products

### Quarterly Tasks
- [ ] Audit all product information
- [ ] Refresh product photography
- [ ] Update category descriptions
- [ ] Review and optimize SEO
- [ ] Customer satisfaction survey

### Yearly Tasks
- [ ] Major content refresh
- [ ] Pricing strategy review
- [ ] System security audit
- [ ] Backup verification test
- [ ] Terms and conditions update

---

**Last Updated**: November 2024

**Questions or Issues?** Contact your development team or refer to the official Directus documentation at https://docs.directus.io/
