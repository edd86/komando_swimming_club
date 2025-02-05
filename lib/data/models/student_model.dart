class StudentModel {
  int? id;
  String name;
  int age;
  String phone;
  String dateOfBirth;
  String dateOfRegister;
  String obs;
  String ppff;
  int profesorId;

  StudentModel({
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

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json['id'],
      name: json['name'],
      age: json['edad'],
      phone: json['phone'],
      dateOfBirth: json['dateOfBirth'],
      dateOfRegister: json['dateOfRegister'],
      obs: json['obs'],
      ppff: json['ppff'],
      profesorId: json['profesorId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'edad': age,
      'phone': phone,
      'dateOfBirth': dateOfBirth,
      'dateOfRegister': dateOfRegister,
      'obs': obs,
      'ppff': ppff,
      'profesorId': profesorId,
    };
  }
}
