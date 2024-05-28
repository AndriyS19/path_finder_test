import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_finder/shortest_path_finder/cubit.dart';
import 'package:path_finder/screen/url_input.dart';
import 'package:path_finder/send_result/cubit.dart';
import 'package:path_finder/url_validator/cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => APIURLCheckerCubit(),
        ),
        BlocProvider(
          create: (context) => ShortestPathCubit(),
        ),
        BlocProvider(
          create: (context) => SendResultCubit(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: URLInputScreen(),
      ),
    );
  }
}
