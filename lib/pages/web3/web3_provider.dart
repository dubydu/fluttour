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

  /// WETH token
  final String WETH = '0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2';
  double WETHCurrentPrice = 0;

  /// AXS token
  final String AXS = '0xbb0e17ef65f82ab018d8edd776e8dd940327b28b';

  TokenModel? _axsModel;

  TokenModel? get axsModel => _axsModel;

  set axsModel(TokenModel? value) {
    _axsModel = value;
    notifyListeners();
  }

  Future<void> _getWETHPrice() async {
    ETHModel? ethModel = await tokenRequest.getETHPrice();
    if (ethModel != null) {
      double ethPrice = double.parse(ethModel.data?.ethPrice ?? '1');
      TokenModel? tokenModel = await tokenRequest.getTokenInformation(
          token: WETH);
      if (tokenModel != null) {
        double stableTokenPrice = double.parse(tokenModel.derivedETH ?? '1') *
            ethPrice;
        WETHCurrentPrice = stableTokenPrice;
        print('WETHPrice:  $WETHCurrentPrice');
      }
    }
  }

  Future<TokenModel?> getTokenInfo() async {
    axsModel = await tokenRequest.getTokenInformation(token: AXS);
  }

  Future<void> listenContract() async {
    await _getWETHPrice();
    await ContractClient(contractLocator: contractLocator).listenContract((value) {
      if (value != null && axsModel != null) {
        axsModel?.price = value * WETHCurrentPrice;
        print('AXS Price: ${axsModel?.price}');
        notifyListeners();
      }
    }, token: AXS, decimals: axsModel?.getDecimalsInt() ?? 0);
  }

  @override
  void resetState() {

  }
}