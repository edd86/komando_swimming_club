class HistorialRegister {
  int? id;
  String date;
  int userId;
  int? profesorId;
  int? studentId;
  int? ingressId;
  int? egressId;

  HistorialRegister({
    this.id,
    required this.date,
    required this.userId,
    this.profesorId,
    this.studentId,
    this.ingressId,
    this.egressId,
  });
}