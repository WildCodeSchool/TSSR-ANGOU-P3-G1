<div align="center"><H1> Install -  Sprint 3 </H1></div>

## 1) Rejoindre l'AD-DS avec le serveur Debian

### Étape 1 : Préparer le serveur Debian
1. **Mettre à jour le système** :
   ```bash
   sudo apt update && sudo apt upgrade -y
   ```

2. **Installer les paquets nécessaires** :
   Tu auras besoin de `realmd`, `samba`, `samba-common`, `samba-common-bin`, et `sssd`. Installe-les avec la commande suivante :
   ```bash
   sudo apt install realmd samba samba-common-bin sssd
   ```

### Étape 2 : Configurer le DNS
**Ajouter l'adresse IP du contrôleur de domaine** :
   Modifie le fichier `/etc/resolv.conf` pour ajouter l'IP de ton contrôleur de domaine comme serveur DNS principal :
   ```bash
   sudo nano /etc/resolv.conf
   ```
   Ajoute la ligne suivante :
   ```
   nameserver <IP_DU_CONTROLEUR_DE_DOMAINE>
   ```

### Étape 3 : Découvrir le domaine
**Utiliser `realm` pour découvrir le domaine** :
   Exécute la commande suivante pour vérifier que le domaine est accessible :
   ```bash
   realm discover <NOM_DU_DOMAINE>
   ```

### Étape 4 : Joindre le domaine
**Joindre le domaine** :
   Utilise la commande suivante pour joindre le domaine. Remplace `<NOM_DU_DOMAINE>` par le nom de ton domaine :
   ```bash
   sudo realm join <NOM_DU_DOMAINE> -U <UTILISATEUR_ADMIN>
   ```
   Tu devras entrer le mot de passe de l'utilisateur administrateur du domaine.

### Étape 5 : Vérifier l'intégration
**Vérifier que le serveur est bien joint au domaine** :
   Utilise la commande suivante :
   ```bash
   realm list
   ```

## 2) Les GPO

### Les GPO de sécurité

#### 0 : Créer une GPO / Lier une GPO à une OU / Configurer la ou les cibles d'une GPO

Les étapes qui vont suivre s'appliquent à la création de **TOUTES** les GPO et ne seront donc pas présentes dans les guides suivants. 

1. **Créer une GPO**

Depuis la **Gestion de stratégie de groupe** (accessible depuis le menu déroulant **Outils**), dérouler l'arborescence et une fois arrivé sur votre domaine (ici _local.lan_), clic droit sur **Objets de stratégie de groupe** puis **Nouveau** :
![1_NOUVELLE_GPO.png](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/SCREENS-PAR-SPRINT/SCREENS-SPRINT3/GPO_INSTALL/1_NOUVELLE_GPO.png)

Nommer la GPO selon une convention de nommage ou de sorte à pouvoir identifier la ou les cibles, puis cliquer sur **OK** :
![2_NOMMER_GPO.png](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/SCREENS-PAR-SPRINT/SCREENS-SPRINT3/GPO_INSTALL/2_NOMMER_GPO.png)

Clic droit sur la nouvelle GPO et sélectionner **Modifier** :
![3_CLIC_DROIT_MODIFIER.png](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/SCREENS-PAR-SPRINT/SCREENS-SPRINT3/GPO_INSTALL/3_CLIC_DROIT_MODIFIER.png)

2. **Lier une GPO à une OU**

Clic droit sur l'OU cible et sélectionner **Lier un objet de stratégie de gorupe existant...** :
![4_LIER_GPO](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/SCREENS-PAR-SPRINT/SCREENS-SPRINT3/GPO_INSTALL/4_LIER_GPO.png)

3. **Renseigner l'état de la GPO**

Clic gauche sur la GPO, dans le menu de droite, définir l'**Etat GPO** au besoin :
![5_ETAT_GPO](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/SCREENS-PAR-SPRINT/SCREENS-SPRINT3/GPO_INSTALL/5_ETAT_GPO.png)

4. **Indiquer les groupes et/ou les utilisateurs ciblés par la GPO**

Clic gauche sur la GPO, dans le menu de droite, cliquer sur **Ajouter...** dans la partie **Filtrage de sécurité** :
![6_GROUPE_UTILISATEUR_CIBLE](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/SCREENS-PAR-SPRINT/SCREENS-SPRINT3/GPO_INSTALL/6_RENSEIGNER_GROUPE_UTILISATEUR_CIBLE.png)

Entrer le nom de l'utilisateur ou du groupe souhaité, puis cliquer sur **Vérifier les noms**, puis sur **OK**
![7_CHECK_NAMES](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/SCREENS-PAR-SPRINT/SCREENS-SPRINT3/GPO_INSTALL/7_CHECK_NAMES.png)


#### 1 : Blocage complet du panneau de config

Après avoir sélectionné la GPO, clic droit **Modifier**. Dans l'**Editeur de gestion des stratégies de groupe**, sous le menu **Configuration utilisateur**, dérouler jusqu'au **Panneau de configuration** sous **Modèles d'administration** :  
![1_DEROULER_PANNEAUCONF](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/SCREENS-PAR-SPRINT/SCREENS-SPRINT3/GPO_INSTALL/Panneau%20de%20conf/1_DEROULER_PANNEAUCONF.png)

Clic gauche sur **Panneau de configuration** et dans le menu de droite, choisir **Interdire l'accès au Panneau de configuration et à l'application...** en double cliquant :  
![2_INTERDIRE_ACCES](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/SCREENS-PAR-SPRINT/SCREENS-SPRINT3/GPO_INSTALL/Panneau%20de%20conf/2_INTERDIRE_ACCES.png)

Dans le menu suivant, cocher **Activé** :  
![3_COCHER_ACTIVE](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/SCREENS-PAR-SPRINT/SCREENS-SPRINT3/GPO_INSTALL/Panneau%20de%20conf/3_COCHER_ACTIVE.png)

Après un ```gpupdate /force``` sur le ou les clients, la GPO devrait désormais bloquer l'accès au panneau de configuration des utilisateurs cibles.


#### 2 : Sécurité PowerShell + CMD

1. **PowerShell**

Après avoir sélectionné la GPO, clic droit **Modifier**. Depuis l'**Editeur de gestion des stratégies de groupe**, sous le menu **Configuration utilisateur**, dérouler jusqu'aux **Stratégies de restriction logicielle** sous **Paramètres de sécurité** :  
![1_DEROULER_STRATEGIES](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/SCREENS-PAR-SPRINT/SCREENS-SPRINT3/GPO_INSTALL/Powershell/1_DEROULER_STRATEGIES.png)

Effectuer un clic droit sur **Stratégies de restriction logicielle** et cliquer sur **Nouvelles stratégies de restriction logicielle** :  
![2_CLIC_NOUVELLES](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/SCREENS-PAR-SPRINT/SCREENS-SPRINT3/GPO_INSTALL/Powershell/2_CLIC_NOUVELLES.png)

Pour créer de nouvelles règles, effectuer un clic druit sur **Règles suplémentaires** puis cliquer sur **Nouvelle règle de chemin d'accès** :  
![3_NOUVELLE_REGLE](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/SCREENS-PAR-SPRINT/SCREENS-SPRINT3/GPO_INSTALL/Powershell/3_NOUVELLE_REGLE.png)

Renseigner le **Chemin d'accès** :  
![4_CHEMIN_ACCES](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/SCREENS-PAR-SPRINT/SCREENS-SPRINT3/GPO_INSTALL/Powershell/4_CHEMIN_ACCES.png)

Powershell ne se limite pas qu'à une version, plusieurs sont généralement présentes sur les systèmes Windows, voici la liste des chemins probables (_Image issue du tuto [IT-Connect](https://www.it-connect.fr/comment-bloquer-powershell-pour-les-utilisateurs/)_):  
![5_CHEMINS](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/SCREENS-PAR-SPRINT/SCREENS-SPRINT3/GPO_INSTALL/Powershell/5_CHEMINS.png)

2. **CMD**

Après avoir sélectionné la GPO, clic droit **Modifier**. Depuis l'**Editeur de gestion des stratégies de groupe**, sous le menu **Configuration utilisateur**, dérouler jusqu'au **Système** sous **Modèles d'administration** :  
![1_DEROULER_SYSTEME](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/SCREENS-PAR-SPRINT/SCREENS-SPRINT3/GPO_INSTALL/CMD/1_DEROULER_SYSTEME.png)

Clic gauche sur **Système** et dans le menu de droite, choisir **Désactiver l'accès à l'invite de commandes** en double cliquant :  
![2_DESACTIVER_INVITECMD](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/SCREENS-PAR-SPRINT/SCREENS-SPRINT3/GPO_INSTALL/CMD/2_DESACTIVER_INVITECMD.png)

Dans le menu suivant, cocher **Activé** :  
![3_COCHER_ACTIVE](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/SCREENS-PAR-SPRINT/SCREENS-SPRINT3/GPO_INSTALL/CMD/3_COCHER_ACTIVE.png)



#### 3 : Restriction des périphériques amovibles

Après avoir sélectionné la GPO, clic droit **Modifier**.

#### 4 : Ecran de veille avec MDP en sortie

Après avoir sélectionné la GPO, clic droit **Modifier**.

#### 5 : Verrouillage de compte (Après un nombre d'erreurs de mot de passe définie)

Après avoir sélectionné la GPO, clic droit **Modifier**.

#### 6 : Blocage de l'accès du gestionnaire de tâche

Après avoir sélectionné la GPO, clic droit **Modifier**.

### Les GPO Standards

#### 1 : Fond d'écran

Après avoir sélectionné la GPO, clic droit **Modifier**.

#### 2 : Mappage de lecteur

Après avoir sélectionné la GPO, clic droit **Modifier**.

#### 3 : Configuration des paramètres de langues

Après avoir sélectionné la GPO, clic droit **Modifier**.

#### 4 : Déploiement de logiciels

Après avoir sélectionné la GPO, clic droit **Modifier**.

#### 5 : Gestion de l'alimentation

Après avoir sélectionné la GPO, clic droit **Modifier**.

## 3) GLPI
![GLPI](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/Sprint3/images/logo_glpi.png)

### A) Installation et configuration de GLPI version 10.0.17 sur un serveur Linux distribution Debian 12

   #### a) Prérequis. GLPI a besoin d'un serveur Web, de PHP et d'une base de données pour fonctionner.Il y aura également plusieurs extensions PHP à installer.

Choix des solutions pour répondre aux prérquis :

   => Serveur web : Apache2
   
   => Version de PHP : 8.2
   
   => Base de données : MariaDB
   

   #### b) Préparation du serveur avant installation de GLPI

  Mettre à jour et à niveau le serveur :

  ```
   sudo apt-get update && sudo apt-get upgrade
   ```

  Installation du socle LAMP :

  ```
   sudo apt-get install apache2 php mariadb-server
   ```
 
  installation des extensions :

 ```
   sudo apt-get install php-xml php-common php-json php-mysql php-mbstring php-curl php-gd php-intl php-zip php-bz2 php-imap php-apcu
   ```
  
  
  Installation de l'extensions LDAP pour utiliser GLPI avec un Active Directory

```
   sudo apt-get install php-ldap
   ```
  
  

  Sécurisation de la base de données ( Changement de mot de passe root,suppression des utilisateurs anonymes, désactivation de l'accès root à
  distance,etc...) :


```
   sudo mysql_secure_installation
   ```
  
  

![GLPI](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/Sprint3/images/Secure_BD.png)

  Création dela base de données dédiée pour GLPI :
  Connexion à votre instance MariaDB, Saisir le mot de passe Root défini à l'étape précédente


```
   sudo mysql -u root -p
   ```
  
  

  

  Puis, exécuter les requêtes SQL ci-dessous pour créer la base de données "db23_glpi" ainsi que l'utilisateur "glpi_adm" avec un mot de passe

![GLPI](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/Sprint3/images/CREATE_BD.png)
 

  Liste des commandes pour un eventuel copier/coller :
  
  CREATE DATABASE db23_glpi;
  
  GRANT ALL PRIVILEGES ON db23_glpi.* TO glpi_adm@localhost IDENTIFIED BY "MotDePasseRobuste";
  
  FLUSH PRIVILEGES;
  
  EXIT





  
  
   #### c) Installation de GLPI

   Télécharger GLPI depuis le dépot GitHub et préparer l'installation :


```
     wget https://github.com/glpi-project/glpi/releases/download/10.0.10/glpi-10.0.10.tgz
   ```

  Mettre le fichier .tgz téléchargé dans le reprtoire /tmp puis le décompresser dans le repertoire /var/www :

  
```
    sudo tar -xzvf glpi-10.0.10.tgz -C /var/www/
   ```

   Définir l'utilisateur "www-data" correspondant à Apache2, en tant que propriétaire sur les fichiers GLPI

```
sudo chown www-data /var/www/glpi/ -R
   ```


Une fois l'installation terminée, en tapant l'adresse IP de la machine sur laquelle GLPI à été installé (ou l'adresse du site web glpi.support.billu.tech préalablement déclaré dans le DNS), nous arrivons sur la page suivante.
Seule la possibilité de se connecter à "Internal GLPI database" est possible pour le moment.


![GLPI](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/Sprint3/images/image_login_GLPI.png)


ATTENTION Sur la VM Debian pour GLPI il est nécéssaire d'établir une règle dans le firewall pour éviter de bloquer l'accès au serveur web sous apache pour accéder a l'interface GLPI

ufw port 80 allow (pour accès en http) et ufw port 443 allow (pour accès en https)


### B) Déploiement de l'agent GLPI sur les clients (Windows et Linux)

Il est possible de déployer un agent GLPI pour remonter des informations (caractéristiques de l'ordianteurs, logiciels installés) depuis les clients vers la base de données GLPI

Source pour le téléchargement de l'agent : https://github.com/glpi-project/glpi-agent/releases/tag/1.7

Une fois l'agent installé sur un PC client il est possible de forcer l'éxecution pour la mise à jour dans GLPI (ou bien il faut attendre la prochaine MAJ automatique)

![GLPI](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/Sprint3/images/agent_glpi.png)

Voici le resultat dans GLPI

![GLPI](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/Sprint3/images/remonte_agent_glpi.png)


### C) Lien entre l'AD du domaine BillU.lan et GLPI

Pour faire ceci nous allons utiliser l'annuaire LDAP


![GLPI](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/Sprint3/images/annuaire_ldap.png)

![GLPI](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/Sprint3/images/annuaire_ldap2.png)

![GLPI](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/Sprint3/images/annuaire_ldap3.png)

Ne pas utiliser le compte administrateur du controleur de Domaine avec le role AD mais créer au préalable un utilisateur standard (ici sync_glpi) comme compte de service.

![GLPI](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/Sprint3/images/annuaire_ldap4.png)

Un fois la connexion établie, il est possible de la tester 

![GLPI](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/Sprint3/images/annuaire_ldap5.png)

![GLPI](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/Sprint3/images/annuaire_ldap6.png)

Importons maintenant les utilisateurs de l'AD dans GLPI

![GLPI](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/Sprint3/images/annuaire_ldap8.png)

Pour obtenir cette liste d'utilisateurs directement importé depuis notre Active Directory, il faudra au préalable selectionner "Liaison annuaire LDAP" puis rentrer les infos visible sur les copies d'écrans suivantes

![GLPI](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/Sprint3/images/annuaire_ldap9.png)

![GLPI](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/Sprint3/images/annuaire_ldap10.png)


Une fois cette configuration terminée, en tapant l'adresse IP de la machine sur laquelle GLPI à été installé (ou l'adresse du site web glpi.support.billu.tech préalablement déclaré dans le DNS), nous arrivons sur la page suivante.
Maintenant nous avons le choix et la possibilité de se connecter soit à "Internal GLPI database", soit comme utilisateur de l'AD afin de pouvoir créer un ticket pour le support.


![GLPI](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/Sprint3/images/image_login_GLPI.png)

### D) Ticketing

Copie d'écran d'un ticket créer par un utilisateur de l'AD dont l'acronyme est FS, pour un test.

![GLPI](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/Sprint3/images/ticketing.png)


### E) Les Tutos et ressources internet sur GLPI

https://forum.glpi-project.org/viewtopic.php?id=163985

https://github.com/glpi-project/glpi/releases/

https://github.com/glpi-project/glpi-agent/releases/tag/1.7

https://services.glpi-network.com

https://openclassrooms.com/fr/courses/1730516-gerez-votre-parc-informatique-avec-glpi/5994176-installez-le-plugin-et-l-agent-fusioninventory

https://www.it-connect.fr/installation-pas-a-pas-de-glpi-10-sur-debian-12/

https://www.it-connect.fr/glpi-en-https-comment-ajouter-un-certificat-ssl/

https://www.it-connect.fr/tuto-installer-configurer-gpo-agent-glpi-windows/

https://www.it-connect.fr/tuto-glpi-configurer-authentification-active-directory/

https://www.it-connect.fr/tuto-glpi-configurer-authentification-active-directory/

https://colinfo.fr/configuration-et-installation-de-lagent-glpi-sous-windows-et-linux/

https://faq.teclib.com/02_FAQ/Agent/#what-are-the-functionalities-of-the-toolbox

https://forum.glpi-project.org/viewtopic.php?id=290271

https://tutos-info.fr/wp-content/uploads/2023/02/TUTORIEL-CONFIGURER-LDAP-SUR-GLPI-10.pdf

https://neptunet.fr/glpi-ad/

https://forum.glpi-project.org/viewtopic.php?id=249247

https://openclassrooms.com/fr/courses/1730486-gerez-vos-incidents-avec-le-referentiel-itil-sur-glpi/6544666-creez-et-qualifiez-un-ticket-d-incident



   
