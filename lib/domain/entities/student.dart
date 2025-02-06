class Student {
  int? id;
  String name;
  int age;
  String phone;
  DateTime dateOfBirth;
  DateTime dateOfRegister;
  String obs;
  String ppff;
  int profesorId;

  Student({
    this.id,
    required this.name,
    required this.age,
    required this.phone,
    required this.dateOfBirth,
    required this.dateOfRegister,
    required this.obs,
    required this.ppff,
    required this.profesorId,
  });
}
