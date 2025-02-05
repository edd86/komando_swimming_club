class ProffesorModel {
  int? id;
  String name;
  int age;
  String phone;
  DateTime dateOfBirth;
  DateTime beginDate;
  String? obs;

  ProffesorModel({
    this.id,
    required this.name,
    required this.age,
    required this.phone,
    required this.dateOfBirth,
    required this.beginDate,
    this.obs,
  });

  factory ProffesorModel.fromJson(Map<String, dynamic> json) {
    return ProffesorModel(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      phone: json['phone'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      beginDate: DateTime.parse(json['beginDate']),
      obs: json['obs'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'phone': phone,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'beginDate': beginDate.toIso8601String(),
      'obs': obs,
    };
  }

  ProffesorModel copyWith({
    int? id,
    String? name,
    int? age,
    String? phone,
    DateTime? dateOfBirth,
    DateTime? beginDate,
    String? obs,
  }) {
    return ProffesorModel(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      phone: phone ?? this.phone,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      beginDate: beginDate ?? this.beginDate,
      obs: obs ?? this.obs,
    );
  }
}
