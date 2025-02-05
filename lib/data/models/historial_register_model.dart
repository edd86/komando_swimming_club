class HistorialRegisterModel {
  int? id;
  String date;
  int userId;
  int? profesorId;
  int? studentId;
  int? ingressId;
  int? egressId;

  HistorialRegisterModel({
    this.id,
    required this.date,
    required this.userId,
    this.profesorId,
    this.studentId,
    this.ingressId,
    this.egressId,
  });

  factory HistorialRegisterModel.fromJson(Map<String, dynamic> json) {
    return HistorialRegisterModel(
      id: json['id'],
      date: json['date'],
      userId: json['userId'],
      profesorId: json['profesorId'],
      studentId: json['alumnoId'],
      ingressId: json['ingresoId'],
      egressId: json['egresoId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'userId': userId,
      'profesorId': profesorId,
      'alumnoId': studentId,
      'ingresoId': ingressId,
      'egresoId': egressId,
    };
  }
}