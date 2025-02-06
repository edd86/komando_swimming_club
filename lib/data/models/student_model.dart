class StudentModel {
  int? id;
  String name;
  int age;
  String phone;
  DateTime dateOfBirth;
  DateTime dateOfRegister;
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
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      dateOfRegister: DateTime.parse(json['dateOfRegister']),
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
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'dateOfRegister': dateOfRegister.toIso8601String(),
      'obs': obs,
      'ppff': ppff,
      'profesorId': profesorId,
    };
  }

  StudentModel copyWith({
    int? id,
    String? name,
    int? age,
    String? phone,
    DateTime? dateOfBirth,
    DateTime? dateOfRegister,
    String? obs,
    String? ppff,
    int? profesorId,
  }) {
    return StudentModel(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      phone: phone ?? this.phone,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      dateOfRegister: dateOfRegister ?? this.dateOfRegister,
      obs: obs ?? this.obs,
      ppff: ppff ?? this.ppff,
      profesorId: profesorId ?? this.profesorId,
    );
  }
}
