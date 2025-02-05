class Proffesor {
  int? id;
  String name;
  int age;
  String phone;
  DateTime dateOfBirth;
  DateTime beginDate;
  String? obs;

  Proffesor({
    this.id,
    required this.name,
    required this.age,
    required this.phone,
    required this.dateOfBirth,
    required this.beginDate,
    this.obs,
  });
}