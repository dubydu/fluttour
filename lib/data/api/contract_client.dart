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
  final String UNISWAP_ROUTER_V2_FACTORY = '0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D';

  /// Listen the contract event
  Future<void> listenContract(TransferValue onTransfer, {required String token, required BigInt decimals}) async {
    BigInt? result = BigInt.zero;
    final ContractService contractService = await contractLocator.initInstance(WETH);
    contractService.listenEvent((web3.EthereumAddress from, web3.EthereumAddress to, BigInt value) async {
      result = await getAmountsIn(token, decimals);
      onTransfer(result);
    }, EventABIType.Transfer);
  }

  /// Get amounts in
  Future<BigInt?> getAmountsIn(String token, BigInt decimals) async {
    final EthereumAddress add1 = web3.EthereumAddress.fromHex(WETH);
    final EthereumAddress add2 = web3.EthereumAddress.fromHex(token);

    final ContractService contractService = await contractLocator.initInstance(UNISWAP_ROUTER_V2_FACTORY);

    BigInt amount = decimals;
    final List<web3.EthereumAddress> listAddress = <web3.EthereumAddress>[add1, add2];
    List<dynamic> param = <dynamic>[amount, listAddress];

    List<dynamic> response = await contractService.getAmountsIn(param);

    BigInt tokenPerWETH = response[0] as BigInt;

    return tokenPerWETH;
  }
}