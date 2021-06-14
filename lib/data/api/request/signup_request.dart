import 'package:fluttour/data/api/api_client.dart';
import 'package:fluttour/domain/models/character_model.dart';

class SignupRequest extends GraphQLAPIClient {
  Future<CharacterModel?> signup(CharacterModel request) async {
    /// Query
    String fetchTickets = """
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
    final result = await this.execute(fetchTickets);
    if (result.hasException) {
      print("Sign up isError ${result.exception.graphqlErrors}");
      return null;
    }
    final Map<String, dynamic> data = result.data;
    Map<String, dynamic> characterJSON = data["createCharacter"];
    CharacterModel character = CharacterModel.fromJson(characterJSON);

    print(data);
    return character;
  }
}