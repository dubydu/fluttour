import 'dart:math';

import 'package:fluttour/data/erc20/contract_locator.dart';
import 'package:fluttour/data/erc20/contract_service.dart';
import 'package:web3dart/web3dart.dart' as web3;
import 'dart:async';

import 'package:web3dart/web3dart.dart';

class ContractClient {
  ContractClient({required this.contractLocator});

  late final ContractLocator contractLocator;
  final String WETH = '0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2';
  final String UNISWAP_ROUTER_V2 = '0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D';

  /// Listen the contract event
  Future<void> listenContract(TransferValue onTransfer, {required String token, required int decimals}) async {
    double? result = 0;
    final ContractService contractService = await contractLocator.initInstance(WETH);
    contractService.listenEvent((web3.EthereumAddress from, web3.EthereumAddress to, BigInt value) async {
      result = await getAmountsIn(token, decimals);
      onTransfer(result);
    }, EventABIType.Transfer);
  }

  /// Get amounts in
  Future<double?> getAmountsIn(String token, int decimals) async {
    final EthereumAddress add1 = web3.EthereumAddress.fromHex(WETH);
    final EthereumAddress add2 = web3.EthereumAddress.fromHex(token);

    final ContractService contractService = await contractLocator.initInstance(UNISWAP_ROUTER_V2);

    BigInt amount = BigInt.from(double.parse('1.0') * pow(10, decimals));
    final List<web3.EthereumAddress> listAddress = <web3.EthereumAddress>[add1, add2];
    List<dynamic> param = <dynamic>[amount, listAddress];

    List<dynamic> response = await contractService.getAmountsIn(param);

    double tokenPerWETH = (response[0] as BigInt) / (response[1] as BigInt); // response[1] is the decimals

    return tokenPerWETH;
  }
}