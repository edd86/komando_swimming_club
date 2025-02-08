class HistorialRegister {
  int? id;
  DateTime date;
  String action;
  int userId;
  int? profesorId;
  int? studentId;
  int? ingressId;
  int? egressId;

  HistorialRegister({
    this.id,
    required this.date,
    required this.action,
    required this.userId,
    this.profesorId,
    this.studentId,
    this.ingressId,
    this.egressId,
  });
}
