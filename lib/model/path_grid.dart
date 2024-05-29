import 'package:path_finder/model/coordinate.dart';

class PathGrid {
  List<List<String>> field;
  List<Coordinate> accessibleNeighbors = [];

  PathGrid(this.field);

  bool isObstacle(Coordinate point) {
    return field[point.yCoordinate][point.xCoordinate] == 'X';
  }

  bool isWithinBounds(Coordinate point) {
    return point.xCoordinate >= 0 &&
        point.yCoordinate >= 0 &&
        point.xCoordinate < field[0].length &&
        point.yCoordinate < field.length;
  }

  List<Coordinate> findAccessibleNeighbors(Coordinate point) {
    List<Coordinate> directions = [
      Coordinate(1, 0),
      Coordinate(-1, 0),
      Coordinate(0, 1),
      Coordinate(0, -1),
      Coordinate(1, 1),
      Coordinate(-1, -1),
      Coordinate(1, -1),
      Coordinate(-1, 1)
    ];

    for (Coordinate dir in directions) {
      Coordinate newPoint = Coordinate(
        point.xCoordinate + dir.xCoordinate,
        point.yCoordinate + dir.yCoordinate,
      );
      if (isWithinBounds(newPoint) && !isObstacle(newPoint)) {
        accessibleNeighbors.add(newPoint);
      }
    }
    return accessibleNeighbors;
  }
}
