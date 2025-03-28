<div align="center"><H1> Install -  Sprint 8 </H1></div>

## 1) WSUS - Mettre en place un serveur de mise a jours Windows

Ajouter le Rôle WSUS à un Windows server 2022 sur une VM dédiée

![WSUS](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/SCREENS-PAR-SPRINT/SCREENS-SPRINT8/wsus0-1.png)

![WSUS](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/SCREENS-PAR-SPRINT/SCREENS-SPRINT8/wsus0-2.png)


![WSUS](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/SCREENS-PAR-SPRINT/SCREENS-SPRINT8/wsus0-3.png)

Après avoir ajouté le Rôle WSUS il est nécessaire de faire une configuration post déploiement :

![WSUS](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/SCREENS-PAR-SPRINT/SCREENS-SPRINT8/wsus1.png)

![WSUS](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/SCREENS-PAR-SPRINT/SCREENS-SPRINT8/wsus2.png)

![WSUS](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/SCREENS-PAR-SPRINT/SCREENS-SPRINT8/wsus3.png)

![WSUS](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/SCREENS-PAR-SPRINT/SCREENS-SPRINT8/wsus4.png)

![WSUS](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/SCREENS-PAR-SPRINT/SCREENS-SPRINT8/wsus5.png)

![WSUS](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/SCREENS-PAR-SPRINT/SCREENS-SPRINT8/wsus6.png)

![WSUS](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/SCREENS-PAR-SPRINT/SCREENS-SPRINT8/wsus7.png)

![WSUS](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/SCREENS-PAR-SPRINT/SCREENS-SPRINT8/wsus8.png)

![WSUS](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/SCREENS-PAR-SPRINT/SCREENS-SPRINT8/wsus9.png)

Dans le gestionnaire "Update Services", ajouter deux goupes : Clients Windows / Serveurs Windows en lien avec des OU dans l'Active Directory du DC (Via GPO)

![WSUS](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/SCREENS-PAR-SPRINT/SCREENS-SPRINT8/wsus10.png)

Dans le panel d'Options, choisir Automatic Approvals puis cocher l'options ci-dessous pour déployer automatiquement les mises à jours critiques et de sécurité

![WSUS](https://github.com/WildCodeSchool/TSSR-ANGOU-P3-G1/blob/main/SCREENS-PAR-SPRINT/SCREENS-SPRINT8/wsus11.png)


## 2) Rôles FSMO - Mettre en place les rôles sur 3 DC


