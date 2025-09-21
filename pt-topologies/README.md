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

### Conclusion

This project demonstrates the practical application of OSPF in a simulated network environment. By following the provided files, users can replicate the setup and observe the effects of OSPF on network performance, routing efficiency, and scalability.
