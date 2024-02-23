class User {
  int? id;
  String name;
  String phoneNumber;
  String gender;

  User({this.id, required this.name, required this.phoneNumber, required this.gender});

  factory User.fromMap(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['number'],
      gender: json['gender'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'number': phoneNumber,
      'gender': gender,
    };
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, number: $phoneNumber, gender: $gender}';
  }
}
