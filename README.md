# CCNA Network Architecture

[![standard-readme compliant](https://img.shields.io/badge/readme%20style-standard-brightgreen.svg?style=flat-square)](https://github.com/RichardLitt/standard-readme)

Configuration logs, shell scripts, terminal outputs, and study notes developed for the **Network Architecture and Services (AYSR)** course at **Escuela Colombiana de Ingeniería**.

Based on the **CCNA: Introduction to Networks** curriculum, the repository covers routing, switching, addressing, system administration, automation, and basic network design.

---

## Table of Contents

- [Background](#background)
- [Install](#install)
- [Usage](#usage)
- [Repository Structure](#repository-structure)
- [Maintainers](#maintainers)
- [License](#license)

---

## Background

This repository documents both theoretical and practical work in **networking and system administration**, combining:

- **Virtualization and OS deployment** (Slackware, Solaris, Windows Server, Android-x86).
- **Cisco Packet Tracer topologies** with OSPF, VLANs, and WAN simulation.
- **Shell scripting for Unix/Linux**: log viewing, file inspection, process management, user/group automation.
- **DNS services** configuration on Solaris, Slackware, and Windows.
- **Network analysis with Wireshark** (HTTP flows, TCP handshakes, encapsulation).
- **Cloud computing** experiments with AWS EC2.

The goal is to integrate **network design, system administration, and automation** in a lab setting that simulates real-world IT environments.

---

## Install

No installation is required to explore this repository.  
To run the scripts, you need:

- **Bash** (Unix/Linux compatible)
- A **Unix-like environment** (Slackware, Solaris, Linux, BSD, or macOS)
- Optional: **VMware Workstation Pro** or **Cisco Packet Tracer** for lab replication

Example setup on Linux:

```sh
# Clone the repository
git clone https://github.com/LePeanutButter/ccna-network-architecture.git
cd ccna-network-architecture

# Run a sample script
bash shell-scripts/system-log-viewer.sh
```

---

## Usage

This repository can be used as:

1. **Reference material** for CCNA labs and study notes.
2. **Executable scripts** to automate administration tasks in Unix/Linux environments.
3. **Network simulation files** (`.pkt` and `.pkz`) to replicate OSPF-based topologies in Cisco Packet Tracer.
4. **Lab documentation** (in Spanish) for reproducing virtualization, DNS, and cloud-based experiments.

---

## Repository Structure

- `netarch-setup-records/`

  Logs, notes, and lab records (VM deployment, networking, Wireshark analysis, DNS, AWS cloud setup).

- `shell-scripts/`

  Bash scripts for system administration and task automation. Portable across Slackware, Solaris, Linux, BSD, and macOS.

- `pt-topologies/`
  Cisco Packet Tracer projects implementing OSPF, VLANs, and WAN links. Includes Santiago’s and Natalia’s implementations.

---

## Maintainers

- [@LePeanutButter](https://github.com/LePeanutButter) - Santiago Botero Garcia

---

## License

[MIT](./LICENSE) © 2025 Santiago Botero

---

## Contributors

- [@Lanapequin](https://github.com/Lanapequin) - Laura Natalia Perilla Quintero
- [@LePeanutButter](https://github.com/LePeanutButter) - Santiago Botero Garcia
