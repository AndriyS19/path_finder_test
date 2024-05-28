import 'dart:collection';

import 'package:path_finder/model/path_grid.dart';
import 'package:path_finder/model/coordinate.dart';

class PathFinder {
  PathGrid grid;

  PathFinder(this.grid);

  List<Coordinate> findPath(Coordinate start, Coordinate end) {
    Queue<List<Coordinate>> queue = Queue<List<Coordinate>>();
    queue.add([start]);
    Set<Coordinate> visited = {start};

    while (queue.isNotEmpty) {
      List<Coordinate> path = queue.removeFirst();
      Coordinate current = path.last;
      if (current == end) {
        return path;
      }

      for (Coordinate neighbor in grid.findAccessibleNeighbors(current)) {
        if (!visited.contains(neighbor)) {
          visited.add(neighbor);
          queue.add(List<Coordinate>.from(path)..add(neighbor));
        }
      }
    }

    return [];
  }
}
