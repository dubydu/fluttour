import 'package:fluttour/data/api/api_client.dart';
import 'package:fluttour/domain/models/character_model.dart';

class ProfileRequest extends GraphQLAPIClient {

  Future<CharacterModel?> getProfile({required String id}) async {
    /// Query
    String fetchProfile = """
      query {
            character(where: {id: "$id" }) {
              name, email, password, id
            }
        }
    """;
    final result = await this.execute(fetchProfile);
    if (result.hasException) {
      handleException(result);
      return null;
    }
    final Map<String, dynamic> data = result.data;
    Map<String, dynamic> characterJSON = data["character"];
    CharacterModel character = CharacterModel.fromJson(characterJSON);
    return character;
  }

  Future<CharacterModel?> editProfile({required String id, required String email, required String name}) async {
    String updateProfile = """
    mutation {
      updateCharacter(
        where: {id: "$id" }, 
        data: {
          email: "$email",
          name: "$name"
        }) {
        name, password, email, id
      }
    }
    """;
    final result = await this.execute(updateProfile);
    if (result.hasException) {
      handleException(result);
      return null;
    }
    final Map<String, dynamic> data = result.data;
    Map<String, dynamic> characterJSON = data["updateCharacter"];
    CharacterModel character = CharacterModel.fromJson(characterJSON);
    return character;
  }
}