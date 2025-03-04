$Nom = Import-Csv -Path "C:\Salarie_billu.csv" -Delimiter ";" -Encoding UTF8 | Select-Object -ExpandProperty Nom
$Prenom = Import-Csv -Path "C:\Salarie_billu.csv" -Delimiter ";" -Encoding UTF8 | Select-Object -ExpandProperty "Prenom"
$societe = Import-Csv -Path "C:\Salarie_billu.csv" -Delimiter ";" -Encoding UTF8 | Select-Object -ExpandProperty "societe"
$departement = Import-Csv -Path "C:\Salarie_billu.csv" -Delimiter ";" -Encoding UTF8 | Select-Object -ExpandProperty "departement"
$Fonction = Import-Csv -Path "C:\Salarie_billu.csv" -Delimiter ";" -Encoding UTF8 | Select-Object -ExpandProperty "Fonction" 
$managerp = Import-Csv -Path "C:\Salarie_billu.csv" -Delimiter ";" -Encoding UTF8 | Select-Object -ExpandProperty "manager-prenom"
$managern = Import-Csv -Path "C:\Salarie_billu.csv" -Delimiter ";" -Encoding UTF8 | Select-Object -ExpandProperty "manager-nom"
$portable = Import-Csv -Path "C:\Salarie_billu.csv" -Delimiter ";" -Encoding UTF8 | Select-Object -ExpandProperty "Telephone portable"
$fixe = Import-Csv -Path "C:\Salarie_billu.csv" -Delimiter ";" -Encoding UTF8 | Select-Object -ExpandProperty "Telephone Fixe"
$service = Import-Csv -Path "C:\Salarie_billu.csv" -Delimiter ";" -Encoding UTF8 | Select-Object -ExpandProperty "Service"
While true {
Write-Host
"
1 : Création de tout les utilisateurs d'une liste
2 : Création d'un utilisateur en particulier dans une liste
3 : Consulter le nom des utilisateurs et leur emplacement(ligne) dans la liste
4 : Désactivation d'un utilisateur
"


$choix = Read-Host "Faites voitre choix"
switch ($choix)
{
1{
for ( $i = 0; $i -lt $Nom.Count; $i++ ) {

$Domaine = "Billu.lan"
$Motdepasse = "Azerty1*"
$Nom_users = $Nom[$i].replace(" ","")
$Nom_user = $Nom_users.replace("-","")
$Prenom_user = $Prenom[$i]
$managerpr = $managerp[$i]
$managerno = $managern[$i]
$manager = "$managerpr.$managerno"
$entreprise = $societe[$i]
$poste = $fonction[$i]
$telp = $portable[$i]
$telf = $fixe[$i]
$dep = $departement[$i]
$initialP = $Prenom_user.Substring(0,1)
$Nomlogin = $Nom_user
$login = "$initialP.$Nomlogin"
$NomPrenom = "$Prenom_user $Nom_user"
$mail = "$Nom_user.$Prenom_user@Billu.com"


#Création des utilisateurs 1 à 1 avec les informations récupérées
New-ADuser -Name "$NomPrenom" -GivenName "$Prenom_user" -Surname "$Nom_user" -SamaccountName "$login" -UserPrincipalName "$login@$domaine" -AccountPassword (ConvertTo-SecureString "Azerty1*" -AsPlainText -Force) -ChangePasswordAtLogon $true -Title "$poste" -Emailaddress "$login@billU.com" -Company "$societe" -MobilePhone "$telp" -OfficePhone "$telf" -Path "OU=Utilisateurs,OU=Paris,OU=Users,DC=Billu,DC=lan"
Enable-ADAccount -Identity $login
}
}
default {

}

}
}
