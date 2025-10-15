# Cisco Packet Tracer Network Topologies

Packet Tracer files organized by network design scenarios and protocol implementations. Each simulation highlights key aspects of network architecture, from IP planning to inter-VLAN routing and WAN emulation.

---

## Operating System Configuration, Shell, and Network Support Software

This section contains the practical implementation of an OSPF (Open Shortest Path First) network simulation, created using Cisco Packet Tracer. The goal of this project was to apply theoretical knowledge and create a functional and scalable network design based on a reference topology. Below are the details of the implementation and the associated files.

### Overview

The original network topology, shown in Figure 6, was used as a reference for the OSPF implementation. It defines the placement of routers, switches, servers, and end devices, as well as the segmentation of VLANs and the assignment of IP addresses. OSPF was configured to ensure the network's functionality, scalability, and efficiency.

The project includes two main configurations that can be reviewed and replicated:

1. **Santiago's Implementation**  
   Filename: `ospf-santiago-implementation.pkz`  
   This file contains the complete configuration of the network designed and implemented by Santiago. It includes IP address assignments, VLAN databases, and serial link settings for WAN simulation.

2. **Natalia's Implementation**  
   Filename: `ospf-natalia-implementation.pkt`  
   This file contains the network configuration designed by Natalia. Like Santiago's configuration, it includes all the necessary settings for VLANs, IP addresses, and the configuration of serial links for the WAN network simulation.

### File Descriptions

- **`ospf-santiago-implementation.pkz`**  
  This file represents the network configuration created by Santiago. It includes the setup of routers, switches, end devices, and the OSPF routing protocol. The network design is based on the original reference topology, with various VLANs and subnets configured for optimal performance.

- **`ospf-natalia-implementation.pkt`**  
  This file contains Natalia's OSPF configuration. Similar to Santiago's file, it includes the setup of all network devices and the application of OSPF for dynamic routing. This configuration is also based on the same reference topology and implements similar network segmentation and WAN settings.

### Network Design

#### OSPF Overview

OSPF (Open Shortest Path First) is a dynamic routing protocol that helps routers exchange information about network topology and compute the most efficient route to each destination. In this implementation, OSPF ensures:

- **Fast convergence**: Quickly adapts to network changes.
- **Load balancing**: Distributes traffic across multiple paths to prevent congestion.
- **Scalability**: Easily accommodates additional routers and subnets.

#### VLANs and Subnets

The network is divided into multiple VLANs to segment traffic and improve security and performance. Each VLAN corresponds to a specific subnet, and OSPF is used to dynamically route traffic between these VLANs.

#### Serial Link Configuration

For the WAN simulation, serial links were configured between the routers. These links are essential for simulating communication between remote sites and are part of the OSPF configuration.

## Application Layer Protocols and Physical Layer Standards in Network Infrastructures

This section documents the **Packet Tracer simulations** developed for the _Application Layer Protocols and Physical Layer Standards in Network Infrastructures_ lab.
The goal was to integrate and analyze **application-layer protocols (DNS, HTTP, FTP, Email, NTP)** within a multi-domain network topology, and to link these logical configurations with physical-layer standards such as **UTP cabling, RJ-45 connectors**, and **patch panel wiring.**

### Overview

Two independent implementations were developed, both representing complete multi-domain academic networks for the “Facultad de Sistemas, Civil y Eléctrica” (Systems, Civil, and Electrical programs):

1. **Santiago’s Implementation**
   Filename: `campus-network-santiago-implementation.pkt`  
   A full deployment of a multi-domain network with configured DNS, HTTP, FTP, and Email services.
   The simulation includes dynamic testing through PDU inspection and protocol encapsulation tracking, ensuring correct operation across all OSI layers.

2. **Natalia’s Implementation**
   Filename: `campus-network-natalia-implementation.pkt`  
   A complementary implementation focusing on DNS resolution, HTTP and FTP service configuration, and email communication within and between domains.
   Includes visual verification using Simulation Mode, ICMP ping testing, and service validation via built-in browser and email client tools.

### Network Design Summary

Both network designs share a similar logical structure and domain hierarchy:

- **Domains configured:** `sistemas.com`, `civil.com`, `electrica.com`
- **Services included:**
  - **DNS** — Forward resolution for A, CNAME, and MX records.
  - **HTTP** — Custom HTML pages hosted in each department’s web server.
  - **Email (SMTP/POP3)** — Domain-specific accounts for intra- and inter-domain communication.
  - **FTP** — File transfer service with read/write permissions and user authentication.
  - **NTP** — Time synchronization simulated across Solaris and Slackware clients.
- **Connectivity testing:** Conducted via `ping`, `telnet`, and simulated PDU analysis to visualize the encapsulation sequence through all seven OSI layers.

### Physical Layer Integration

Each logical design also includes references to physical connectivity and structured cabling:

- **Straight-through and cross-over cables** (T568A/T568B) for LAN and inter-switch connections.
- **Patch panel mapping and verification** for switch interlinks.
- **Cabling simulation** using Copper Straight-Through and Copper Cross-Over in Packet Tracer.

This ensures a cohesive understanding of how physical standards interact with application-level configurations in real-world infrastructures.

### Results and Learning Outcomes

- Successful integration of **multi-service, multi-domain environments** within Packet Tracer.
- Demonstrated understanding of **application protocols (HTTP, DNS, FTP, Email, NTP)** and their interactions.
- Clear linkage between **logical network design** and **physical layer implementation.**
- Hands-on validation of **protocol encapsulation, service resolution, and inter-domain communication.**
- Reinforcement of **structured cabling knowledge** aligned with TIA/EIA standards.
