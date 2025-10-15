# Netarch Setup Records

This folder contains logs, notes, terminal outputs, and configuration steps developed during hands-on labs aligned with the **CCNA: Introduction to Networks** curriculum. Topics include virtualization, operating system administration, network simulation, and automation.

> **Note:** Logs and documentation are written in **Spanish**, as they were produced as part of coursework in a Spanish-speaking academic environment.

---

## Base platform: Infrastructure for virtualization and networking

This work simulated a real-world IT infrastructure using virtualization to install, configure, and manage multiple operating systems in a controlled academic setting.

### Virtual Machine Deployment and OS Installation

Using **VMware Workstation Pro**, students deployed and configured:

- **Slackware Linux**
- **Solaris**
- **Windows Server 2025 (CLI and GUI)**
- **Android-x86**

Key configuration tasks included:

- Assigning **DHCP and static IP addresses** in bridge mode
- Creating **users and groups** for role-based administration
- Verifying **network connectivity** (ping, traceroute, DNS tests)
- Exploring **file systems, logs, and permissions**
- Documenting **VM-specific configuration files** (VMX, VMDK, NVRAM)
- Producing a **video presentation** explaining **hypervisors, containers, and cloud computing**

### System Administration and Networking Practices

The work combined system setup and basic network administration across Unix/Linux and Windows environments. Activities included:

- **Slackware & Solaris** → manual installation, network setup, user/group creation, syslog configuration.
- **Windows Server** → domain services, account management, permissions, and event logging.
- **Android-x86** → installation and network testing in a non-mobile context.
- **Command-line practice** → essential shell and PowerShell utilities for file management, logs, and process handling.
- **Networking concepts** → comparison of NAT vs Bridge Mode, DNS resolution, and IP addressing strategies.

### Results and Learning Outcomes

The lab achieved a functional multi-OS virtualized environment, with the following outcomes:

- **Correct deployment** of four different operating systems on VMware.
- **Hands-on practice** with system installation, networking, user/group management, and permissions.
- **File system exploration** across Slackware, Solaris, and Windows for comparative analysis.
- **Syslog and logging** tested on Unix/Linux systems, with Windows logs explored through Event Viewer.
- **Bridge-mode networking** successfully demonstrated inter-VM connectivity and DNS testing.

---

## Operating System Configuration, Shell, and Network Support Software

This work focused on system administration, scripting, and network simulation across **Unix/Linux** and **Windows** platforms.

### Packet Tracer and Network Simulation

The work introduced **Cisco Packet Tracer** as a tool for network design, message tracing, and protocol analysis.

Activities included:

- Completing the **Getting Started with Cisco Packet Tracer** course.
- Designing and simulating network topologies with **OSPF routing**.
- Testing connectivity between devices (DHCP, RADIUS, servers, and switches).
- Using **Simulation Mode** to trace ICMP packets step by step through the **OSI layers**, analyzing encapsulation and de-encapsulation.
- Deliverables included `.pkt` and `.pkz` project files documenting the implementations.

### Real Network Analysis with Wireshark

Students captured and analyzed real traffic with **Wireshark**, focusing on:

- HTTP request/response flows and TCP handshakes.
- Protocol encapsulation at each OSI layer.
- Use of **filters** for isolating specific packets and protocols.
- Network interface comparison: physical NICs (Intel/Realtek) vs. virtual NICs (Slackware, Solaris).
- Analysis of performance parameters: MAC addresses, IPv4/IPv6, link speeds, and duplex modes.

Video tutorials were also created to demonstrate **Wireshark usage, interface navigation, and HTTP traffic analysis.**

### System Administration and Shell Scripting

To complement network simulations, multiple Unix shell scripts were developed and tested in **Slackware and Solaris**:

- `system-log-viewer.sh` → filtering and monitoring of system logs.
- `file-inspector.sh` → file search and word counting.
- `directory-inspector.sh` → recursive search across directories and files.
- `create-group.sh` → group creation with system checks.
- `create-user.sh` → automated user creation with home directories and permissions.

Additionally, the **VI editor** was used for advanced file editing, practicing commands for search/replace, deletion, undo, copy, uppercase conversion, and navigation.

### Virtualization, File Sharing, and Cloud Computing

The work extended to **virtualization and cross-platform services**:

- **VM deployments** → Windows Server, Solaris, and Slackware VMs configured with static IPs and validated connectivity through `ping` tests.
- **SMB/SAMBA file sharing** → setup on Solaris and accessed from Windows and Slackware.
- **Cloud experiments** → deployment of Amazon EC2 instances using **AWS Academy**, including configuration of Amazon Linux, connection through SSH, and exploration of Slackware installation in cloud environments.

Scripts were also uploaded to **EC2 instances** via `scp`, executed remotely, and validated in real cloud-based scenarios.

### Results and Learning Outcomes

The work provided hands-on experience in:

- Designing and simulating **scalable network topologies** in Packet Tracer.
- Analyzing **real-world network traffic** using Wireshark and NIC comparison.
- Automating **system administration tasks** with shell scripts.
- Practicing **file sharing and interoperability** across heterogeneous systems.
- Exploring **cloud computing fundamentals** with AWS EC2.

---

## DNS Services Configuration and Task Automation Through Scripting in Virtualized Environments

This work focused on deploying **DNS services and automating administrative tasks** in virtualized environments.

### DNS Services Deployment in Virtualized Environments

Configured **BIND DNS servers** on Solaris, Slackware, and Windows Server:

- **A** (IPv4 Address)
- **AAAA** (IPv6 Address)
- **NS** (Name Server)
- **MX** (Mail Exchange)
- **CNAME** (Canonical Name)

Configuration tasks included editing `named.conf`, creating forward zone files, defining SOA (Start of Authority) records, and validating resolution using **dig**, **nslookup**, and resolver configurations. Local and external domain resolution was verified, ensuring redundancy through synchronized secondary servers.

### Task Automation with Shell and PowerShell

To complement DNS configuration, multiple **administrative scripts** were developed for Unix/Linux and Windows environments:

- `schedule-task-script.sh` → Automates creation and validation of scheduled tasks using `cron`.
- `process-manager.sh` → Provides an interactive menu for listing, searching, killing, and restarting processes.
- `files-script.sh` → Recursively scans the filesystem to list the smallest files under a size threshold.

Each script was tested in **Solaris** and **Slackware**, ensuring parameter validation, error handling, and portability across shells (`bash` and `ksh`).

### Results and Learning Outcomes

The lab successfully integrated **DNS services** and **scripting automation**:

- DNS was configured and validated across Solaris, Slackware, and Windows Server, with custom domains and record management.
- Shell and PowerShell scripts automated system tasks, demonstrating portability and robust error handling.
- Tools such as **nslookup** and **dig** were used to diagnose and verify DNS functionality.

---

## Application Layer Protocols and Physical Layer Standards in Network Infrastructures

This section documents the integration of **application-layer protocols** and **physical-layer standards** in academic and simulated environments, combining **logical network design** with **hands-on physical implementation.**

It expands on DNS and service configuration through **Packet Tracer**, **Wireshark**, and **real cabling practices**, providing a comprehensive view from simulation to real-world infrastructure.

### Application Layer Protocols

Using **Cisco Packet Tracer**, multiple services were configured and analyzed:

- **DNS, HTTP, FTP, and Email** services across different domains (`sistemas.com`, `civil.com`, `electrica.com`), ensuring name resolution, web hosting, file transfer, and inter-domain email communication.
- Validation through **PDU simulation** to observe encapsulation and OSI-layer behavior.
- Service testing using **PING**, **HTTP browsing**, and **FTP/TELNET sessions**, highlighting communication at layers 4–7.

Each service was verified with both **domain names** and **IP-based requests**, demonstrating proper DNS integration and HTTP response headers (e.g., `200 OK`, `Content-Type`, `Host`, etc.).

FTP operations included **file upload/download**, using user authentication and permission management.

### Network Traffic Analysis with Wireshark

Wireshark was employed to capture **real network traffic**, including HTTP, DHCP, and Telnet sessions:

- Detailed inspection of **TCP handshakes** and **HTTP request/response** exchanges.
- Observation of **DHCP Discover–Offer–Request–ACK** sequences.
- Manual **HTTP requests via Telnet**, highlighting differences between raw text-based requests and browser-managed transactions.
- Visualization of HTTP 200 responses and content-type differentiation (`text/html`, `application/pdf`, `image/png`).

These captures illustrated how **application-layer data** is transported and visualized differently depending on the client (e.g., raw Telnet vs. browser).

### DNS Record Analysis and Real-World Domain Inspection

Using **CentralOps.net**, DNS and WHOIS data were analyzed for several domains:

- **escuelaing.edu.co** → internal DNS infrastructure and LACNIC-assigned IP ranges.
- **jbb.gov.co** → hybrid configuration using GoDaddy and Microsoft Azure DNS.
- **google.com** → multi-redundant, globally distributed infrastructure managed by Google LLC.
- **lufthansa.com** → DNSSEC-enabled corporate domain hosted on Microsoft Azure.

Each analysis detailed domain creation dates, TTLs, registrars, IP ranges, and ownership information, strengthening understanding of **global DNS hierarchy and security practices.**

### NTP Synchronization and Physical Layer Standards

The lab concluded with **Network Time Protocol (NTP)** configuration on Solaris and Slackware systems, enabling clock synchronization across multi-platform environments.
In the **physical layer**, students practiced structured cabling with **UTP Cat5e/6, RJ-45 connectors**, and **patch panel termination**, following **T568A/T568B wiring standards.**

Hands-on crimping, continuity testing, and inspection of campus structured cabling systems complemented the logical network simulations, bridging conceptual and physical aspects of networking.

### Results and Learning Outcomes

This lab reinforced both **logical network design** and **physical infrastructure deployment** skills:

- Complete implementation of **application-layer protocols** in simulated networks.
- Real-world validation of **HTTP, DNS, FTP, DHCP, and NTP** traffic.
- Integration of **DNS resolution, email, and web services** under unified domain management.
- Practical exposure to **structured cabling standards** and **physical connectivity verification.**
- Cross-analysis between **simulation (Packet Tracer)** and **real-world network traces (Wireshark).**
