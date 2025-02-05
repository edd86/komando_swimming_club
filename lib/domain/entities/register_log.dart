class RegisterLog {
  int? id;
  String dateLogin;
  String dateLogout;
  bool isLogged;
  int userId;

  RegisterLog({
    this.id,
    required this.dateLogin,
    required this.dateLogout,
    required this.isLogged,
    required this.userId,
  });
}