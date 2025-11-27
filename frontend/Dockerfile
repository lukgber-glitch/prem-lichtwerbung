FROM node:20-alpine

WORKDIR /app

# Copy package files (Railway build context is project root, not frontend/)
COPY frontend/package*.json ./

# Install dependencies
RUN npm install

# Copy application files (Railway build context is project root, not frontend/)
COPY frontend/ .

# Expose port
EXPOSE 3000

# Start development server
CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0"]
