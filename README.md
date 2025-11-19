# Prem-Lichtwerbung - Premium Illuminated Signage Webshop

A production-ready e-commerce application for **Prem-Lichtwerbung**, specializing in premium illuminated signage and custom lighting solutions.

> **Brand Mission**: "Your Brand Deserves to Shine"

> **⚠️ Important**: Due to Directus 11.x security restrictions, public API permissions must be configured manually via the admin panel **once** (persists across restarts).

## 🚀 Features

- **Semi-Automatic Setup** - Docker Compose + one manual permission configuration
- **Tech Stack** - Directus 11.13.2, PostgreSQL 18.1, Vue.js 3.5.24 + TypeScript, Tailwind CSS 4.1.17
- **25 Sample Products** - Lightboxes, Channel Letters, LED Neon Signs, Pylons, Fascia, Window Signs
- **Product Customization** - Live price calculator, logo upload with mockup preview
- **Visual Features** - Day/night image toggle, before/after sliders, glow effects
- **Mobile-First Design** - Fully responsive with touch interactions
- **Stripe Integration** - Payment processing with demo mode

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

## 📊 Sample Data Included

- **25 Signage Products** - Lightboxes, Channel Letters, LED Neon, Pylons, Fascia, Window Signs
- **7 Product Categories** - Organized with parent-child hierarchy
- **Sample Customer & Orders** - For testing checkout and order tracking

## 💳 Stripe Configuration (Optional)

Update `docker-compose.yml` with your Stripe keys from https://dashboard.stripe.com/test/apikeys and restart containers. Demo mode works without configuration.

## 🛠️ Development Commands

```bash
# View logs
docker compose logs -f

# Restart services
docker compose restart

# Complete reset (deletes all data)
docker compose down -v && docker compose up --build
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
   - Fields: Select **All**
   - Permissions: Leave empty
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

**Step 4: Verify & Access**

After configuring permissions, refresh http://localhost:3000 - products and categories should now load correctly.

## 📦 Tech Stack

**Backend**: Directus 11.13.2, PostgreSQL 18.1, Node.js 20, Stripe SDK

**Frontend**: Vue.js 3.5.24, TypeScript 5.3.3, Tailwind CSS 4.1.17, Pinia 2.1.7, Vue Router 4.2.5, Vite 5.0.12

## 🔒 Production Deployment

Before deploying to production:

1. **Change Default Credentials** - Update all passwords and generate secure random keys in `docker-compose.yml` (POSTGRES_PASSWORD, KEY, SECRET, ADMIN_PASSWORD)
2. **Stripe Production Keys** - Replace test keys with live keys from https://dashboard.stripe.com/apikeys
3. **Enable HTTPS** - Configure reverse proxy (Nginx/Traefik/Caddy) with SSL certificates
4. **Configure CORS** - Set specific domain instead of wildcard in CORS_ORIGIN
5. **Production Settings** - Enable caching, rate limiting, reduce log level, disable auto-reload
6. **Configure Permissions** - Complete manual public permissions setup via admin panel
7. **Backups** - Set up automated backups for database and uploads volumes
8. **Environment Variables** - Use `.env` file for sensitive values (never commit to git)
9. **Security Headers** - Configure in reverse proxy (HSTS, X-Frame-Options, CSP, etc.)
10. **Monitoring** - Set up health checks, performance monitoring, and error logging

For detailed production setup, see `docs/ADMIN_GUIDE.md`.

---

**🎉 Ready to start!** Run `docker compose up --build` and complete the one-time permission configuration.
