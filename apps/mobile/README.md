# AfriNutri — App mobile (Flutter)
 
Application mobile AfriNutri : scan de repas et suivi de l'objectif calorique.
Ce README explique comment lancer le projet en local pour voir les écrans.
 
## Prérequis
 
- **Flutter SDK** (stable) — vérifier l'installation :
```bash
  flutter doctor
```
  Corrige les éventuelles ✗ avant de continuer (Android toolchain, Xcode, etc.).
- Un éditeur avec les plugins Flutter/Dart : **VS Code** ou **Android Studio**.
- Un simulateur/émulateur, ou ton téléphone en mode développeur :
  - Android : un émulateur créé dans Android Studio (AVD Manager), ou un
    téléphone Android connecté en USB avec le débogage USB activé.
  - iOS (Mac uniquement) : un simulateur iOS via Xcode, ou un iPhone connecté.
## Récupérer le projet
 
```bash
git clone <url-du-repo>
cd <dossier-du-projet>
```
 
## Installer les dépendances
 
```bash
flutter pub get
```
 
Le projet utilise notamment :
- `go_router` — navigation (voir `lib/core/router/app_router.dart`)
- `dio` — appels API vers le backend FastAPI
- `flutter_secure_storage` — stockage du token JWT
- `google_fonts` — police (Inter) utilisée dans `AppTheme`
Si `flutter pub get` signale un package manquant, ajoute-le avec :
```bash
flutter pub add <nom_du_package>
```
 
## Lancer l'app
 
1. Démarre un émulateur/simulateur, ou branche ton téléphone.
2. Vérifie que l'appareil est bien détecté :
```bash
   flutter devices
```
3. Lance l'app :
```bash
   flutter run
```
   (Dans VS Code / Android Studio : ouvrir `lib/main.dart` puis "Run"/▶️.)
 
Au premier lancement, l'app s'ouvre sur l'écran **Landing** (accueil avant
connexion), d'où tu peux naviguer vers **Inscription** et **Connexion**.
 
## Backend / API
 
Les écrans qui appellent l'API (inscription, connexion, accueil...) ont
besoin du backend FastAPI en local, sinon les requêtes échoueront (les écrans
restent affichables, seuls les appels réseau ne fonctionneront pas).
 
- URL configurée en dev : `lib/core/config/app_config.dart` →
  `http://10.0.2.2:8000/api/v1`
  - `10.0.2.2` correspond à `localhost` de ta machine **vu depuis un
    émulateur Android**. Lance ton backend FastAPI en local sur le port 8000.
  - Sur un simulateur iOS, remplace par `http://localhost:8000/api/v1`.
  - Sur un téléphone physique, remplace par l'IP locale de ta machine
    (ex. `http://192.168.1.x:8000/api/v1`), les deux appareils devant être
    sur le même réseau Wi-Fi.
## Écrans actuellement disponibles
 
| Écran | Fichier |
|---|---|
| Landing | `lib/features/auth/presentation/screens/landing_screen.dart` |
| Connexion | `lib/features/auth/presentation/screens/login_screen.dart` |
| Inscription | `lib/features/auth/presentation/screens/register_screen.dart` |
| Accueil | `lib/features/home/presentation/home_screen.dart` |
 
Les routes sont centralisées dans `lib/core/router/app_router.dart`
(`AppRoutes`).
 
## À savoir / en cours

- Les couleurs, styles de champs/boutons sont centralisés dans
  `lib/core/theme/app_theme.dart` (`AppColors`, `AppTheme`) — réutilise ces
  constantes plutôt que des couleurs en dur pour rester cohérent avec les
  maquettes Figma.
## Problèmes fréquents
 
- **"No devices found"** → ouvre un émulateur avant `flutter run`, ou
  vérifie `flutter devices`.
- **Erreurs de compilation liées aux packages** → `flutter pub get`, puis en
  dernier recours `flutter clean && flutter pub get`.
- **Les écrans s'affichent mais les requêtes échouent** → vérifie que le
  backend FastAPI tourne et que l'URL dans `app_config.dart` correspond à ton
  environnement (voir section "Backend / API" ci-dessus).