# Sprint 10 - Audit de sécurité / Panne DNS

# Audit Active Directory

# Audit Serveurs Windows

# Audit Serveurs Linux

# Audit Serveur Web - Portail Captif

# Panne DNS

<HR>
Le stagiaire qui, par excès de confiance et manque de surveillance, s'est mit à bidouiller l'Active Directory et à commit une bourde.

Les techniciens de BillU ont été informé d'une panne et ont fait preuve de réactivité afin de résoudre celle ci.
<HR>

## Identification de la panne

La phase de test s'est déroulée par une étude des services de l'AD et une vague de ping pointant le domaine et le contrôleur de domaine principal(DC1) depuis les différentes machines du domaine par IP dans un premier temps.

S'étant rendu compte que le DC1 répondait correctement mais que le domaine répondait par le biais du deuxième contrôleur de domaine(DC2) et qu'en pingant avec le FQDN du DC1, une autre IP répondait, la piste du DNS était sérieuse.

## Résolution de la panne

Les zones DNS épluchées, l'erreur était flagrante. L'enregistrement A du DC1 pointant vers une IP différente de la sienne. On se demande tous à quel moment ce stagiaire a réussi l'exploit de modifier, par erreur, cet enregistrement.

L'impact de cette panne était moindre car la redondance a pris le relais pour la communication entre l'AD et les différentes machines du domaine ainsi que l'efficacité de l'équipe BillU pour identifier et résoudre ce problème.
