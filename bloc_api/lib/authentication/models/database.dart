import 'package:bloc_api/database/fields.dart';

class MyDatabase {
  int? id;
  DateTime? timeDate;
  String? nitrogen;
  String? phosphorus;
  String? potassium;
  double? soilMoisture;
  List<DateTime>? timeDateList;

  MyDatabase(
      {this.id,
      this.timeDate,
      this.nitrogen,
      this.phosphorus,
      this.potassium,
      this.soilMoisture,
      this.timeDateList});

  MyDatabase copy({
    int? id,
    DateTime? timeDate,
    String? nitrogen,
    String? phosphorus,
    String? potassium,
    double? soilMoisture,
    List<DateTime>? timeDateList,
  }) =>
      MyDatabase(
        id: id ?? this.id,
        timeDate: timeDate ?? this.timeDate,
        nitrogen: nitrogen ?? this.nitrogen,
        phosphorus: phosphorus ?? this.phosphorus,
        potassium: potassium ?? this.potassium,
        soilMoisture: soilMoisture ?? this.soilMoisture,
        timeDateList: timeDateList ?? this.timeDateList,
      );

  static MyDatabase fromJson(Map<String, Object?> json) => MyDatabase(
        id: json[NoteFields.id] as int?,
        timeDate: DateTime.parse(json[NoteFields.timeDate] as String),
        nitrogen: json[NoteFields.nitrogen] as String,
        phosphorus: json[NoteFields.phosphorus] as String,
        potassium: json[NoteFields.potassium] as String,
        soilMoisture: json[NoteFields.soilMoisture] as double,
        timeDateList: json[NoteFields.timeDateList] as List<DateTime>,
      );

  Map<String, Object?> toJson() => {
        NoteFields.id: id,
        NoteFields.timeDate: timeDate?.toIso8601String(),
        NoteFields.nitrogen: nitrogen,
        NoteFields.phosphorus: phosphorus,
        NoteFields.potassium: potassium,
        NoteFields.soilMoisture: soilMoisture,
        NoteFields.timeDateList: timeDateList,
      };
}
