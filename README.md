# Riyales Auth Service

A Cloudflare Workers-based authentication and analytics service for the Riyales application ecosystem.

## Features

- **Device Analytics**: Track device information and statistics
- **Event Tracking**: Log application events and user interactions
- **Error Reporting**: Collect and analyze application errors
- **Comprehensive Reports**: Generate detailed analytics reports
- **API Documentation**: Built-in interactive API documentation

## Local Development

### Prerequisites

- Node.js (v18 or higher)
- Wrangler CLI (`npm install -g wrangler`)
- Cloudflare account with D1 database

### Setup

1. **Install Dependencies**
   ```bash
   npm install
   ```

2. **Configure Wrangler**
   ```bash
   wrangler login
   ```

3. **Create D1 Database**
   ```bash
   wrangler d1 create riyales-db
   ```

4. **Update wrangler.jsonc**
   Add your D1 database binding to `wrangler.toml`:
   ```jsonc
    {
  	"$schema": "node_modules/wrangler/config-schema.json",
  	"name": "riyales-auth",
  	"main": "src/index.ts",
  	"compatibility_date": "2025-06-10",
  	"observability": {
  		"enabled": true
  	},
  	// D1 Database Binding
  	"d1_databases": [
  		{
  			"binding": "DB",
  			"database_name": "riyales-db",
  			"database_id": "db-id"
  		}
  	]
    }
   ```

5. **Initialize Database**
   ```bash
   wrangler d1 execute riyales-db --file=./database_schema.sql
   ```

### Running Locally

1. **Start Development Server**
   ```bash
   wrangler dev
   ```

2. **Access the Service**
   - API Documentation: http://localhost:8787/documentation
   - Analytics Dashboard: http://localhost:8787/stats
   - API Base URL: http://localhost:8787

## Deployment

1. **Deploy to Cloudflare Workers**
   ```bash
   wrangler deploy
   ```

2. **Update Production Database**
   ```bash
   wrangler d1 execute riyales-db --file=./database_schema.sql --remote
   ```

## API Endpoints

### Data Collection
- `POST /device` - Record device information
- `POST /event` - Log application events
- `POST /error` - Report application errors

### Reports
- `GET /report/os_name` - OS distribution (combined)
- `GET /report/os_version` - OS version distribution (combined)
- `GET /report/device_brand` - Device brand distribution
- `GET /report/network_type` - Network type distribution
- `GET /report/event_type` - Event type distribution
- `GET /report/error_code` - Error code distribution
- `GET /report/combined` - Comprehensive analytics
- `GET /report/devices` - Detailed device data
- `GET /report/events` - Detailed event data
- `GET /report/errors` - Detailed error data

### Documentation
- `GET /documentation` - Interactive API documentation
- `GET /stats` - Analytics dashboard

## Database Schema

The service uses three main tables:

1. **device_stats** - Stores device information with combined OS field
2. **event_stats** - Stores application events
3. **app_errors** - Stores error reports
