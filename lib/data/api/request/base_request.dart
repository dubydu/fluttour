import 'package:fluttour/data/api/api_client.dart';

class BaseRequest extends GraphQLAPIClient {
  /// Move character object from Draft to Publish stage
  Future<void> publishCharacter({required String id}) async {
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
    final result = await this.execute(publishCharacter);
    if (result.hasException) {
      print("Error: failed to publish user profile => ${result.exception.graphqlErrors}");
      return;
    }
  }
}