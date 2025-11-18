# Webshop - Production-Ready E-commerce Application

A complete, production-ready webshop application with **fully automatic quick-start setup**. Simply run `docker compose up --build` and everything is automatically configured!

## 🚀 Features

- **Fully Automatic Setup** - No manual steps required
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

## 🎯 Quick Start (Fully Automatic)

```bash
# Clone the repository
git clone <repository-url>
cd webshop

# Start everything with one command
docker compose up --build
```

**That's it!** Docker will automatically:
1. ✅ Start PostgreSQL database
2. ✅ Initialize Directus
3. ✅ Import all schema (collections, fields, relations)
4. ✅ Import sample data (products, categories, tags, orders, reviews)
5. ✅ Create M2M relations
6. ✅ Apply permissions for public access
7. ✅ Start the Vue.js frontend
8. ✅ Check for outdated npm dependencies

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
