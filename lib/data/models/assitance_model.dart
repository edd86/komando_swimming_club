class AssitanceModel {
  int? id;
  String date;
  String obs;
  String state;
  int studentId;
  int proffesorId;

  AssitanceModel({
    this.id,
    required this.date,
    required this.obs,
    required this.state,
    required this.studentId,
    required this.proffesorId,
  });

  factory AssitanceModel.fromJson(Map<String, dynamic> json) {
    return AssitanceModel(
      id: json['id'],
      date: json['date'],
      obs: json['obs'],
      state: json['estado'],
      studentId: json['alumnoId'],
      proffesorId: json['profesorId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'obs': obs,
      'estado': state,
      'alumnoId': studentId,
      'profesorId': proffesorId,
    };
  }
}