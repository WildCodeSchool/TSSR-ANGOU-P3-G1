<div align="center"><H1> Install -  Sprint 5 </H1></div>

## 1) DOSSIERS PARTAGES - Mettre en place des dossiers réseaux pour les utilisateurs

### A) Stockage des données sur un volume spécifique

### B) Sécurité de partage des dossiers par groupe AD

### C) Mappage des lecteurs sur les clients (au choix) :

#### a) GPO

#### b) Script PowerShell/batch

#### c) Profil utilisateur AD

### D) Chaque utilisateur a accès à :

#### a) Un dossier individuel , avec une lettre de mappage réseau I, accessible uniquement par cet utilisateur

#### b) Un dossier de service, avec une lettre de mappage réseau J, accessible par tous les utilisateurs d'un même service.

#### c) Un dossier de département, avec une lettre de mappage K, accessible par tous les utilisateurs d'un même département.

## 2) STOCKAGE AVANCÉ - Mettre en place du RAID 1 sur un serveur

## 2 bis) STOCKAGE AVANCÉ - Mettre en place LVM sur un serveur Debian

## 3) SAUVEGARDE - Mettre en place une sauvegarde de données

**Installation du logiciel de sauvegarde et de restauration de fichier Bareos :**  

**Prérequis :**  
- Une VM Debian 12  
- Accès Internet  

Récupération du premier script avec la commande suivante :  

```
wget https://download.bareos.org/current/Debian_12/add_bareos_repositories.sh
```  

Installation et lancement d'un serveur de base de données PostgreSQL :  

```
apt-get update
apt-get install postgresql postgresql-contrib
```  

Vérifier l'installation de Postgre :  

```
systemctl status postgresql
```

_PostgreSQL utilise par défaut le port 5432, à ouvrir au besoin._  

Installer le paquet gpg pour la bonne exécution d'une ligne du premier script téléchargé puis lancement du script :  

```
apt-get install gpg
bash add_bareos_repositories.sh
```

Une fois le premier script exécuté, mise à jour des paquets puis installation de bareos et de bareos-database-postgresql :  

```
apt-get update
apt-get install bareos bareos-database-postgresql
```

Puis suivre les instructions choisir **yes** pour utiliser **dbconfig-common**.  

Préparer la base de données Bareos (il est très probable que la première commande retourne que la base de donnée existe déjà), (postgre = utilisateur postgresql) :  

```
su postgre -c /usr/lib/bareos/scripts/create_bareos_database
su postgre -c /usr/lib/bareos/scripts/make_bareos_tables
su postgre -c /usr/lib/bareos/scripts/grant_bareos_privileges
```

_Bareos utilise par défaut les ports 9101 à 9103, à ouvrir au besoin._  

Lancer les daemons :  

```
systemctl enable --now bareos-director.service
systemctl enable --now bareos-storage.service
systemctl enable --now bareos-filedaemon.service
```

Si des problèmes sont rencontrés avec ces commandes, essayer :  

```
systemctl enable --now bareos-dir.service
systemctl enable --now bareos-sd.service
systemctl enable --now bareos-fd.service
```

Puis taper les mêmes commandes en tapant "status" à la place de "enable --now".

**Installation de l'interface web de Bareos :**  

Installation du paquet :  

```
apt-get install bareos-webui
```

Comme le support de php-fpm n'est pas ajouté automatiquement à Apache2, il faut le faire avec les commandes suivantes :  

```
a2enmod proxy_fcgi setenvif
a2enconf php8.2-fpm
systemctl reload apache2
```

Créer l'utilisateur administrateur de Bareos :  

```
bconsole
```

```
configure add console name=admin password=Azerty1* profile=webui-admin
```

Si "profile=webui-admin" pose problème, l'enlever de la commande.  

Editer le nouveau fichier créé après l'exécution de la commande ci-dessus :  

```
nano /etc/bareos/bareos-dir.d/console/admin
```

et y ajouter les lignes :  

```
Profile = webui-admin
TLS Enable = NO
```

Redémarrer les services Bareos : 

```
systemctl restart bareos-dir
systemctl restart bareos-sd
systemctl restart bareos-fd
```

Accéder à la web interface depuis un client sur le même réseau :  

```
http://IP_ADDRESS/bareos-webui
```

**Mise en place d'une sauvegarde automatique des dossiers et fichiers utilisateur :**  


## 4) MOT DE PASSE ADMINISTRATEUR LOCAL - Mise en place de LAPS

1. **Console de gestion sur un AD (GUI)**

2. **Installation sur au moins 1 client (GPO ou script PS)**

## 5) GESTION DES OBJETS AD - Déplacement automatique des ordinateurs dans les bonnes OU

1. **Suivant le nom d'une machine et/ou la valeur d'un attribut AD**

2. **Automatisation par script PS exécuté par une tâche AT**

## 6) SECURITE D'ACCES - Restriction d'utilisation

1. **Pour les utilisateurs standard : connexion autorisée de 7h30 à 20h, du lundi au samedi sur les clients (bloquée le reste du temps)**

2. **Pour les administrateurs : bypass**

3. **Gestion des exceptions : prévoir un groupe bypass**
