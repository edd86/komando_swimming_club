class UserModel {
  int? id;
  String name;
  String phone;
  String userName;
  String password;

  UserModel({
    this.id,
    required this.name,
    required this.phone,
    required this.userName,
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      userName: json['userName'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'userName': userName,
      'password': password,
    };
  }

  UserModel copyWith({
    int? id,
    String? name,
    String? phone,
    String? userName,
    String? password,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      userName: userName ?? this.userName,
      password: password ?? this.password,
    );
  }
}
