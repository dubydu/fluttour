
class CharacterModel {
  CharacterModel({this.name,
    this.password,
    this.email,
    this.id});

  factory CharacterModel.fromJson(Map<String, dynamic> json) => CharacterModel (
    id: (json['id'] != null) ? json['id'] as String : null,
    name: (json['name'] != null) ? json['name'] as String : null,
    password: (json['password'] != null) ? json['password'] as String : null,
    email: (json['email'] != null) ? json['email'] as String : null,
  );

  final String? id;
  final String? name;
  final String? password;
  final String? email;

  Map<String, dynamic> toJson() => {
    "name": name,
    "password": password,
    "email": email
  };
}