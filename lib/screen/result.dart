import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_finder/constants/colors.dart';
import 'package:path_finder/shortest_path_finder/cubit.dart';
import 'package:path_finder/shortest_path_finder/state.dart';
import 'package:path_finder/screen/path_preview.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        elevation: 0,
        title: const Text(
          'Result list screen',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<ShortestPathCubit, ShortestPathState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.pathResults.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PathPreviewScreen(
                            gridData: state.gridDataList[index],
                            pathResult: state.pathResults[index],
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Center(
                        child: Text(state.pathResults[index].pathDescription),
                      ),
                    ),
                  ),
                  const Divider(),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
