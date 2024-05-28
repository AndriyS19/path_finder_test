import 'package:path_finder/model/shortest_path_result.dart';
import 'package:path_finder/url_validator/state.dart';

class SendResultState {
  final String urlAPI;
  final String informMessage;
  final ResponseStatus responseStatus;
  final List<ShortestPathResult> resultData;

  const SendResultState({
    required this.urlAPI,
    required this.responseStatus,
    required this.resultData,
    required this.informMessage,
  });

  SendResultState.initial()
      : urlAPI = '',
        responseStatus = ResponseStatus.initial,
        informMessage = '',
        resultData = [];

  bool get isLoading => responseStatus == ResponseStatus.loading;
}
