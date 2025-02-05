class ProffesorModel {
  int? id;
  String name;
  int age;
  String phone;
  String dateOfBirth;
  String beginDate;
  String obs;

  ProffesorModel({
    this.id,
    required this.name,
    required this.age,
    required this.phone,
    required this.dateOfBirth,
    required this.beginDate,
    required this.obs,
  });

  factory ProffesorModel.fromJson(Map<String, dynamic> json) {
    return ProffesorModel(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      phone: json['phone'],
      dateOfBirth: json['dateOfBirth'],
      beginDate: json['beginDate'],
      obs: json['obs'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'phone': phone,
      'dateOfBirth': dateOfBirth,
      'beginDate': beginDate,
      'obs': obs,
    };
  }
}