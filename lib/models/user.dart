class User {
  String name;
  int apartment;
  String token;

  User({required this.name, required this.apartment, required this.token});

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
        name: responseData['name'],
        apartment: responseData['apartment'],
        token: responseData['token']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'apartment': apartment,
      'token': token
    };
  }
}