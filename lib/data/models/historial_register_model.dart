class HistorialRegisterModel {
  int? id;
  DateTime date;
  String action;
  int userId;
  int? profesorId;
  int? studentId;
  int? ingressId;
  int? egressId;

  HistorialRegisterModel({
    this.id,
    required this.date,
    required this.action,
    required this.userId,
    this.profesorId,
    this.studentId,
    this.ingressId,
    this.egressId,
  });

  factory HistorialRegisterModel.fromJson(Map<String, dynamic> json) {
    return HistorialRegisterModel(
      id: json['id'],
      date: DateTime.parse(json['fecha']),
      action: json['action'],
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
      'fecha': date.toIso8601String(),
      'action': action,
      'userId': userId,
      'profesorId': profesorId,
      'alumnoId': studentId,
      'ingresoId': ingressId,
      'egresoId': egressId,
    };
  }

  HistorialRegisterModel copyWith({
    int? id,
    DateTime? date,
    String? action,
    int? userId,
    int? profesorId,
    int? studentId,
    int? ingressId,
    int? egressId,
  }) {
    return HistorialRegisterModel(
      id: id ?? this.id,
      date: date ?? this.date,
      action: action ?? this.action,
      userId: userId ?? this.userId,
      profesorId: profesorId ?? this.profesorId,
      studentId: studentId ?? this.studentId,
      ingressId: ingressId ?? this.ingressId,
      egressId: egressId ?? this.egressId,
    );
  }
}
