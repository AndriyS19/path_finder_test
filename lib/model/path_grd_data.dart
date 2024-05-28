import 'package:path_finder/model/coordinate.dart';

class PathGridData {
  String id;
  List<List<String>> field;
  Coordinate start;
  Coordinate end;

  PathGridData(
    this.id,
    this.field,
    this.start,
    this.end,
  );

  factory PathGridData.fromJson(Map<String, dynamic> json) {
    List<List<String>> field = (json['field'] as List<dynamic>).map((row) => (row as String).split('')).toList();
    return PathGridData(
      json['id'],
      field,
      Coordinate.fromJson(json['start']),
      Coordinate.fromJson(json['end']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'field': field.map((row) => row.join('')).toList(),
      'start': start.toJson(),
      'end': end.toJson(),
    };
  }
}
