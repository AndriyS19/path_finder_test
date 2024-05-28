import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_finder/constants/colors.dart';
import 'package:path_finder/screen/counting_process.dart';
import 'package:path_finder/url_validator/cubit.dart';
import 'package:path_finder/url_validator/state.dart';

class URLInputScreen extends StatefulWidget {
  const URLInputScreen({super.key});

  @override
  State<URLInputScreen> createState() => _URLInputScreenState();
}

class _URLInputScreenState extends State<URLInputScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        elevation: 0,
        title: const Text(
          'Home screen',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<APIURLCheckerCubit, APIURLCheckerState>(
        listener: (context, state) {
          if (state.isSuccess) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const CountingProcessScreen(),
              ),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Set a valid API URL to continue',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.swap_horiz,
                        size: 26,
                      ),
                      const SizedBox(width: 18),
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            labelText: 'Input URL',
                            border: UnderlineInputBorder(),
                          ),
                          keyboardType: TextInputType.url,
                          onChanged: (url) {
                            context.read<APIURLCheckerCubit>().enterURL(url);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                if (state.isError)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      state.errorMessage,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: ElevatedButton(
                    onPressed: state.isButtonAvailable
                        ? () {
                            context.read<APIURLCheckerCubit>().saveAndTestURL();
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
                            'Start counting process',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              color: Colors.black87,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }
}
