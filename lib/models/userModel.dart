class UserModel {
  String id;
  String email;
  String name;
  int age;

  UserModel(
      {required this.id,
      required this.email,
      required this.name,
      required this.age});

  UserModel.fromJason(Map<String, dynamic> jason)
      : this(
          id: jason["id"],
          email: jason["email"],
          name: jason["name"],
          age: jason["age"],
        );

  Map<String, dynamic> toJason() {
    return {
      "id": id,
      "email": email,
      "name": name,
      "age": age,
    };
  }
}
