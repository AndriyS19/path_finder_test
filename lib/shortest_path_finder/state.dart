import 'package:path_finder/model/path_grd_data.dart';
import 'package:path_finder/model/shortest_path_result.dart';

class ShortestPathState {
  final double calculationProgress;
  final List<PathGridData> gridDataList;
  final List<ShortestPathResult> pathResults;

  const ShortestPathState({
    required this.gridDataList,
    required this.pathResults,
    required this.calculationProgress,
  });

  ShortestPathState.initial()
      : gridDataList = [],
        calculationProgress = 0,
        pathResults = [];

  String get informMessage {
    if (calculatingFinish) {
      return 'All calculations has finished, you can send your results to server';
    } else {
      return 'Calculating...';
    }
  }

  bool get calculatingFinish => calculationProgress == 100;
}
