import 'package:fluttour/environments/development/development_env.dart';
import 'package:fluttour/environments/production/production_env.dart';

class Environment {
  Environment ({required this.graphQLEndPoint,
    required this.googleApiKey,
    required this.websocketEndpoint});

  /// Prod environment
  factory Environment.production() {
    return ProductionEnvironment.production();
  }

  /// Dev environment
  factory Environment.development() {
    return DevelopmentEnvironment.development();
  }

  final String graphQLEndPoint;
  final String googleApiKey;
  final String websocketEndpoint;
}
