import 'package:path_finder/model/coordinate.dart';

class ShortestPathResult {
  String pathId;
  List<Coordinate> pathSteps;
  String pathDescription;

  ShortestPathResult({
    required this.pathId,
    required this.pathSteps,
    required this.pathDescription,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': pathId,
      'result': {
        'steps': pathSteps.map((p) => p.toJson()).toList(),
        'path': pathDescription,
      },
    };
  }
}
