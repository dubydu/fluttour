import 'dart:async';
import 'package:fluttour/data/api/contract_client.dart';
import 'package:fluttour/data/api/request/token_request.dart';
import 'package:fluttour/data/erc20/contract_locator.dart';
import 'package:fluttour/domain/models/eth_model.dart';
import 'package:fluttour/domain/models/token_model.dart';
import 'package:fluttour/utils/other/notifier_safety.dart';

class Web3Provider extends ChangeNotifierSafety {
  Web3Provider(this.contractLocator, this.tokenRequest);

  final ContractLocator contractLocator;
  final TokenRequest tokenRequest;

  late Timer _timer;

  /// WETH token
  double WETHCurrentPrice = 0;

  /// Token address
  final String tokenAddress = '0x990f341946a3fdb507ae7e52d17851b87168017c';

  TokenModel? _tokenModel;

  TokenModel? get tokenModel => _tokenModel;

  set tokenModel(TokenModel? value) {
    _tokenModel = value;
    notifyListeners();
  }

  Future<void> _getWETHPrice() async {
    ETHModel? ethModel = await tokenRequest.getETHPrice();
    if (ethModel != null) {
      double ethPrice = double.parse(ethModel.data?.ethPrice ?? '1');
      WETHCurrentPrice = ethPrice;
    }
  }

  Future<TokenModel?> getTokenInfo() async {
    tokenModel = await tokenRequest.getTokenInformation(token: tokenAddress);
  }

  Future<void> listenContract() async {
    await _getWETHPrice();
    BigInt decimals = tokenModel?.getDecimals() ?? BigInt.one;
    await ContractClient(contractLocator: contractLocator).listenContract((value) {
      if (value != null) {
        tokenModel?.getAmountsIn = value;
        startCalculateThePrice();
      }
    }, token: tokenAddress, decimals: decimals);
  }

  Future<void> startCalculateThePrice() async {
    int? amountsIn = tokenModel?.getAmountsIn?.toInt();
    if (tokenModel != null && amountsIn != null) {
      tokenModel?.price = (amountsIn * WETHCurrentPrice) / (tokenModel?.getDecimals().toInt() ?? 1);
      notifyListeners();
    }
  }

  Future<void> startTimer() async {
    _timer = Timer.periodic(Duration(seconds: 5), (_) async {
      await _getWETHPrice();
    });
  }

  @override
  void resetState() {
    tokenModel = null;
    _timer.cancel();
  }
}