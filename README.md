# LeclonecoinApp

## Description
LeclonecoinApp est une application universelle (iPhone, iPad) écrite en Swift, conçue pour afficher une liste d'annonces à partir de l'API https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json, avec la correspondance des catégories d'articles basée sur l'API https://raw.githubusercontent.com/leboncoin/paperclip/master/categories.json.

https://github.com/shamurzaevdev/EmptyProject/assets/59398652/510cf28d-df43-4b32-bae6-9d4febad2118

L'architecture MVVM a été utilisée dans la construction de cette application, en complément des outils Builder et Router. Le projet est compatible pour iOS 14+ et suit strictement le principe de responsabilité unique. Les interfaces ont été créées avec autolayout directement dans le code sans l'utilisation de storyboard, xib ou SwiftUI.

Les annonces sont présentées dans un TableView, où chaque cellule de la liste d'annonces comporte au minimum une image, une catégorie, un titre et un prix. Si une image est absente, une image par défaut est affichée.  Un indicateur est également présent pour signaler si l'annonce est urgente. 

L'application offre une fonction de filtrage qui permet d'afficher uniquement les annonces d'une catégorie spécifique. De plus, les annonces sont triées par date, celles marquées comme urgentes en haut de la liste. Un tap sur une annonce dévoile une vue détaillée avec toutes les informations fournies dans l'API.


![noPicture](https://github.com/shamurzaevdev/EmptyProject/assets/59398652/724117fd-5cc1-40f2-a3f6-324ad736c1b4)
![Main](https://github.com/shamurzaevdev/EmptyProject/assets/59398652/96f18d4c-4c87-4a04-b10c-0cbab6f172b3)


![category](https://github.com/shamurzaevdev/EmptyProject/assets/59398652/09181129-cff2-43d8-bbde-a86f2bfc4596)
![urgent](https://github.com/shamurzaevdev/EmptyProject/assets/59398652/2f8238bd-27dc-4621-8900-d2fe09d09a63)


![details](https://github.com/shamurzaevdev/EmptyProject/assets/59398652/e4a6262c-d6e3-48cb-9095-1d6ffe5b04cb)

L'effort UX et UI est notable, et l'application est optimisée pour de bonnes performances. Les tests unitaires ont été effectués avec succès pour couvrir les fonctionnalités principales et garantir que l'application fonctionne comme prévu. Le code swifty a été utilisé tout au long du projet pour une meilleure lisibilité et maintenance.

![TestOne](https://github.com/shamurzaevdev/EmptyProject/assets/59398652/22004bd8-05c7-4f8b-80dc-ebfcdeca794b)
![TestTwo](https://github.com/shamurzaevdev/EmptyProject/assets/59398652/b22aeaea-33fc-48ab-9bf9-3cba220ee7bf)
![TestThree](https://github.com/shamurzaevdev/EmptyProject/assets/59398652/8dfa1b9f-4262-4ee9-bfcc-ca7ec21c5a73)


## Caractéristiques

- Architecture MVVM
- Utilisation des outils Builder et Router
- Affichage des annonces dans un TableView
- Vue détaillée des annonces avec image, catégorie, titre, et prix
- Filtre pour afficher seulement les annonces d'une catégorie spécifique
- Tri des annonces par date, avec les annonces urgentes en haut de la liste
- Affichage d'une image par défaut en cas d'absence d'image dans l'annonce
- Tests unitaires couvrant les fonctionnalités principales
- Efforts UX et UI
- Performances optimisées de l'application
- Code Swifty
