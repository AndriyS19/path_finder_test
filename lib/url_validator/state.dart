import 'package:path_finder/model/path_grd_data.dart';

enum ResponseStatus {
  initial,
  loading,
  success,
  error,
}

class APIURLCheckerState {
  final String urlAPI;
  final String errorMessage;
  final ResponseStatus responseStatus;
  final List<PathGridData> gridData;

  APIURLCheckerState({
    required this.urlAPI,
    required this.errorMessage,
    required this.responseStatus,
    required this.gridData,
  });

  APIURLCheckerState.initial()
      : urlAPI = '',
        responseStatus = ResponseStatus.initial,
        gridData = [],
        errorMessage = '';

  bool get isNextStepAvailable => responseStatus == ResponseStatus.success;
  bool get isButtonAvailable => !isLoading && !isError;

  bool get isLoading => responseStatus == ResponseStatus.loading;
  bool get isError => responseStatus == ResponseStatus.error;
  bool get isSuccess => responseStatus == ResponseStatus.success;
}
