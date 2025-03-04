#Script Administration Reseau

#Le script va appliquer la configuration souhaitée sur le serveur
function NewComputerName {
    #Indiquez le nom que vous souhaitez donner à votre machine serveur
    $NewName = Read-Host "Renseignez le futur nom de votre serveur" 

    #Le script renomme le serveur
    Rename-Computer -NewName $NewName -Force
    Restart-Computer
}

function NewNetConfig {
    #Indiquez la configuration réseau du serveur
    $NewIP = Read-Host "Renseignez l'adresse IP pour le serveur" 
    $NewPrefix = Read-Host "Renseignez le masque" 
    $NewGateway = Read-Host "Renseignez la passerelle par défaut" 

    #Le script va attribuer la configuration réseau souhaitée
    New-NetIPAddress -IPAddress "$NewIP" -PrefixLength "$NewPrefix" -InterfaceIndex (Get-NetAdapter).ifIndex -DefaultGateway "$NewGateway"

    #Le script va définir le serveur DNS
    Set-DnsClientServerAddress -InterfaceIndex (Get-NetAdapter).ifIndex -ServerAddresses ("127.0.0.1")
}

#A partir d'ici, le script va installer les rôles et services suivants : Active Directory ; DNS ; Outils d'administration graphique (facultatif)
#En cas d'erreur, le script l'indiquera par un message
function NewFeatures {
    $FeatureList = @("RSAT-AD-Tools", "AD-Domain-Services", "DNS")

    Foreach ($Feature in $FeatureList) {
    
        if (((Get-WindowsFeature-Name $Feature).InstallState) -eq "Available") {
        
            Write-Output "Feature $Feature will be installed now !"

            Try {
                Add-WindowsFeature-Name $Feature -IncludeManagementTools -IncludeAllSubFeature
                Write-Output "$Feature : Installation is a success !"
            }
            Catch {
                Write-Output "$Feature : Error during installation ! "
            }
        } # if(((Get-WindowsFeature-Name $Feature).InstallState)-eq"Available")

    } # Foreach($Feature in $FeatureList)
}
#Dans cette partie, le script va créer le domaine Active Directory
function NewAD {

    #Indiquez le nom de domaine souhaité
    $NewDomainNameDNS = Read-Host "Indiquez le nom de domaine DNS" 
    $NewDomaineNameNetbios = Read-Host "Indiquez le nom de domaine Netbios" 

    #Le script va utiliser les informations précédentes
    $DomaineNameDNS = "$NewDomainNameDNS"
    $DomainNameNetbios = "$NewDomainNameNetbios"

    $ForestConfiguration = @{
        '-DatabasePath'         = 'C:\Windows\NTDS';
        '-DomainMode'           = 'Default';
        '-DomainName'           = $DomaineNameDNS;
        '-DomainNetbiosName'    = $DomainNameNetbios;
        '-ForestMode'           = 'Default';
        '-InstallDNS'           = $true;
        '-LogPath'              = 'C:\Windows\NTDS';
        '-NoRebootOnCompletion' = $false;
        '-SysvolPath'           = 'C:\Windows\SYSVOL';
        '-Force'                = $true;
        '-CreateDnsDelegation'  = $false 
    }

    Import-Module ADDSDeployment
    Install-ADDSForest @ForestConfiguration
}

# Menu de gestion Administrateur
function AdminManagement {
    Clear-Host
    Write-Host "
====================================================
|         Menu de Gestion Administrateur           |
====================================================
| 1 - Renommer la machine serveur cible            |
| 2 - Donner la configuration réseau de la cible   |
| 3 - Installer les rôles AD - DNS - RSAT-AD-Tools |
| 4 - Créer le domaine Active Directory            |
====================================================
"

    $ActionChoice = Read-Host "Faites votre choix "

    #Appel des fonctions selon le choix de l'administrateur
    switch ($ActionChoice) {
        1 {  
            Write-Host "Vous avez choisi de renommer le serveur. ATTENTION cette fonction requiert un redémarrage !!"
            Start-Sleep -Seconds 3
            NewComputerName
        }

        2 {
            Write-Host "Vous avez choisi de modifier la configuration du serveur"
            Start-Sleep -Seconds 3
            NewNetConfig
        }
    
        3 {
            Write-Host "Vous avez choisi d'ajouter les rôles et services : Active Directory - DNS - RSAT-AD-Tools"
            Start-Sleep -Seconds 3
            NewFeatures
        }

        4 {
            Write-Host "Vous avez choisi de créer le domaine Active Directory. ATTENTION cette fonction requiert un redémarrage !!"
            Start-Sleep -Seconds 3
            NewAD
        }
    
        Default {
            Write-Host "Veuillez indiquer une valeur valide"
            Start-Sleep -Seconds 3
            AdminManagement
        }
    }
}

Clear-Host
Write-Host "Initialisation du Script"
Write-Host "Lancement du script dans 3 secondes"
Start-Sleep -Seconds 1
Clear-Host
Write-Host "Lancement du Script dans 2 secondes"
Start-Sleep -Seconds 1
Clear-Host
Write-Host "Lancement du script dans 1 secondes"
Start-Sleep -Seconds 1
Clear-Host
AdminManagement