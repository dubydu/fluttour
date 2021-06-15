import 'package:fluttour/environments/environement.dart';

extension DevelopmentEnvironment on Environment {
  /// Product environment
  static Environment development() {
    return Environment(
        graphQLEndPoint: 'https://api-ap-northeast-1.graphcms.com/v2/ckpphjwhcz1bo01xsbdkx7rjx/master',
        googleApiKey: '',
        websocketEndpoint: 'ws://');
  }
}