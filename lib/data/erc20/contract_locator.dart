import 'package:fluttour/app_define/app_config.dart';
import 'package:fluttour/data/erc20/contract_service.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';
import 'package:http/http.dart';
import 'contract_parse.dart';

class ContractLocator {
  ContractLocator._();

  static Future<ContractLocator> setup() async {
    return ContractLocator._();
  }

  Future<ContractService> initInstance(String tokenAddress) async {
    final wss = AppConfig.shared.env!.wssEthRPCEndpoint;
    final https = Web3Client(AppConfig.shared.env!.httpsEthRPCEndpoint, Client(),
        socketConnector: () => IOWebSocketChannel.connect(wss).cast<String>());
    final DeployedContract contract = await ContractParser.fromAssets(tokenAddress);
    return ContractService(https, contract);
  }
}
