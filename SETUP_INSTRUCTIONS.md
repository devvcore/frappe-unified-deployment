# Setup Instructions

## Creating the GitHub Repository

Since the GitHub token doesn't have repository creation permissions, please follow these steps to create the repository manually:

### Option 1: Using GitHub Web Interface

1. Go to [https://github.com/new](https://github.com/new)
2. Fill in the repository details:
   - **Repository name**: `frappe-unified-deployment`
   - **Description**: `Unified Docker deployment for Frappe CRM, LMS, and HRMS - Easy single-site setup`
   - **Visibility**: Public (or Private if you prefer)
   - **DO NOT** initialize with README, .gitignore, or license (we already have these)
3. Click "Create repository"
4. Copy the repository URL (it will be something like `https://github.com/YOUR_USERNAME/frappe-unified-deployment.git`)

### Option 2: Using GitHub CLI (if you have proper permissions)

```bash
gh repo create frappe-unified-deployment --public --description="Unified Docker deployment for Frappe CRM, LMS, and HRMS - Easy single-site setup"
```

## Pushing the Code

After creating the repository on GitHub, run these commands from the repository directory:

```bash
cd /home/ubuntu/frappe-unified-deployment

# Add the remote (replace YOUR_USERNAME with your GitHub username)
git remote add origin https://github.com/YOUR_USERNAME/frappe-unified-deployment.git

# Rename branch to main (optional but recommended)
git branch -M main

# Push the code
git push -u origin main
```

## Alternative: Download as ZIP

If you prefer to work locally, you can download the repository as a ZIP file and upload it to GitHub:

```bash
cd /home/ubuntu
tar -czf frappe-unified-deployment.tar.gz frappe-unified-deployment/
```

Then download the `frappe-unified-deployment.tar.gz` file and extract it on your local machine.

## Next Steps

Once the repository is created and pushed:

1. Share the repository URL with your team or customers
2. They can clone it and follow the README.md instructions to deploy
3. Consider adding GitHub Actions for CI/CD if needed
4. Add topics/tags to make it discoverable: `frappe`, `erpnext`, `crm`, `hrms`, `lms`, `docker`

## Repository Structure

Your repository contains:

```
frappe-unified-deployment/
├── .env.example              # Environment variables template
├── .gitignore               # Git ignore rules
├── apps.json                # Frappe apps configuration
├── docker-compose.yml       # Docker Compose orchestration
├── Dockerfile               # Custom image build instructions
├── LICENSE                  # MIT License
├── README.md                # Main documentation
└── SETUP_INSTRUCTIONS.md    # This file
```

All files are ready to go - just push to GitHub and you're done!
