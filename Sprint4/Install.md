<div align="center"><H1> Install -  Sprint 4 </H1></div>

## 1) SECURITE - Gestion d'un firewall pfSense

![pfsense](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/Sprint4/images/logo_pfsense.png)

### A) Installation et paramètres réseaux

  1. Installation

     Tout d'abord, il faut télécharger l'ISO sur le site de netgate.com
     Ensuite, televerser l'image sur l'infra PROXMOX
     Lancer l'installation
     Seul le l'adresse IP de la machine, le login et le mot de passe sont important à bien configurer pendant l'installation, afin d'avoir accès à l'interface web de pfsense depuis un client (Windows ou Linux) sur le réseau. Par la suite, tout peut être modifié dans l'interface.

     Une fois l'installation terminée, il faut se connecter depuis un client avec l'adresse https://172.18.255.254

    
![pfsense](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/Sprint4/images/login_pfsense.png)
    

    
  3. Configuration réseaux  

L'utilisation des adresses suivantes sont imposées :

![pfsense](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/Sprint4/images/adresses_IP.png)


Configuration de la partie LAN

![pfsense](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/Sprint4/images/interface_lan1.png)

![pfsense](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/Sprint4/images/interface_lan2.png)


Configuration de la partie WAN

![pfsense](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/Sprint4/images/interface_wan1.png)

![pfsense](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/Sprint4/images/interface_wan2.png)


Configuration de la partie DMZ

![pfsense](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/Sprint4/images/interface_dmz1.png)





une fois les réglages en place, il est possible d'avoir ces informations dans un Widget qui se nomme "Interfaces" sur la page d'accueil 

![pfsense](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/Sprint4/images/widget_IP.png)


### B) Réglage de la partie NAT

Laissons pfsense gérer automatiquement le NAT

![pfsense](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/Sprint4/images/NAT.png)


### C) Mise en place des passerelles et des routes 

![pfsense](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/Sprint4/images/routing_static.png)

![pfsense](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/Sprint4/images/routing_gateways.png)





### D) Mise en place de règles de pare-feu WAN, LAN, DMZ

Dans l'optique d'utiliser la stratégie "Deny All", il faut désactiver les régles par défaut (dans l'image ci-dessous, les 2 règles du bas en "Default Allow LAN to any rule")
La première règle ne peux pas être modifier ou désactiver afin de toujours garder l'accès à l'interface Web de pfsense


![pfsense](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/Sprint4/images/default_rules1.png)
![pfsense](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/Sprint4/images/default_rules2.png)




### E) Utiliser les principes de gestion des règles suivantes

#### a) Deny all ou Allow all

#### b) Least privilege

#### c) Order of rules

## 2) SECURITE - Gestion de la télémétrie sur les clients Windows 10/11

**Utilisation de GPO (Utilisateur/Ordinateur)**

Mise en place de la tache AT via la GPO Task Scheduler 

![Télémétrie](https://i.imgur.com/TQZqTwi.png)

Entrer le nom de votre task 

![Télémétrie](https://i.imgur.com/xJCUtVG.png)

Programmation de la Tache AT

![Télémétrie](https://i.imgur.com/NzSjsDo.png)

Cliquer sur New 

![Télémétrie](https://i.imgur.com/97XX8lo.png)

Mettre powershell dans la partie programme

Rentrer la commande dans la partie :

-NoProfile -NoLogo -NonInteractive -ExecutionPolicy Bypass -File \\path\to\script.ps1

![](https://i.imgur.com/n2hVxn3.png)

## 3) RESEAU - Amélioration de l'infrastructure Proxmox avec des routeurs

# Installation d'un routeur vyos, router 2 vlan, mettre le service relais DHCP et diffuser le WAN via un pfsense.

## Prérecquis

- 2 Machines sur un réseau différent. 1 serveur AD-DS/DHCP avec IP statique en 172.18.1.100 et 1 client en IP automatique (DHCP)
- 1 Machine pfsense avec 2 interfaces sur le LAN du serveur et sur un WAN
- 1 Machine routeur vyos avec 2 interfaces sur les 2 LANs

<HR>

## Installation du routeur

Une fois la machine lancer, sélectionnez l'option ```Console KVM```

Le login par défaut du routeur vyos est ```vyos``` pour le login et le MDP.

```install image``` pour installer l'imagine disque du routeur. Le clavier est en QWERTY par défaut.

Le routeur possède 2 CLI différents. Il est une distribution Debian et donne donc accès à la plupart des commandes de base de Debian.
  
Il possède sa propre CLI en tapant ```configure```.
  
```sudo loadkeys fr```pour passer temporairement en AZERTY jusqu'au prochain redémarrage de la machine.
  
  <HR>
  
  Regardons les interfaces avec ```show interface```
  
  ![](https://i.imgur.com/ZtmK5Es.png)
    
  Ici, ```eth0``` sera le LAN serveur sur le réseau 172.18.0.0/16 et ```eth1``` sera le LAN client en 192.168.1.0/24.
    
 ### Configuration des interfaces
    
 En mode ```configure``` , on va configurer les 2 interfaces.
    
 Pour __eth0__ : 
    
    set interfaces ethernet eth0 address 172.18.0.100/16
    
 On y ajoute une description : 
    
    set interface ethernet eth0 description LAN1
    
 Pour __eth1__ :
    
    set interfaces ethernet eth1 address 192.168.1.1/24
    
 Description : 
    
    set interface ethernet eth1 description LAN2
    
 Pour toute modification dans ```configure``` :
    
    commit
    save
    exit
    
    
 <HR>
   
   
   Ce qui donne avec un ```show interface ``` : 
   
   ![](https://i.imgur.com/HaKDL71.png)
   
   Les 2 interfaces sont configurées, passons au relais DHCP.
   
   <HR>
     
  ## Relais DHCP
    
 Il faut configurer l'interface d'écoute et l'interface upstream.
     
     set service dhcp-relay listen-interface eth1
     
     set service dhcp-relay upstream-interface eth0
     
 L'interface d'écoute est le client qui va faire un DHCPDISCOVER
 
 On lui donne ensuite l'adresse du serveur DHCP, ici *172.18.1.100*
     
     set service dhcp-relay server 172.18.1.100
     
     set service dhcp-relay relay-options relay-agents-packets discard
     
On peut taper ```show service dhcp-relay``` pour avoir un aperçu de notre config.
     
 ![](https://i.imgur.com/f8PhpEB.png)
     
La plage 192.168.1.1 jusqu'à 192.168.1.254 est dans le scope du serveur DHCP.
     
<HR>
     
Sur le client, le ```ipconfig /release```devrait nous attribuer une addresse de la plage établie.
     
![image](https://i.imgur.com/8ZBF3Sd.png)

> Pensez à désactiver le pare-feu windows en domaine/privé et à activer la découverte réseau sur vos machines
  
  
## Création de la route vers le pfsense
  
Toujours en mode ```configure ```, on lui indique la gateway par défaut (l'adresse du pfsense) :
  
 ```set protocols static route 0.0.0.0/0 next-hop 172.18.255.254```
 
 ```set protocols static route 10.0.0.0/24 next-hop 172.18.255.254```
  
Il faut permettre la traduction NAT afin de faire passer le WAN et d'avoir accès à internet : 
  
 ```set nat source rule 10 translation address masquerade```
  
Une dernière fois : 
  
  ```
  commit
  save
  exit
  ```

Sur votre client comme sur le serveur, ils devraient avoir accès à internet. 
 __Attention cependant aux règles du pfsense, il faut également une route vers le routeur vyos depuis le pfsense de configurée.__
  
  
<HR>

### Lien avec le schéma

![](https://i.imgur.com/Ri07fab.png)
