# Téléphonie VOIP avec FREEPBX

## Installation de FREEPBX : 

L'installation de Freepbx se fait très simplement avec le script ci-dessous.
```
cd /tmp
wget https://github.com/FreePBX/sng_freepbx_debian_install/raw/master/sng_freepbx_debian_install.sh  -O /tmp/sng_freepbx_debian_install.sh
bash /tmp/sng_freepbx_debian_install.sh
```
## Après l'installation  se connecter directement à l'interface d'administration de Freepbx grâce à l'adresse donnée à la fin de l'installation, ici 172.20.1.112 (l'adresse du serveur Debian mis dans la DMZ)

![FREEPBX](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/SCREENS-PAR-SPRINT/SCREENS-SPRINT9/freepbx-1.png)


- **Créer le compte admin et définir son mot de passe**.
  
- **Ensuite choisir ``FreePBX Administration``**.

![FREEPBX](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/SCREENS-PAR-SPRINT/SCREENS-SPRINT9/freepbx-2.png)


- **Se connecter avec le compte admin créé**.

![FREEPBX](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/SCREENS-PAR-SPRINT/SCREENS-SPRINT9/freepbx-3.png)


- **Ajouter tous les utilisateurs du domaine grâce à un ``fichier .csv`` formaté comme ci-dessous**.
  
![FREEPBX](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/SCREENS-PAR-SPRINT/SCREENS-SPRINT9/freepbx-4.png)



- **Choisir ``Admin`` puis ``Bulk Handler``**.

![FREEPBX](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/SCREENS-PAR-SPRINT/SCREENS-SPRINT9/freepbx-5.png)


- **Cliquer sur ``Import`` puis sur ``Browse``**.

![FREEPBX](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/SCREENS-PAR-SPRINT/SCREENS-SPRINT9/freepbx-6.png)


- **Choisissez le ``fichier .csv`` puis sur ``Open``**.
  
![FREEPBX](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/SCREENS-PAR-SPRINT/SCREENS-SPRINT9/freepbx-7.png)


- **Une fois les utilisateurs ajoutés, aller dans ``Connectivity`` puis dans ``Extensions``**.

![FREEPBX](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/SCREENS-PAR-SPRINT/SCREENS-SPRINT9/freepbx-8.png)


- **On aperçoit bien tous les utilisateurs ajoutés dans ``FreePBX`` avec la configuration pour la communication entre les différents utilisateurs**.

![FREEPBX](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/SCREENS-PAR-SPRINT/SCREENS-SPRINT9/freepbx-9.png)

