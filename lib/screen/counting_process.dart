import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_finder/constants/colors.dart';
import 'package:path_finder/model/shortest_path_result.dart';
import 'package:path_finder/shortest_path_finder/cubit.dart';
import 'package:path_finder/shortest_path_finder/state.dart';
import 'package:path_finder/screen/result.dart';
import 'package:path_finder/send_result/cubit.dart';
import 'package:path_finder/send_result/state.dart';
import 'package:path_finder/url_validator/cubit.dart';
import 'package:path_finder/url_validator/state.dart';

class CountingProcessScreen extends StatefulWidget {
  const CountingProcessScreen({super.key});

  @override
  State<CountingProcessScreen> createState() => _CountingProcessScreenState();
}

class _CountingProcessScreenState extends State<CountingProcessScreen> {
  @override
  void initState() {
    context.read<ShortestPathCubit>().beginPathFinding(context.read<APIURLCheckerCubit>().state.gridData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        elevation: 0,
        title: const Text(
          'Process screen',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<ShortestPathCubit, ShortestPathState>(
          builder: (context, state) {
            var pathFinderCubit = context.read<ShortestPathCubit>().state;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    child: Text(
                      state.informMessage,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Text('${state.calculationProgress.toStringAsFixed(2)}%'),
                const SizedBox(height: 16),
                SizedBox(
                  height: 145,
                  width: 145,
                  child: CircularProgressIndicator(
                    value: state.calculationProgress / 100,
                    color: Colors.blue,
                    strokeWidth: 12,
                  ),
                ),
                const Spacer(),
                button(pathFinderCubit),
                const SizedBox(height: 40)
              ],
            );
          },
        ),
      ),
    );
  }

  BlocConsumer<SendResultCubit, SendResultState> button(ShortestPathState pathFinderCubit) {
    return BlocConsumer<SendResultCubit, SendResultState>(
      listener: (context, state) {
        if (state.responseStatus == ResponseStatus.success) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const ResultScreen(),
            ),
          );
        }
      },
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: context.read<ShortestPathCubit>().state.calculatingFinish && !state.isLoading
                ? () {
                    List<ShortestPathResult> resultData = pathFinderCubit.pathResults;
                    String url = context.read<APIURLCheckerCubit>().state.urlAPI;
                    context.read<SendResultCubit>().sendResults(resultData, url);
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: state.isLoading
                ? const CircularProgressIndicator(
                    color: Colors.blue,
                  )
                : const Text(
                    'Send result to server',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
