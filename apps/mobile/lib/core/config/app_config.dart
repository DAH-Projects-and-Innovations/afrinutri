// lib/core/config/app_config.dart

enum AppEnvironment { dev, prod }

class AppConfig {
  final String apiBaseUrl;
  final AppEnvironment environment;

  const AppConfig._({
    required this.apiBaseUrl,
    required this.environment,
  });

  // Environnement DEV — pointe vers ton FastAPI en local
  static const dev = AppConfig._(
    apiBaseUrl: 'http://10.0.2.2:8000/api/v1', // 10.0.2.2 = localhost depuis l'émulateur Android
    environment: AppEnvironment.dev,
  );

  // Environnement PROD — pointe vers le serveur déployé
  static const prod = AppConfig._(
    apiBaseUrl: 'https://api.afrinutri.com/api/v1',
    environment: AppEnvironment.prod,
  );

  bool get isDev => environment == AppEnvironment.dev;
  bool get isProd => environment == AppEnvironment.prod;
}

// Instance globale — changer ici pour switcher d'env
const appConfig = AppConfig.dev;