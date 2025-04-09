# Synthèse du matériel

## Fichier de suivi des machines


![Suivi machines](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/SCREENS-PAR-SPRINT/SCREENS_SPRINT2/Suivimachines.png)

| ID Machine (Proxmox) | Nom Matériel (Proxmox) | Nom Matériel | Types d'objet Proxmox (VM/CT) | OS | Fonction principal | N° carte réseau | Adresse IP/CIDR | Info HDD | Info RAM | Info CPU
|:-:|:-:|:-:|:-:|:-|:-|:-|:-|:-|:-|:-|
| 1140 (GUI) | G1-WinServer2022-GUI | SRV-WIN-DC-01 | VM |Windows Server 2022 GUI|AD-DS/DNS/DHCP|VMBR525|172.18.1.100/24| 2 Disques de 32Go|4Go|2 coeurs
| 1141 (CLI) | G1-WinServer2022-Core | SRV-WIN-DC-02 | VM |Windows Server 2022 core |AD-DS/DNS/DHCP (R) |VMBR525|172.18.1.101/24| 1 Disque de 32Go|2Go |1 coeur
| 1142 (GUI) | G1-Win10-Pro-01 | LAP-PAR-DELL-20 | VM |Windows 10 Pro | Machine cliente | VMBR500G1|192.168.1.X/24 (DHCP)| 1 Disque de 50Go|2Go |2 coeurs
| 1143 (CLI) | G1-Deb12-CLI-GLPI | SRV-LIN-GLPI-01 | VM | Serveur Debian 12 | GLPI/SSH | VMBR525|172.18.1.105/24| 1 Disque de 32Go|2Go |1 coeur
| 1144 (GUI) | G1-WinServer2022-ADM-GUI | SRV-WIN-ADM-01 | VM | Windows Server 2022 GUI | Serveur d'administration | VMBR525 | 172.18.1.110/24| 1 Disque de 32Go|4Go |2 coeurs
| 1145 (GUI) | G1-Win10-Pro-02 | LAP-PAR-DELL-21 | VM | Windows 10 Pro | Machine cliente | VMBR500G1|192.168.1.X/24 (DHCP)| 1 Disque de 50Go|2Go |2 coeurs 
| 1146 (CLI) | G1-Deb12-MAIL-CLI | SRV-LIN-MAIL-01 | VM | Serveur Debian 12 |Serveur Mail Iredmail | VMBR500G1|172.18.1.115/24| 1 Disque de 50Go|4Go |2 coeurs 
| 1147 (GUI) | G1-CLONEDC01 | Clone 1142 |  |
| 1148 (CLI) | G1-pfsense-CLI | pfSense | FireWall |  |
| 1149 (CLI) | G1-RouteurVYos | Routeur Vyos | Routeur | Terminé |
| 1150 (GUI) | G1-Win10Pro-03 | LAP-PAR-DELL-22 | PC Client Windows |
| 1151 (GUI) | G1-Winserver2022-FLSRV-GUI | SRV-WIN-FLS-01 | Serveur Windows FileSystem |Terminé|Non fait
| 1152 (CLI) | G1-Deb12-CLI-Backup | Debian | Serveur Windows FileSystem Backup | Pas de doc
| 1153 (CLI) | G1-Deb12-CLI-Zabbix-GrayLog | Debian | Serveur Debian Zabbix/Graylog |
| 1154 (CLI) | G1-Deb12-CLI-WebBackEnd | Debian | Serveur Debian Web BackEnd | Pas de doc
| 1155 (CLI) | G1-Deb12-CLI-Passbolt | SRV-LIN-PASS-01 | Serveur Debian PassBolt | 
| 1156 (GUI) | G1-WinServer2022-GUI-WSUS | SRV-WIN-FLS-01 | Serveur Windows WSUS |
| 1157 (CLI) | G1-Deb12-CLI-Freepbx | Debian | Serveur Debian Freepbx | Terminé| Non fait
| 1158 (CLI) | G1-Deb12-CLI-Guacamole | Debian | Serveur Debian Bastion |
| 1160 (GUI) | G1-KaliLinux | Debian |  Pas de doc | Non fait
