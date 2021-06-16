import 'package:fluttour/data/api/api_client.dart';
import 'package:fluttour/domain/models/character_model.dart';

class SignupRequest extends GraphQLAPIClient {
  Future<CharacterModel?> signup(CharacterModel request) async {
    /// Query
    String mutationCharacter = """
      mutation {
          createCharacter(data: {
            name: "${request.name}"
            password: "${request.password}"
            email: "${request.email}"
          }) {
            name, password, email, id
          }
        }
    """;
    final result = await this.execute(mutationCharacter);
    if (result.hasException) {
      handleException(result);
      return null;
    }
    final Map<String, dynamic> data = result.data;
    Map<String, dynamic> characterJSON = data["createCharacter"];
    CharacterModel character = CharacterModel.fromJson(characterJSON);
    return character;
  }
}