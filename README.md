# Riyales Auth Service

A Cloudflare Workers-based authentication and analytics service for the Riyales application ecosystem.

## Features

- **Device Analytics**: Track device information and statistics
- **Event Tracking**: Log application events and user interactions
- **Error Reporting**: Collect and analyze application errors
- **Comprehensive Reports**: Generate detailed analytics reports
- **API Documentation**: Built-in interactive API documentation

## Recent Updates

### Fixed Issues

1. **Password Field Display**: The API key `RYLS-0009` is now properly hidden in password fields instead of being displayed as plain text.

2. **OS Information Storage**: Operating system name and version are now stored together as a combined field (`os_combined`) instead of separate fields. This ensures that OS version information is properly associated with its corresponding OS name.

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
   wrangler d1 create riyales-auth-db
   ```

4. **Update wrangler.toml**
   Add your D1 database binding to `wrangler.toml`:
   ```toml
   [[d1_databases]]
   binding = "DB"
   database_name = "riyales-auth-db"
   database_id = "your-database-id"
   ```

5. **Initialize Database**
   ```bash
   wrangler d1 execute riyales-auth-db --file=./database_schema.sql
   ```

6. **Run Migration (if upgrading from old schema)**
   ```bash
   wrangler d1 execute riyales-auth-db --file=./migration_os_combined.sql
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

## Testing

### API Key Authentication

- **Data Collection Endpoints**: Use `RYLS-UUID` format keys
  - Example: `RYLS-123e4567-e89b-12d3-a456-426614174000`
- **Reporting Endpoints**: Use `RYLS-0009` (password field)

### Test Device Information

```bash
curl -X POST http://localhost:8787/device \
  -H "Content-Type: application/json" \
  -H "X-API-Key: RYLS-123e4567-e89b-12d3-a456-426614174000" \
  -H "User-Agent: Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X)" \
  -d '{
    "device_brand": "Apple",
    "device_model": "iPhone 14",
    "os_name": "iOS",
    "os_version": "16.0",
    "network_type": "cellular"
  }'
```

### Test Event Tracking

```bash
curl -X POST http://localhost:8787/event \
  -H "Content-Type: application/json" \
  -H "X-API-Key: RYLS-123e4567-e89b-12d3-a456-426614174000" \
  -d '{
    "event_type": "tab_visit",
    "event_data": "{\"tab\": \"settings\", \"duration\": 45}",
    "count": 3
  }'
```

### Test Error Reporting

```bash
curl -X POST http://localhost:8787/error \
  -H "Content-Type: application/json" \
  -H "X-API-Key: RYLS-123e4567-e89b-12d3-a456-426614174000" \
  -d '{
    "error_message": "Failed to load user data",
    "error_cause": "Network timeout",
    "error_code": "E1001",
    "app_version": "1.2.0"
  }'
```

### Test Reports

```bash
# Get OS distribution (now shows combined OS info)
curl "http://localhost:8787/report/os_name" \
  -H "X-API-Key: RYLS-0009"

# Get combined analytics
curl "http://localhost:8787/report/combined" \
  -H "X-API-Key: RYLS-0009"
```

## Deployment

1. **Deploy to Cloudflare Workers**
   ```bash
   wrangler deploy
   ```

2. **Update Production Database**
   ```bash
   wrangler d1 execute riyales-auth-db --file=./database_schema.sql --remote
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

## Security

- All endpoints require API key authentication
- Data collection endpoints use UUID format keys
- Reporting endpoints use a specific static key
- CORS is enabled for cross-origin requests

## License

© 2024 Aurum. All rights reserved. 