import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:path_finder/model/path_grd_data.dart';
import 'package:path_finder/url_validator/state.dart';

class APIURLCheckerCubit extends Cubit<APIURLCheckerState> {
  APIURLCheckerCubit() : super(APIURLCheckerState.initial());

  void enterURL(String url) {
    emit(
      APIURLCheckerState(
        urlAPI: url,
        errorMessage: '',
        responseStatus: ResponseStatus.initial,
        gridData: [],
      ),
    );
  }

  void saveAndTestURL() async {
    emit(
      APIURLCheckerState(
        urlAPI: state.urlAPI,
        errorMessage: '',
        responseStatus: ResponseStatus.loading,
        gridData: [],
      ),
    );
    try {
      final response = await http.get(Uri.parse(state.urlAPI));

      if (response.statusCode == 200) {
        List<PathGridData> gridData = getGridData(response);
        if (gridData.isNotEmpty) {
          emit(
            APIURLCheckerState(
              urlAPI: state.urlAPI,
              errorMessage: '',
              responseStatus: ResponseStatus.success,
              gridData: gridData,
            ),
          );
        } else {
          emit(
            APIURLCheckerState(
              urlAPI: state.urlAPI,
              errorMessage: 'URL is not valid or data is empty',
              responseStatus: ResponseStatus.error,
              gridData: [],
            ),
          );
        }
      } else {
        emit(
          APIURLCheckerState(
            urlAPI: state.urlAPI,
            errorMessage: 'URL is unreachable, status code: ${response.statusCode}',
            responseStatus: ResponseStatus.error,
            gridData: [],
          ),
        );
      }
    } catch (e) {
      emit(
        APIURLCheckerState(
          urlAPI: state.urlAPI,
          errorMessage: 'Error: Could not reach the URL',
          responseStatus: ResponseStatus.error,
          gridData: [],
        ),
      );
    }
  }

  List<PathGridData> getGridData(http.Response response) {
    try {
      List<Map<String, dynamic>> dataset = List<Map<String, dynamic>>.from(json.decode(response.body)['data']);

      List<PathGridData> grids = dataset.map((data) => PathGridData.fromJson(data)).toList();

      return grids;
    } catch (e) {
      return [];
    }
  }
}
