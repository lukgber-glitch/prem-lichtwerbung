# Railway.app Deployment Guide

This guide provides step-by-step instructions for deploying the Prem Lichtwerbung webshop to Railway.app for client demos.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Railway Project Setup](#railway-project-setup)
3. [Required Environment Variables](#required-environment-variables)
4. [Service Configuration](#service-configuration)
5. [Public URL Generation](#public-url-generation)
6. [Directus Permissions Configuration](#directus-permissions-configuration)
7. [Post-Deployment Verification](#post-deployment-verification)
8. [Troubleshooting](#troubleshooting)

---

## Prerequisites

- GitHub account with this repository pushed
- Railway.app account (sign up at https://railway.app)
- Strong passwords and secret keys ready for production

---

## Railway Project Setup

**⚠️ IMPORTANT**: Railway's automatic buildpack (Railpack) **does NOT support docker-compose.yml**. You must manually create each service separately in Railway and point each one to its respective Dockerfile.

### Step 1: Create New Railway Project

1. Log in to [Railway.app](https://railway.app)
2. Click **"New Project"**
3. Click **"Empty Project"**
4. Give your project a name (e.g., "prem-lichtwerbung-demo")

### Step 2: Add PostgreSQL Database Service

1. Click **"+ New"** in your project
2. Select **"Database"** → **"Add PostgreSQL"**
3. Railway will create a managed PostgreSQL instance
4. Go to **Variables** tab and add:
   - `POSTGRES_PASSWORD` - Set a strong password (e.g., `YourStr0ngP@ssw0rd!2024`)
5. Note: Railway automatically sets `POSTGRES_USER` and `POSTGRES_DB`

### Step 3: Add Directus Service

1. Click **"+ New"** in your project
2. Select **"GitHub Repo"**
3. Select the repository: `prem-lichtwerbung`
4. Select branch: `feature/dependency-updates` (or `main`)
5. In **Settings** → **Build**:
   - Set **Root Directory**: `/` (leave empty or set to root)
   - Set **Dockerfile Path**: `directus/Dockerfile`
6. In **Variables** tab, add all required variables (see [Required Environment Variables](#required-environment-variables) section)
7. Name this service "directus"

### Step 4: Add Frontend Service

1. Click **"+ New"** in your project
2. Select **"GitHub Repo"**
3. Select the repository: `prem-lichtwerbung` (same repo)
4. Select branch: `feature/dependency-updates` (or `main`)
5. In **Settings** → **Build**:
   - Set **Root Directory**: `/` (leave empty or set to root)
   - Set **Dockerfile Path**: `frontend/Dockerfile`
6. In **Variables** tab, add required variables (see [Required Environment Variables](#required-environment-variables) section)
7. Name this service "frontend"

### Step 5: Configure Service Dependencies

Railway doesn't automatically handle docker-compose `depends_on`, so ensure:
1. PostgreSQL is fully deployed before deploying Directus
2. Directus is fully deployed before deploying Frontend
3. Watch deployment logs to ensure proper startup order

---

## Required Environment Variables

### PostgreSQL Service (`postgres`)

Configure these in Railway's postgres service environment variables:

| Variable | Description | Example |
|----------|-------------|---------|
| `POSTGRES_PASSWORD` | Strong database password | `YourStr0ngP@ssw0rd!2024` |

### Directus Service (`directus`)

Configure these in Railway's directus service environment variables:

| Variable | Required | Description | Example |
|----------|----------|-------------|---------|
| `POSTGRES_PASSWORD` | ✅ Yes | Must match postgres password | `YourStr0ngP@ssw0rd!2024` |
| `ADMIN_EMAIL` | ✅ Yes | Directus admin email | `admin@yourcompany.com` |
| `ADMIN_PASSWORD` | ✅ Yes | Strong admin password (NOT "admin123") | `Adm1n$ecureP@ss!` |
| `DIRECTUS_KEY` | ✅ Yes | Random 32+ character key | `a1b2c3d4e5f6...` (generate with openssl) |
| `DIRECTUS_SECRET` | ✅ Yes | Random 32+ character secret | `x9y8z7w6v5u4...` (generate with openssl) |
| `PUBLIC_URL` | ✅ Yes | Your Railway directus domain | `https://your-app-directus.railway.app` |
| `CORS_ORIGIN` | ✅ Yes | Frontend domain for CORS | `https://your-app-frontend.railway.app` |
| `VITE_STRIPE_PUBLISHABLE_KEY` | ⚠️ Optional | Stripe publishable key | `pk_live_...` or `pk_test_...` |
| `STRIPE_SECRET_KEY` | ⚠️ Optional | Stripe secret key | `sk_live_...` or `sk_test_...` |
| `STRIPE_WEBHOOK_SECRET` | ⚠️ Optional | Stripe webhook secret | `whsec_...` |

#### Generate Secure Keys

Use these commands to generate secure random keys:

```bash
# Generate DIRECTUS_KEY (32 characters)
openssl rand -base64 32

# Generate DIRECTUS_SECRET (32 characters)
openssl rand -base64 32
```

Or use an online generator like https://www.random.org/strings/

### Frontend Service (`frontend`)

Configure these in Railway's frontend service environment variables:

| Variable | Required | Description | Example |
|----------|----------|-------------|---------|
| `VITE_DIRECTUS_URL` | ✅ Yes | Public URL of directus service | `https://your-app-directus.railway.app` |
| `VITE_STRIPE_PUBLISHABLE_KEY` | ⚠️ Optional | Stripe publishable key | `pk_live_...` or `pk_test_...` |

---

## Service Configuration

### Internal Networking

Railway provides internal networking between services using Railway's private networking or service-to-service communication:

- **Frontend → Directus**: Uses public URL via `VITE_DIRECTUS_URL` environment variable
  - Example: `https://your-app-directus.up.railway.app`
  - Frontend makes API calls to Directus public endpoint
  
- **Directus → PostgreSQL**: Uses Railway's internal connection variables
  - Railway automatically injects connection variables for managed PostgreSQL
  - Set `DB_HOST` to Railway's `PGHOST` variable reference
  - Or manually configure using Railway's internal PostgreSQL hostname
  - Railway provides `DATABASE_URL` that contains all connection info

**Important**: When connecting Directus to Railway's managed PostgreSQL:
1. Use environment variable references (e.g., `${{PGHOST}}`, `${{PGPORT}}`)
2. Or copy the connection details from PostgreSQL service's Variables tab
3. Ensure `DB_PASSWORD` matches the PostgreSQL service's password

### Persistent Volumes

Railway volumes must be **manually configured** in the Railway UI for each service:

**For Directus Service:**
1. Go to directus service → **Settings** → **Volumes**
2. Click **"New Volume"**
3. Set mount path: `/directus/uploads`
4. Railway creates a persistent volume that survives redeployments

**For PostgreSQL Service:**
- Railway's managed PostgreSQL automatically includes persistent storage
- No manual volume configuration needed
- Database data persists across restarts

**Important Notes:**
- Volumes are NOT automatically detected from docker-compose.yml
- Each volume must be created manually in Railway's UI
- Images uploaded to Directus will persist only if volume is configured
- Volume data persists across redeployments and restarts

### Health Checks and Deployment

Railway monitors service health automatically:

- **PostgreSQL**: Railway's managed database includes built-in health monitoring
- **Directus**: Railway monitors the HTTP endpoint and process status
  - Dockerfile includes `wget` for health checking
  - Railway detects when the service is responding on the exposed port
- **Frontend**: Railway monitors the Vite dev server process

**Deployment Behavior:**
- Railway marks services as "Deployed" when they start successfully
- Monitor deployment logs to verify services start without errors
- Services may take 30-60 seconds to fully initialize (especially Directus bootstrap)

---

## Public URL Generation

### Step 1: Generate Public Domains

After deployment, generate public URLs for your services:

1. Go to your Railway project dashboard
2. Click on the **directus** service
3. Go to **Settings → Networking**
4. Click **"Generate Domain"**
5. Note the generated URL: `https://your-app-directus.up.railway.app`
6. Repeat for the **frontend** service
7. Note the generated URL: `https://your-app-frontend.up.railway.app`

### Step 2: Update Environment Variables

Update these environment variables with the generated URLs:

**In directus service:**
- `PUBLIC_URL` = `https://your-app-directus.up.railway.app`
- `CORS_ORIGIN` = `https://your-app-frontend.up.railway.app`

**In frontend service:**
- `VITE_DIRECTUS_URL` = `https://your-app-directus.up.railway.app`

### Step 3: Redeploy Services

After updating environment variables:
1. Click **"Deploy"** on each service to restart with new variables
2. Wait for health checks to pass
3. Verify services are running

---

## Directus Permissions Configuration

**⚠️ CRITICAL**: This is a **one-time manual step** required for the application to work.

### Why Manual Configuration is Required

Directus 11.x has a security restriction that prevents the Public role from being modified via API, even with admin credentials. This must be configured through the admin panel.

### Configuration Steps

1. **Access Directus Admin Panel**
   - Open your directus public URL: `https://your-app-directus.up.railway.app`
   - Log in with your `ADMIN_EMAIL` and `ADMIN_PASSWORD`

2. **Navigate to Access Control**
   - Click **Settings** (gear icon in sidebar)
   - Click **Access Control**
   - Click **Public** role

3. **Configure Read Permissions**
   
   Add **READ** access for these collections:
   - ✅ `products` - All fields
   - ✅ `categories` - All fields
   - ✅ `tags` - All fields
   - ✅ `products_categories` - All fields (junction table)
   - ✅ `products_tags` - All fields (junction table)
   - ✅ `reviews` - All fields
   - ✅ `pages` - All fields
   - ✅ `banners` - All fields
   - ✅ `settings` - All fields
   - ✅ `directus_files` - All fields (for image access)

4. **Configure Create Permissions**
   
   Add **CREATE** access for these collections:
   - ✅ `customers` - All fields
   - ✅ `orders` - All fields

5. **Save Configuration**
   - Click **Save** after configuring each collection
   - Verify all permissions are marked with checkmarks

### Verification

Test that permissions are working:
1. Open your frontend URL in an incognito/private window
2. Browse products - should load without 403 errors
3. Try adding a product to cart - should work
4. Check browser console - no API permission errors

**✅ This configuration persists across redeployments and container restarts.**

---

## Post-Deployment Verification

### 1. Check Service Health

In Railway dashboard:
- All three services should show **"Deployed"** status
- Health checks should be green/passing
- No error logs in recent deployments

### 2. Test Frontend

Open your frontend public URL:
- ✅ Homepage loads successfully
- ✅ Products display with images
- ✅ Navigation works
- ✅ No 403 Forbidden errors in browser console

### 3. Test Directus API

Test API endpoint directly:
```bash
curl https://your-app-directus.up.railway.app/items/products
```

Should return JSON with product data (not 403 error).

### 4. Test Database Connection

In Directus admin panel:
- ✅ Collections are visible
- ✅ Can view and edit data
- ✅ Image uploads work
- ✅ No connection errors

### 5. Test Image Uploads

1. Log into Directus admin panel
2. Go to **File Library**
3. Try uploading a test image
4. Verify image appears and is accessible
5. Check that image persists after service restart

---

## Troubleshooting

### Issue: Railpack could not determine how to build the app

**Symptoms:**
- Deployment fails with error: "error creating build plan with railpack ✖ Railpack could not determine how to build the app"
- Railway cannot detect the project type

**Root Cause:**
Railway's automatic buildpack detection (Railpack) **does NOT support docker-compose.yml files**. When you try to deploy a repository containing only docker-compose.yml without specifying a Dockerfile path, Railpack fails to identify how to build the application.

**Solution:**
You must manually create each service in Railway and point each one to its respective Dockerfile. Railway does not automatically parse docker-compose.yml and create multiple services.

**Fix:**
1. **Do NOT** use "Deploy from GitHub repo" with auto-detection
2. Follow the [Railway Project Setup](#railway-project-setup) instructions above:
   - Create an **Empty Project** in Railway
   - Add PostgreSQL as a **managed database service**
   - Add Directus service manually, pointing to `directus/Dockerfile`
   - Add Frontend service manually, pointing to `frontend/Dockerfile`
3. Configure environment variables for each service
4. Deploy services in the correct order (PostgreSQL → Directus → Frontend)

**Note:** Railway requires explicit Dockerfile paths for each service. The `docker-compose.yml` file in this repository is only used for local development with Docker Compose, not for Railway deployment.

---

### Issue: VOLUME Keyword Banned in Dockerfiles

**Symptoms:**
- Build fails with error: "The `VOLUME` keyword is banned in Dockerfiles"
- Railway rejects the Dockerfile during build

**Root Cause:**
Railway does not support the `VOLUME` instruction in Dockerfiles. Persistent storage must be configured through Railway's Volume system.

**Solution:**
1. Check that `directus/Dockerfile` and `frontend/Dockerfile` do **NOT** contain `VOLUME` instructions
2. The Dockerfiles in this repository are already Railway-compatible
3. Configure persistent volumes in Railway UI:
   - Go to service → Settings → Volumes
   - Add volume mount: `/directus/uploads` for Directus service
   - Railway will handle volume persistence automatically

**Note:** See [Railway Volumes Documentation](https://docs.railway.com/reference/volumes) for more details.

---

### Issue: Dockerfile COPY Error - File Not Found

**Symptoms:**
- Build fails with error: `failed to calculate checksum of ref ... "/entrypoint.sh": not found`
- Or: `npm error enoent Could not read package.json: Error: ENOENT: no such file or directory, open '/app/package.json'`
- Error occurs at Dockerfile line with `COPY` or `RUN npm install`
- Build fails during Docker image creation

**Root Cause:**
When Railway builds with **Root Directory: /** and **Dockerfile Path: directus/Dockerfile** (or **frontend/Dockerfile**), the Docker build context is set to the **project root**, not the service subdirectory. All `COPY` commands in the Dockerfile must use paths relative to the project root.

**Example Error (Directus Service):**
```
Dockerfile:17
-------------------
15 |     # Copy bootstrap scripts and data
16 |     COPY bootstrap /directus/bootstrap
17 | >>> COPY entrypoint.sh /directus/entrypoint.sh
18 |
19 |     # Make entrypoint executable
-------------------
ERROR: failed to build: failed to solve: failed to compute cache key: 
failed to calculate checksum of ref: "/entrypoint.sh": not found
```

**Example Error (Frontend Service):**
```
Dockerfile:9
-------------------
7 |
8 |     # Install dependencies
9 | >>> RUN npm install
10 |
11 |     # Copy application files
-------------------
npm error code ENOENT
npm error syscall open
npm error path /app/package.json
npm error errno -2
npm error enoent Could not read package.json: Error: ENOENT: no such file or directory, open '/app/package.json'
ERROR: failed to build: process "/bin/sh -c npm install" did not complete successfully: exit code: 254
```

**Solution:**
Update all `COPY` commands in **both** `directus/Dockerfile` and `frontend/Dockerfile` to use paths relative to the project root:

**For `directus/Dockerfile`:**
```dockerfile
# ❌ WRONG - Relative to Dockerfile location
COPY entrypoint.sh /directus/entrypoint.sh
COPY bootstrap /directus/bootstrap
COPY package.json package-lock.json* ./

# ✅ CORRECT - Relative to project root (build context)
COPY directus/entrypoint.sh /directus/entrypoint.sh
COPY directus/bootstrap /directus/bootstrap
COPY directus/package.json directus/package-lock.json* ./
```

**For `frontend/Dockerfile`:**
```dockerfile
# ❌ WRONG - Relative to Dockerfile location
COPY package*.json ./
COPY . .

# ✅ CORRECT - Relative to project root (build context)
COPY frontend/package*.json ./
COPY frontend/ .
```

**Note:** The Dockerfiles in this repository have been updated to use correct paths for Railway deployment. This issue is resolved in the current version.

---

### Issue: Blocked Request - Host Not Allowed

**Symptoms:**
- Frontend deployment succeeds but shows error page when accessed
- Error message: "Blocked request. This host ('frontend-production-xxxx.up.railway.app') is not allowed"
- Vite suggests adding the host to `server.allowedHosts` in vite.config.js
- Browser shows connection error or blank page

**Root Cause:**
Vite's development server includes host checking for security. Railway generates dynamic public domains (e.g., `frontend-production-a583.up.railway.app`), which Vite blocks by default because they don't match `localhost`. The `server.allowedHosts` configuration must explicitly allow Railway domains.

**Solution:**
The `frontend/vite.config.ts` file has been updated to allow Railway domains:

```typescript
server: {
  host: '0.0.0.0',
  port: parseInt(process.env.PORT || '3000'),
  allowedHosts: ['.railway.app'],  // ✅ Allows all *.railway.app domains
  watch: {
    usePolling: true
  }
}
```

**If you still see this error:**
1. Verify `frontend/vite.config.ts` includes `allowedHosts: ['.railway.app']`
2. Redeploy the frontend service in Railway
3. Clear browser cache and retry
4. Check Railway logs for any build errors

**Note:** The dot prefix in `.railway.app` matches all subdomains (e.g., `frontend-production-a583.up.railway.app`, `frontend-staging-b123.up.railway.app`).

---

### Issue: 403 Forbidden on Frontend API Calls

**Symptoms:**
- Frontend loads but no products display
- Browser console shows 403 errors for `/items/products`

**Solution:**
1. Verify [Directus Permissions Configuration](#directus-permissions-configuration) is complete
2. Check that Public role has READ access to all required collections
3. Clear browser cache and retry

---

### Issue: CORS Errors

**Symptoms:**
- Browser console shows CORS policy errors
- API requests blocked by CORS

**Solution:**
1. Verify `CORS_ORIGIN` in directus service matches frontend public URL
2. Ensure `CORS_ENABLED` is set to `"true"`
3. Check format: `https://your-app-frontend.up.railway.app` (no trailing slash)
4. Redeploy directus service after changing CORS_ORIGIN

---

### Issue: Directus Won't Start / Crashes

**Symptoms:**
- Directus service shows "Crashed" status
- Health checks failing

**Solution:**
1. Check Railway logs for directus service
2. Common issues:
   - Missing required environment variables (KEY, SECRET, ADMIN_PASSWORD)
   - PostgreSQL not ready (check postgres service status)
   - Incorrect DB_PASSWORD (must match POSTGRES_PASSWORD)
3. Verify all [Required Environment Variables](#required-environment-variables) are set
4. Check postgres service is healthy before directus starts

---

### Issue: Images Not Persisting

**Symptoms:**
- Images uploaded to Directus disappear after redeployment
- File library is empty after restart

**Solution:**
1. Verify volume is configured in Railway:
   - Go to directus service → Settings → Volumes
   - Should see `webshop_directus_uploads` mounted at `/directus/uploads`
2. Check docker-compose.yml volume mapping is correct
3. If volume is missing, create it manually in Railway:
   - Add volume mount: `/directus/uploads`
4. Redeploy service

---

### Issue: Database Connection Failures

**Symptoms:**
- Directus logs show "Connection refused" or "ECONNREFUSED"
- Cannot connect to PostgreSQL

**Solution:**
1. Verify postgres service is running and healthy
2. Check `DB_PASSWORD` matches `POSTGRES_PASSWORD` exactly
3. Verify internal networking:
   - DB_HOST should be `postgres` (service name)
   - DB_PORT should be `5432`
4. Check Railway service dependencies (directus depends_on postgres)
5. Review postgres service logs for errors

---

### Issue: Bootstrap Process Keeps Running

**Symptoms:**
- Directus takes very long to start
- Bootstrap runs on every deployment
- Sample data gets duplicated

**Solution:**
1. Bootstrap flag file may not be persisting
2. Ensure `/directus/.bootstrap_complete` is in a persistent location
3. Check directus logs to see if bootstrap completes successfully
4. If bootstrap fails mid-process:
   - Clear database and restart deployment
   - Or manually create flag file via Railway CLI

---

### Issue: Frontend Can't Connect to Directus

**Symptoms:**
- Frontend loads but shows "API connection failed"
- Network errors when fetching data

**Solution:**
1. Verify `VITE_DIRECTUS_URL` is set correctly in frontend service
2. Must be the PUBLIC URL of directus (not internal hostname)
3. Format: `https://your-app-directus.up.railway.app` (no trailing slash)
4. Test directus URL directly in browser - should load Directus admin
5. Redeploy frontend service after changing VITE_DIRECTUS_URL

---

### Issue: Environment Variables Not Taking Effect

**Symptoms:**
- Changed environment variables but behavior hasn't changed
- Still seeing old values in logs

**Solution:**
1. Environment variables require a **redeploy** to take effect
2. In Railway, after changing variables:
   - Click service → Click "Deploy" button
   - Or use "Redeploy" option
3. Wait for new deployment to complete
4. Check logs to verify new values are being used

---

### Issue: Service Uses Wrong Port

**Symptoms:**
- Service crashes with port binding errors
- Railway shows "Port not bound"

**Solution:**
1. Railway automatically assigns a `PORT` environment variable
2. Ensure services use this port:
   - Directus: Should bind to `PORT` (default 8055)
   - Frontend: vite.config.ts uses `process.env.PORT`
3. Check Dockerfile EXPOSE directives match
4. Verify railway.json configuration

---

### Getting Help

If you encounter issues not covered here:

1. **Check Railway Logs**
   - Click service → Logs tab
   - Look for error messages and stack traces

2. **Review Railway Documentation**
   - https://docs.railway.app/

3. **Check Directus Documentation**
   - https://docs.directus.io/

4. **Common Log Locations**
   - Directus: Railway logs for directus service
   - PostgreSQL: Railway logs for postgres service
   - Frontend: Browser console + Railway logs

5. **Railway Support**
   - Railway Discord: https://discord.gg/railway
   - Railway GitHub: https://github.com/railwayapp/railway

---

## Security Checklist

Before going to production:

- [ ] Changed `ADMIN_PASSWORD` from default "admin123"
- [ ] Generated secure `DIRECTUS_KEY` (32+ characters)
- [ ] Generated secure `DIRECTUS_SECRET` (32+ characters)
- [ ] Set strong `POSTGRES_PASSWORD`
- [ ] Updated `ADMIN_EMAIL` to your company email
- [ ] Configured `CORS_ORIGIN` to only allow your frontend domain
- [ ] Set `PUBLIC_URL` to your production directus domain
- [ ] Removed or secured Directus admin panel access (consider IP whitelist)
- [ ] Set up Stripe live keys (if accepting real payments)
- [ ] Configured proper PUBLIC role permissions (read-only for public data)
- [ ] Enabled HTTPS on all Railway domains (automatic)
- [ ] Verified all `.env` files are in `.gitignore`
- [ ] Reviewed Railway logs for any exposed secrets

---

## Maintenance

### Updating the Application

1. Push changes to GitHub repository
2. Railway automatically detects changes and redeploys
3. Database and uploads persist across deployments
4. Monitor Railway logs during deployment

### Database Backups

Railway provides automatic backups for PostgreSQL:
1. Go to postgres service → Settings → Backups
2. Configure backup schedule
3. Download backups as needed

### Monitoring

Monitor your deployment:
1. Railway Dashboard - Service health and metrics
2. Directus Logs - Application errors and API issues
3. Browser Console - Frontend errors
4. Railway Metrics - CPU, Memory, Network usage

---

## Cost Optimization

Railway pricing tips:

1. **Use Railway's Free Tier** for demos (includes $5 credit/month)
2. **Pause services** when not actively demoing
3. **Monitor usage** in Railway dashboard
4. **Optimize images** in directus/uploads to reduce storage
5. **Remove dependency-checker** service (already commented out)

---

## Additional Resources

- [Railway Documentation](https://docs.railway.app/)
- [Directus Documentation](https://docs.directus.io/)
- [Docker Compose on Railway](https://docs.railway.app/deploy/deployments#docker-compose)
- [Environment Variables on Railway](https://docs.railway.app/develop/variables)
- [Railway Volumes](https://docs.railway.app/develop/volumes)

---

**Last Updated:** 2025-11-27
**Railway API Version:** v2
**Directus Version:** 11.13.2
