# Téléphonie VOIIP avec FREEPBX

## Installation de FREEPBX : 

L'installation de Freepbx s fait très simplement avec le script ci-dessous.
```
cd /tmp
wget https://github.com/FreePBX/sng_freepbx_debian_install/raw/master/sng_freepbx_debian_install.sh  -O /tmp/sng_freepbx_debian_install.sh
bash /tmp/sng_freepbx_debian_install.sh
```
## Après l'installation  se connecter directement grâce à l'adresse donnée à la fin de l'installation (Normalement l'adresse du serveur)

- **Créer le compte admin et définir son mot de passe**.
  
- **Ensuite choisir ``FreePBX Administration``**.

![FREEPBX](https://github.com/user-attachments/assets/c16de851-8c49-46f0-b910-37a84c7c3002)

- **Se connecter avec le compte admin créer**.

![FREEPBX](https://github.com/user-attachments/assets/47bfbdf1-b493-4d1e-bf60-7594b52ec17c)

- **Ajouter tous les utilisateurs du domaine grâce à un ``fichier .csv`` **.

![FREEPBX](https://github.com/user-attachments/assets/be1b778d-039e-4ae7-a5b2-670041e36543)


- **Choisir ``Admin`` puis ``Bulk Handler``**.
  
![FREEPBX](https://github.com/user-attachments/assets/9b109810-04f4-4565-861c-98e98154f795)

- **Cliquer sur ``Import`` puis sur ``Browse``**.

![FREEPBX](https://github.com/user-attachments/assets/fd11e9f0-260c-4fbb-881b-fc0a5755cd6d)

- **Choisissez le ``fichier .csv`` puis sur ``Open``**.

![FREEPBX](https://github.com/user-attachments/assets/4403516f-4dce-4a2f-9bd7-a3f03acffa3b)

- **Une fois les utilisateurs ajoutés, aller dans ``Connectivity`` puis dans ``Extensions``**.

![FREEPBX](https://github.com/user-attachments/assets/aba5c62e-7954-4fad-9fd5-31f659247bcd)

- **On aperçoit bien tous les utilisateurs ajoutés dans ``FreePBX`` avec la configuration pour la communication entre les différents utilisateurs**.

![FREEPBX](https://github.com/user-attachments/assets/759c945a-573b-429d-aabf-cf50cbcc20ce)
