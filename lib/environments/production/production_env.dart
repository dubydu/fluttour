import 'package:fluttour/environments/environement.dart';

extension ProductionEnvironment on Environment {
  /// Product environment
  static Environment production() {
    return Environment(
        graphQLEndPoint: 'https://api-ap-northeast-1.graphcms.com/v2/ckpphjwhcz1bo01xsbdkx7rjx/production',
        googleApiKey: '',
        websocketEndpoint: 'ws://');
  }
}