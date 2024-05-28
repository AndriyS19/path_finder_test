import 'package:path_finder/model/coordinate.dart';

class PathTask {
  final String id;
  final List<List<String>> field;
  final Coordinate start;
  final Coordinate end;

  PathTask({
    required this.id,
    required this.field,
    required this.start,
    required this.end,
  });

  factory PathTask.fromJson(Map<String, dynamic> json) {
    List<List<String>> parsedField = json['field'].map<List<String>>((row) => row.split('')).toList();

    return PathTask(
      id: json['id'],
      field: parsedField,
      start: Coordinate.fromJson(json['start']),
      end: Coordinate.fromJson(json['end']),
    );
  }
}
