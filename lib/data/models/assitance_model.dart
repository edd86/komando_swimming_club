class AssitanceModel {
  int? id;
  DateTime? dateIn;
  DateTime? dateOut;
  String? obs;
  String? state;
  int? studentId;
  int? proffesorId;

  AssitanceModel({
    this.id,
    this.dateIn,
    this.dateOut,
    this.obs,
    this.state,
    this.studentId,
    this.proffesorId,
  });

  factory AssitanceModel.fromJson(Map<String, dynamic> json) {
    return AssitanceModel(
      id: json['id'],
      dateIn: DateTime.parse(json['fecha_ingreso']),
      dateOut: json['fecha_salida'] == null
          ? null
          : DateTime.parse(json['fecha_salida']),
      obs: json['obs'],
      state: json['estado'],
      studentId: json['alumnoId'],
      proffesorId: json['profesorId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fecha_ingreso': dateIn?.toIso8601String(),
      'fecha_salida': dateOut?.toIso8601String(),
      'obs': obs,
      'estado': state,
      'alumnoId': studentId,
      'profesorId': proffesorId,
    };
  }

  AssitanceModel copyWith({
    int? id,
    DateTime? dateIn,
    DateTime? dateOut,
    String? obs,
    String? state,
    int? studentId,
    int? proffesorId,
  }) {
    return AssitanceModel(
      id: id ?? this.id,
      dateIn: dateIn ?? this.dateIn,
      dateOut: dateOut ?? this.dateOut,
      obs: obs ?? this.obs,
      state: state ?? this.state,
      studentId: studentId ?? this.studentId,
      proffesorId: proffesorId ?? this.proffesorId,
    );
  }
}
