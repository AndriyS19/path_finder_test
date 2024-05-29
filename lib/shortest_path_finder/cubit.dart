import 'dart:async';
import 'dart:isolate';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_finder/model/path_grid.dart';
import 'package:path_finder/model/path_grd_data.dart';
import 'package:path_finder/model/shortest_path_result.dart';
import 'package:path_finder/model/coordinate.dart';
import 'package:path_finder/shortest_path_finder/state.dart';
import 'package:path_finder/utils/path_finder.dart';

class ShortestPathCubit extends Cubit<ShortestPathState> {
  ShortestPathCubit() : super(ShortestPathState.initial());

  void beginPathFinding(List<PathGridData> gridDataList) async {
    final receivePort = ReceivePort();
    final completer = Completer<SendPort>();

    receivePort.listen((data) {
      if (data is SendPort) {
        completer.complete(data);
      } else if (data is List<ShortestPathResult>) {
        emit(ShortestPathState(
          gridDataList: gridDataList,
          pathResults: data,
          calculationProgress: 100,
        ));
        receivePort.close();
      } else if (data is double) {
        emit(ShortestPathState(
          gridDataList: state.gridDataList,
          pathResults: state.pathResults,
          calculationProgress: data,
        ));
      }
    });

    await Isolate.spawn(_pathFindingIsolate, receivePort.sendPort);

    final sendPort = await completer.future;
    sendPort.send([gridDataList, receivePort.sendPort]);
  }

  static void _pathFindingIsolate(SendPort sendPort) async {
    final receivePort = ReceivePort();
    sendPort.send(receivePort.sendPort);

    await for (final message in receivePort) {
      final grids = message[0] as List<PathGridData>;
      final responsePort = message[1] as SendPort;

      List<ShortestPathResult> results = [];
      int counter = 0;
      for (PathGridData gridData in grids) {
        counter++;
        PathGrid grid = PathGrid(gridData.field);
        PathFinder finder = PathFinder(grid);
        List<Coordinate> path = finder.findPath(gridData.start, gridData.end);
        String formattedPath = path.map((p) => p.toString()).join('->');
        results.add(
          ShortestPathResult(
            pathId: gridData.id,
            pathSteps: path,
            pathDescription: formattedPath,
          ),
        );
        responsePort.send(
          counter * 100 / grids.length,
        );
      }
      responsePort.send(results);
    }
  }
}
