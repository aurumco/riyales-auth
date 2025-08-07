-- Table for device statistics (counts only)
CREATE TABLE device_stats (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  os_name TEXT,
  os_version TEXT,
  device_type TEXT,
  device_model TEXT,
  device_brand TEXT,
  network_type TEXT,
  device_language TEXT,
  push_notification_enabled INTEGER,
  install_date TEXT, -- Date of installation (YYYY-MM-DD)
  count INTEGER DEFAULT 1,
  UNIQUE(os_name, os_version, device_type, device_model, device_brand, network_type, device_language, push_notification_enabled, install_date)
);

-- Table for event statistics (counts only)
CREATE TABLE event_stats (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  event_type TEXT,
  event_data TEXT,
  count INTEGER DEFAULT 1,
  UNIQUE(event_type, event_data)
);

-- Table for application errors (detailed logging)
CREATE TABLE app_errors (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  error_message TEXT,
  error_cause TEXT,
  error_code TEXT,
  timestamp TEXT,
  os_name TEXT,
  os_version TEXT,
  device_model TEXT,
  device_brand TEXT,
  app_version TEXT,
  stack_trace TEXT
);