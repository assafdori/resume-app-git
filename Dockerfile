# lightweight Nginx image
FROM nginx:alpine

# Set the working directory
WORKDIR /usr/share/nginx/html

# Copy HTML, CSS, JavaScript, images, and PDF files to Nginx web root
COPY app/index.html .
COPY app/resume.js .
COPY app/resume.css .
COPY app/favicon.png .
COPY app/resume.pdf .

# Expose port 80 & 443 of the container
EXPOSE 80
EXPOSE 443

# Add internal health check function (external health check done via other container)
HEALTHCHECK --interval=30s --timeout=10s \
    CMD curl -f http://localhost:80/resume.pdf --output /dev/null || exit 1

# Print to log that container loaded properly & start nginx server
CMD ["sh", "-c", "echo 'Container init successfully' && nginx -g 'daemon off;'"]
