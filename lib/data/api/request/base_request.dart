import 'package:fluttour/data/api/api_client.dart';

class BaseRequest extends GraphQLAPIClient {
  /// Move character object from Draft to Publish stage
  Future<bool> publishCharacter({required String id}) async {
    /// Query
    String publishCharacter = """
      mutation {
        publishCharacter(where: {
          id: "$id"
        }, to: PUBLISHED) {
          id
        }
      }
    """;
    final result = await this.query(publishCharacter);
    if (result.hasException) {
      handleException(result);
      return false;
    }
    return true;
  }
}