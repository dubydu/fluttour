import 'package:fluttour/data/api/api_client.dart';
import 'package:fluttour/domain/models/eth_model.dart';
import 'package:fluttour/domain/models/token_model.dart';

class TokenRequest extends GraphQLAPIClient {
  Future<ETHModel?> getETHPrice() async {
    /// Query
    String query = '''
    query {
      bundle(id: "1" ) {
        ethPriceUSD
      }
    }
    ''';
    final result = await this.v2_query(query);
    if (result.hasException) {
      handleException(result);
      return null;
    }
    final Map<String, dynamic>? data = result.data;
    ETHModel ethModel = ETHModel.fromJson(data ?? Map());
    return ethModel;
  }

  Future<TokenModel?> getTokenInformation({required String token}) async {
    /// Query
    String query = '''
    query {
       token(id: "$token"){
         name
         symbol
         decimals
         derivedETH
       }
    }
    ''';
    final result = await this.v2_query(query);
    if (result.hasException) {
      handleException(result);
      return null;
    }
    final tokenResult = result.data?['token'] as Map<String, dynamic>;
    TokenModel tokenModel = TokenModel.fromJson(tokenResult);
    return tokenModel;
  }
}