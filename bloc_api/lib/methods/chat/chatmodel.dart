import 'package:http/http.dart';

class ResponseModel {
  String? responseTxt;
  // final List<Map<String, dynamic>> choices;
  final Response response;
  ResponseModel({required this.response});

  factory ResponseModel.fromJson(Response response) {
    return ResponseModel(response: response);
  }
}
