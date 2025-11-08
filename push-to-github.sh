#!/bin/bash

# Quick script to push this repository to GitHub
# Run this after creating the repository on GitHub

echo "================================================"
echo "Frappe Unified Deployment - GitHub Push Script"
echo "================================================"
echo ""
echo "Before running this script, please:"
echo "1. Go to https://github.com/new"
echo "2. Create a new repository named: frappe-unified-deployment"
echo "3. Do NOT initialize with README, .gitignore, or license"
echo ""
read -p "Have you created the repository? (y/n) " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo "Please create the repository first, then run this script again."
    exit 1
fi

echo ""
echo "Setting up remote and pushing..."
echo ""

# Check if remote already exists
if git remote | grep -q "origin"; then
    echo "Remote 'origin' already exists. Removing it..."
    git remote remove origin
fi

# Add the remote (update with your username if needed)
GITHUB_USERNAME="mylesndavid"
git remote add origin "https://github.com/${GITHUB_USERNAME}/frappe-unified-deployment.git"

# Rename branch to main
git branch -M main

# Push to GitHub
git push -u origin main

echo ""
echo "================================================"
echo "✅ Successfully pushed to GitHub!"
echo "================================================"
echo ""
echo "Your repository is now available at:"
echo "https://github.com/${GITHUB_USERNAME}/frappe-unified-deployment"
echo ""
echo "Next steps:"
echo "1. Visit your repository on GitHub"
echo "2. Add topics: frappe, erpnext, crm, hrms, lms, docker"
echo "3. Share with your team and customers"
echo ""
