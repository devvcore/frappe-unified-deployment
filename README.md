# Frappe Unified Deployment

A unified Docker-based deployment solution that combines **Frappe CRM**, **Frappe LMS (Learning Management System)**, **Frappe HRMS**, **Frappe Drive**, and **Frappe Insights** into a single site for easy deployment and management.

## 📋 What's Included

This repository provides a production-ready Docker Compose setup that includes:

- **Frappe Framework** (v15) - The core framework
- **Frappe HRMS** - Complete HR and Payroll solution with 13+ modules
- **Frappe CRM** - Modern, open-source CRM for sales teams
- **Frappe LMS** - Learning Management System for courses and training
- **Frappe Drive** - Open-source file storage, sharing, and collaboration platform
- **Frappe Insights** - Open-source Business Intelligence and data analytics tool

All apps are installed on a single Frappe site, sharing the same database and user authentication system.

## 🏗️ Architecture

The deployment consists of the following services:

- **MariaDB** - Database server
- **Redis Cache** - Caching layer
- **Redis Queue** - Background job queue
- **Backend** - Frappe application server
- **Frontend** - Nginx web server
- **WebSocket** - Real-time communication server
- **Queue Workers** - Background job processors (short and long queues)
- **Scheduler** - Cron job scheduler

## 🚀 Quick Start

### Prerequisites

- Docker Engine 20.10+
- Docker Compose v2.0+
- At least 4GB RAM available
- 10GB free disk space

### Installation Steps

1. **Clone this repository**

```bash
git clone <your-repo-url>
cd frappe-unified-deployment
```

2. **Configure environment variables**

```bash
cp .env.example .env
```

Edit `.env` and set your passwords:

```env
DB_ROOT_PASSWORD=your_secure_db_password_here
ADMIN_PASSWORD=your_secure_admin_password_here
SITE_NAME=site1.localhost
```

3. **Build and start the services**

```bash
docker compose build
docker compose up -d
```

4. **Wait for site creation**

The `create-site` service will automatically:
- Create a new Frappe site
- Install HRMS, CRM, and LMS apps
- Configure the site

Monitor the progress:

```bash
docker compose logs -f create-site
```

Wait until you see "Site setup complete!" message (this may take 5-10 minutes).

5. **Access your site**

Open your browser and navigate to:

```
http://localhost:8080
```

**Default credentials:**
- Username: `Administrator`
- Password: (the value you set in `ADMIN_PASSWORD`)

## 📱 Accessing Different Apps

After logging in, you can access different apps from the Frappe Desk:

- **HRMS**: Click on "HR" or "HRMS" module
- **CRM**: Click on "CRM" module
- **LMS**: Click on "Learning" or "LMS" module
- **Drive**: Click on "Drive" module for file storage and collaboration
- **Insights**: Click on "Insights" module for business intelligence and analytics

All apps are integrated and share the same user database and permissions system.

## 🔧 Configuration

### Custom Domain

To use a custom domain instead of `localhost`:

1. Update `SITE_NAME` in `.env`:
   ```env
   SITE_NAME=mycompany.com
   ```

2. Add the domain to your `/etc/hosts` file (for local testing):
   ```
   127.0.0.1 mycompany.com
   ```

3. For production, point your domain's DNS A record to your server's IP address.

### Port Configuration

By default, the application is accessible on port `8080`. To change this, edit `docker-compose.yml`:

```yaml
frontend:
  ports:
    - "80:8080"  # Change 80 to your desired port
```

## 🛠️ Management Commands

### View logs

```bash
# All services
docker compose logs -f

# Specific service
docker compose logs -f backend
```

### Restart services

```bash
docker compose restart
```

### Stop services

```bash
docker compose down
```

### Stop and remove all data

```bash
docker compose down -v
```

### Access Bench CLI

```bash
docker compose exec backend bash
# Now you're inside the container
bench --site site1.localhost console
```

### Update apps

```bash
docker compose exec backend bash
bench update --pull
bench --site site1.localhost migrate
bench build
```

### Backup site

```bash
docker compose exec backend bash
bench --site site1.localhost backup
```

Backups are stored in `/home/frappe/frappe-bench/sites/site1.localhost/private/backups/`

## 📊 System Requirements

### Minimum Requirements
- 2 CPU cores
- 4GB RAM
- 10GB storage

### Recommended for Production
- 4+ CPU cores
- 8GB+ RAM
- 50GB+ SSD storage

## 🔒 Security Considerations

For production deployments:

1. **Use strong passwords** - Change default passwords in `.env`
2. **Enable HTTPS** - Use a reverse proxy like Traefik or Nginx with SSL certificates
3. **Firewall rules** - Only expose necessary ports (80, 443)
4. **Regular updates** - Keep apps and Docker images updated
5. **Backup strategy** - Implement automated backups
6. **Environment variables** - Never commit `.env` file to version control

## 🐛 Troubleshooting

### Site creation fails

Check the logs:
```bash
docker compose logs create-site
```

Common issues:
- Database connection timeout: Increase wait time in `create-site` service
- Out of memory: Increase Docker memory limit

### Cannot access the site

1. Check if all services are running:
   ```bash
   docker compose ps
   ```

2. Verify the site was created:
   ```bash
   docker compose exec backend bench --site site1.localhost list-apps
   ```

3. Check frontend logs:
   ```bash
   docker compose logs frontend
   ```

### Apps not showing up

1. Verify apps are installed:
   ```bash
   docker compose exec backend bench --site site1.localhost list-apps
   ```

2. Clear cache:
   ```bash
   docker compose exec backend bench --site site1.localhost clear-cache
   ```

3. Rebuild assets:
   ```bash
   docker compose exec backend bench build
   ```

## 📚 Additional Resources

- [Frappe Framework Documentation](https://frappeframework.com/docs)
- [Frappe HRMS Documentation](https://frappehr.com/docs)
- [Frappe CRM Documentation](https://docs.frappe.io/crm)
- [Frappe LMS Documentation](https://docs.frappe.io/lms)
- [Frappe Drive Documentation](https://docs.frappe.io/drive)
- [Frappe Insights Documentation](https://docs.frappe.io/insights)
- [Frappe Docker Repository](https://github.com/frappe/frappe_docker)

## 🤝 Contributing

Contributions are welcome! Please feel free to submit issues or pull requests.

## 📄 License

This deployment configuration is provided as-is. The individual Frappe apps have their own licenses:

- Frappe Framework: MIT License
- Frappe HRMS: GNU General Public License v3.0
- Frappe CRM: GNU Affero General Public License v3.0
- Frappe LMS: GNU Affero General Public License v3.0
- Frappe Drive: GNU Affero General Public License v3.0
- Frappe Insights: GNU Affero General Public License v3.0

## 🆘 Support

For issues specific to this deployment setup, please open an issue in this repository.

For app-specific issues:
- Frappe Framework: [frappe/frappe](https://github.com/frappe/frappe/issues)
- HRMS: [frappe/hrms](https://github.com/frappe/hrms/issues)
- CRM: [frappe/crm](https://github.com/frappe/crm/issues)
- LMS: [frappe/lms](https://github.com/frappe/lms/issues)
- Drive: [frappe/drive](https://github.com/frappe/drive/issues)
- Insights: [frappe/insights](https://github.com/frappe/insights/issues)

---

**Built with ❤️ using Frappe Framework**
