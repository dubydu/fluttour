import 'package:fluttour/environments/development/development_env.dart';
import 'package:fluttour/environments/production/production_env.dart';

class Environment {
  Environment ({
    required this.cmsGraphQLEndPoint,
    required this.uniSwapGraphQLEndpoint,
    required this.httpsEthRPCEndpoint,
    required this.wssEthRPCEndpoint,
    required this.httpsBscRPCEndpoint,
    required this.wssBscRPCEndpoint
  });

  /// Prod environment
  factory Environment.production() {
    return ProductionEnvironment.production();
  }

  /// Dev environment
  factory Environment.development() {
    return DevelopmentEnvironment.development();
  }

  /// CMS Client
  final String cmsGraphQLEndPoint;
  /// Uniswap Router V2
  final String uniSwapGraphQLEndpoint;
  /// ETH Blockchain public RPC
  final String httpsEthRPCEndpoint;
  final String wssEthRPCEndpoint;
  /// BSC Blockchain public RPC
  final String httpsBscRPCEndpoint;
  final String wssBscRPCEndpoint;
}
