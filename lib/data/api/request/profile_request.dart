import 'dart:ffi';

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
      print("Error: failed to fetch user profile => ${result.exception.graphqlErrors}");
      return null;
    }
    print(result.data);
    final Map<String, dynamic> data = result.data;
    Map<String, dynamic> characterJSON = data["character"];
    CharacterModel character = CharacterModel.fromJson(characterJSON);
    return character;
  }
}