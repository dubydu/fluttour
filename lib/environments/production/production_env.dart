import 'package:fluttour/environments/environement.dart';

extension ProductionEnvironment on Environment {
  /// Product environment
  static Environment production() {
    return Environment(
        cmsGraphQLEndPoint: 'https://api-ap-northeast-1.graphcms.com/v2/ckpphjwhcz1bo01xsbdkx7rjx/master',
        uniSwapGraphQLEndpoint: 'https://api.thegraph.com/subgraphs/name/uniswap/uniswap-v3',
        httpsEthRPCEndpoint: 'https://mainnet.infura.io/v3/48df4ebd2b414bce8a872974dc80e99a',
        wssEthRPCEndpoint: 'wss://mainnet.infura.io/ws/v3/48df4ebd2b414bce8a872974dc80e99a',
        httpsBscRPCEndpoint: '',
        wssBscRPCEndpoint: '');
  }
}