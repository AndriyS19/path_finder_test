import 'package:flutter/material.dart';
import 'package:path_finder/constants/colors.dart';
import 'package:path_finder/model/coordinate.dart';
import 'package:path_finder/model/path_grd_data.dart';
import 'package:path_finder/model/shortest_path_result.dart';

class PathPreviewScreen extends StatelessWidget {
  final PathGridData gridData;
  final ShortestPathResult pathResult;

  const PathPreviewScreen({
    super.key,
    required this.gridData,
    required this.pathResult,
  });

  @override
  Widget build(BuildContext context) {
    final pathPoints = Set<Coordinate>.from(pathResult.pathSteps);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        elevation: 0,
        title: const Text(
          'Path Preview',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: gridData.field[0].length,
        ),
        itemCount: gridData.field.length * gridData.field[0].length,
        itemBuilder: (BuildContext context, int index) {
          final y = index ~/ gridData.field[0].length;
          final x = index % gridData.field[0].length;
          final cell = gridData.field[y][x];
          final cellColor = _getColorForCell(x, y, cell, pathPoints, gridData);
          final textColor = _getColorForText(cell);
          return GridTile(
            child: Container(
              decoration: BoxDecoration(
                color: cellColor,
                border: Border.all(color: AppColors.gridBorderColor),
              ),
              child: Center(
                child: Text(
                  '( $x, $y )',
                  style: TextStyle(
                    color: textColor,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Color _getColorForCell(int x, int y, String cell, Set<Coordinate> pathPoints, PathGridData gridData) {
    if (Coordinate(x, y) == gridData.start) {
      return AppColors.startColor;
    }
    if (Coordinate(x, y) == gridData.end) {
      return AppColors.endColor;
    }
    if (cell == 'X') return AppColors.obstacleColor;
    if (pathPoints.contains(Coordinate(x, y))) {
      return AppColors.pathColor;
    }
    return AppColors.emptyCellColor;
  }

  Color _getColorForText(String cell) {
    return cell == 'X' ? Colors.white : Colors.black;
  }
}
