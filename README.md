# Webshop - Production-Ready E-commerce Application

A complete, production-ready webshop application with **semi-automatic quick-start setup**. Run `docker compose up --build` and complete one simple manual configuration step to enable public access.

> **⚠️ Important**: Due to Directus 11.x security restrictions, public API permissions cannot be configured via API (returns 403 Forbidden even with admin credentials). You must configure permissions manually via the admin panel **once** - this configuration persists across all container restarts.

## 🚀 Features

- **Semi-Automatic Setup** - One simple manual permission configuration (one-time only)
- **Directus 11.13.2** - Headless CMS backend
- **PostgreSQL 18.1** - Robust database
- **Vue.js 3.5.24 + TypeScript** - Modern frontend
- **Tailwind CSS 4.1.17** - Utility-first styling
- **Stripe Payments** - Integrated payment processing
- **Docker & Docker Compose** - Containerized deployment
- **Automatic Schema Import** - Collections, fields, relations
- **Sample Data Import** - 25 products, categories, tags, orders
- **NPM Dependency Checking** - Automated outdated package detection

## 📋 Prerequisites

- Docker Desktop (Windows/Mac) or Docker + Docker Compose (Linux)
- Git

## 🎯 Quick Start (Semi-Automatic)

```bash
# Clone the repository
git clone <repository-url>
cd webshop

# Start everything with one command
docker compose up --build
```

Docker will automatically:
1. ✅ Start PostgreSQL database
2. ✅ Initialize Directus
3. ✅ Import all schema (collections, fields, relations)
4. ✅ Import sample data (products, categories, tags, orders, reviews)
5. ✅ Create M2M relations
6. ✅ Start the Vue.js frontend
7. ✅ Check for outdated npm dependencies

**⚠️ One Manual Step Required:**

8. **Configure Public Permissions** (one-time setup, persists across restarts):
   - Open http://localhost:8055
   - Login: `admin@example.com` / `admin123`
   - Go to **Settings → Access Control → Public**
   - See [Manual Permissions Configuration](#public-api-permissions-issues-403-forbidden) section below for detailed steps

## 🌐 Access Points

After running `docker compose up --build`:

- **Frontend**: http://localhost:3000
- **Directus Admin**: http://localhost:8055
- **PostgreSQL**: localhost:5432

## 🔐 Default Credentials

### Directus Admin Panel
- **URL**: http://localhost:8055
- **Email**: `admin@example.com`
- **Password**: `admin123`

### Sample Customer Account
- **Email**: `john.doe@example.com`
- **Password**: `password123` (hashed in database)

### Database
- **Host**: localhost
- **Port**: 5432
- **Database**: directus
- **User**: directus
- **Password**: directus

## 💳 Stripe Configuration

### Setup Stripe Integration

1. Get your Stripe keys from https://dashboard.stripe.com/test/apikeys

2. Update `docker-compose.yml`:

```yaml
# In directus service environment:
STRIPE_SECRET_KEY: "sk_test_your_secret_key_here"
STRIPE_PUBLISHABLE_KEY: "pk_test_your_publishable_key_here"

# In frontend service environment:
VITE_STRIPE_PUBLISHABLE_KEY: "pk_test_your_publishable_key_here"
```

3. Restart containers:

```bash
docker compose down
docker compose up --build
```

## 📊 Automatic Data Import

The system automatically imports:

### Collections (13 total)
- `products`, `categories`, `tags`
- `products_categories`, `products_tags` (M2M)
- `customers`, `addresses`, `orders`, `order_items`
- `reviews`, `pages`, `banners`, `settings`

### Sample Data
- **10 Categories** (with parent-child hierarchy)
- **8 Tags** (New Arrival, Best Seller, Sale, Premium, etc.)
- **25 Products** (Electronics, Fashion, Home & Garden, Sports)
- **1 Sample Customer** (john.doe@example.com)
- **1 Sample Order** (with 2 items)
- **3 Product Reviews**

## 📝 Managing Products in Directus Admin

### Assigning Categories and Tags to Products

The Directus admin UI provides an intuitive interface for managing product relationships with categories and tags through Many-to-Many (M2M) fields.

**To assign categories or tags to a product:**

1. **Open Directus Admin Panel**
   - Navigate to http://localhost:8055
   - Login with: `admin@example.com` / `admin123`

2. **Navigate to Products**
   - Click on **Products** in the left sidebar
   - Select an existing product or create a new one

3. **Assign Categories**
   - Scroll down to the **Categories** field in the product edit form
   - Click the **"+ Add"** button
   - Select one or multiple categories from the list
   - Categories can be removed by clicking the **×** icon next to each

4. **Assign Tags**
   - Scroll down to the **Tags** field in the product edit form
   - Click the **"+ Add"** button
   - Select one or multiple tags from the list
   - Tags can be removed by clicking the **×** icon next to each

5. **Save the Product**
   - Click **Save** in the top-right corner

**Important Notes:**
- Products can belong to multiple categories simultaneously
- Products can have multiple tags
- Changes are immediately reflected in the frontend after saving
- The M2M relationships are stored in `products_categories` and `products_tags` junction tables
- To keep existing data after updates, restart with: `docker compose down && docker compose up --build` (without `-v` flag)

## 🔍 NPM Dependency Checking

```bash
# View dependency check results
docker compose logs dependency-checker

# Check manually
docker compose exec frontend npm outdated
docker compose exec directus npm outdated

# Update dependencies
docker compose exec frontend npx npm-check-updates -u
docker compose exec frontend npm install
```

## 🛠️ Development

### View Logs
```bash
docker compose logs -f
docker compose logs -f directus
docker compose logs -f frontend
```

### Restart Services
```bash
docker compose restart
docker compose restart directus
```

### Stop Services
```bash
docker compose down

# Stop and remove volumes (⚠️ deletes all data)
docker compose down -v
```

## 🚨 Troubleshooting

### Containers won't start
```bash
docker compose down -v
docker compose up --build
```

### Check Directus health
```bash
curl http://localhost:8055/server/health
```

### Public API Permissions Issues (403 Forbidden)

⚠️ **Directus 11.x Security Limitation**: The Public role cannot be modified via API (returns 403 Forbidden even with admin credentials). This is a Directus security restriction that prevents automated permission configuration. **Manual configuration via the admin panel is required**.

#### Symptoms

If you get 403 errors when accessing public API endpoints:

```bash
# Test public API access
curl http://localhost:8055/items/products

# Error response:
# {"errors":[{"message":"You don't have permission to access collection 'products' or it does not exist."}]}
```

**This is expected behavior** - Directus 11.x requires manual permission configuration through the admin panel. This is a **one-time setup that persists across all container restarts**.

#### Solution: Manual Permissions Configuration (Required)

Follow these steps to enable public API access:

**Step 1: Log in to Directus Admin Panel**
- Open http://localhost:8055 in your browser
- Email: `admin@example.com`
- Password: `admin123`
- Click **Sign In**

**Step 2: Navigate to Access Control**
- Click the **Settings** icon (⚙️) in the bottom-left sidebar
- Click **Access Control** in the settings menu
- Find and click on the **Public** role

**Step 3: Configure Read Permissions**

For each collection below, click **"+ Create"** under the Permissions tab and configure:

**Public Collections (Read Access):**

1. **products**
   - Action: `read`
   - Fields: Select **All** or choose: `id, name, slug, description, price, compare_at_price, stock, sku, weight, featured, status, date_created, date_updated`
   - Permissions: Leave empty (no filter needed - all published products)
   - Click **Save**

2. **categories**
   - Action: `read`
   - Fields: Select **All**
   - Permissions: Leave empty (no filter)
   - Click **Save**

3. **tags**
   - Action: `read`
   - Fields: Select **All**
   - Permissions: Leave empty (no filter)
   - Click **Save**

4. **products_categories** (M2M junction table)
   - Action: `read`
   - Fields: Select **All**
   - Permissions: Leave empty (no filter)
   - Click **Save**

5. **products_tags** (M2M junction table)
   - Action: `read`
   - Fields: Select **All**
   - Permissions: Leave empty (no filter)
   - Click **Save**

6. **reviews**
   - Action: `read`
   - Fields: Select **All**
   - Permissions: Leave empty (no filter)
   - Click **Save**

7. **pages**
   - Action: `read`
   - Fields: Select **All**
   - Permissions: Leave empty (no filter)
   - Click **Save**

8. **banners**
   - Action: `read`
   - Fields: Select **All**
   - Permissions: Leave empty (no filter)
   - Click **Save**

9. **settings**
   - Action: `read`
   - Fields: Select **All**
   - Permissions: Leave empty (no filter)
   - Click **Save**

10. **directus_files** ⚠️ **CRITICAL for images**
    - Action: `read`
    - Fields: Select **All**
    - Permissions: Leave empty (no filter)
    - Click **Save**
    - **Note:** This permission is required for the frontend to display product images, category images, and gallery images. Without it, you'll get 403 errors when querying products with image fields.

**Step 4: Configure Create Permissions (for user registration and orders)**

11. **customers**
    - Action: `create`
    - Fields: Select `email, password_hash, first_name, last_name, phone`
    - Permissions: Leave empty
    - Click **Save**

12. **orders**
    - Action: `create`
    - Fields: Select `customer_id, status, payment_status, total, subtotal, tax, shipping, shipping_address_id, billing_address_id, stripe_payment_intent_id, stripe_checkout_session_id, notes`
    - Permissions: Leave empty
    - Click **Save**

**Step 5: Verify Configuration**

Test public API access:

```bash
# Test products endpoint
curl http://localhost:8055/items/products

# Should return JSON with product data
# Example: {"data":[{"id":1,"name":"MacBook Pro 16-inch",...}]}
```

**Step 6: Refresh Frontend**

After configuring permissions:
- Refresh your frontend at http://localhost:3000
- Products should now load correctly
- Categories and other public data should be accessible

#### Complete Reset

If issues persist, perform a complete reset:

```bash
# Stop and remove all containers and volumes
docker compose down -v

# Remove any cached Docker images
docker compose build --no-cache

# Start fresh
docker compose up --build
```

### Check products imported
```bash
curl http://localhost:8055/items/products
```

## 📦 Tech Stack

**Backend**: Directus 11.13.2, PostgreSQL 18.1, Node.js 20, Stripe SDK

**Frontend**: Vue.js 3.5.24, TypeScript 5.3.3, Tailwind CSS 4.1.17, Pinia 2.1.7, Vue Router 4.2.5, Vite 5.0.12

## 🔒 Production Security

Before production deployment:

1. Change default credentials in `docker-compose.yml`
2. Add real Stripe keys (replace test keys)
3. Enable HTTPS with reverse proxy
4. Use strong database passwords
5. Configure CORS properly (no wildcards)

---

**🎉 Enjoy your fully automatic webshop setup!**

No manual configuration needed - just run `docker compose up --build` and start developing!
