class RegisterLogModel {
  int? id;
  String dateLogin;
  String dateLogout;
  bool isLogged;
  int userId;

  RegisterLogModel({
    this.id,
    required this.dateLogin,
    required this.dateLogout,
    required this.isLogged,
    required this.userId,
  });

  factory RegisterLogModel.fromJson(Map<String, dynamic> json) {
    return RegisterLogModel(
      id: json['id'],
      dateLogin: json['dateLogin'],
      dateLogout: json['dateLogout'],
      isLogged: json['isLogged'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dateLogin': dateLogin,
      'dateLogout': dateLogout,
      'isLogged': isLogged,
      'userId': userId,
    };
  }
}
