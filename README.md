# DevOps Automated Systems Toolkit

This repository contains a collection of system monitoring tools, automation scripts, and server configuration files built for the CSoT track at IIT Delhi. The toolkit focuses on general automation tasks like auditing server resources, processing network interaction logs, backup handling, and bulk account provisioning.

## 📂 Project Structure
```text
devops-toolkit-week01/
├── .env.example
├── .gitignore
├── LICENSE
├── README.md
├── DEMO.md
├── myapp/
│   └── app.py
├── nginx/
│   └── myapp.conf
├── samples/
│   ├── sample_access.log
│   └── users.csv
├── scripts/
│   ├── backup.sh
│   ├── deploy.sh
│   ├── log_parser.sh
│   ├── sysreport.sh
│   └── user_manager.sh
└── systemd/
    ├── myapp.service
    ├── sysreport.service
    └── sysreport.timer


## ⚙️ How to Run the Scripts
Before running, ensure all execution permissions are set:
chmod +x scripts/*.sh

1. Master Deployment Engine
Sets up systemd background configurations, installs the scheduling timer, and configures secure Nginx routing records. (Requires root privileges):
sudo ./scripts/deploy.sh

2. System Health Report Engine
Generates an on-demand report detailing uptime, disk health limits, network interfaces, and processing consumers:
./scripts/sysreport.sh

3. Log Analytics Interpreter
Parses a target server access log to count total visits, summarize failures, and trace top sources:
./scripts/log_parser.sh samples/sample_access.log

4. Account Lifecycle Manager
Creates or deletes multiple local system identities securely using a standard comma-separated text file:
./scripts/user_manager.sh create samples/users.csv

5. Compression Backup Utility
Compresses a source directory into an organized date-stamped archive and writes localized tracing data:
./scripts/backup.sh ~/devops-toolkit-week01/myapp /tmp/backups
