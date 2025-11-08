FROM frappe/bench:latest

USER root

# Install wait-for-it utility
RUN apt-get update && apt-get install -y wait-for-it && rm -rf /var/lib/apt/lists/*

USER frappe

WORKDIR /home/frappe/frappe-bench

# Copy apps.json to specify which apps to install
COPY --chown=frappe:frappe apps.json /home/frappe/frappe-bench/apps.json

# Install all apps from apps.json
RUN set -e; \
    for app in $(jq -r '.[].url' apps.json); do \
        app_name=$(basename $app .git); \
        branch=$(jq -r ".[] | select(.url==\"$app\") | .branch" apps.json); \
        echo "Installing $app_name from $app (branch: $branch)"; \
        if [ "$app_name" = "frappe" ]; then \
            continue; \
        fi; \
        bench get-app --branch $branch $app || bench get-app $app; \
    done

# Build assets
RUN bench build --apps frappe hrms crm lms drive insights gameplan helpdesk

WORKDIR /home/frappe/frappe-bench/sites

# Expose port for web server
EXPOSE 8000 9000 8080

# Default command
CMD ["bench", "start"]
