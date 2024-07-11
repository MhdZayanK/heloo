import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_api_login/lib/models/Usermodel.dart';


class AuthService {
  final client = http.Client();

  Future<LoginModel?> login(
      {required String username, required String password}) async {
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('https://flutter-amr.noviindus.in/api/Login'));
      request.fields.addAll({'username': username, 'password': password});

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        Map<String, dynamic> json = jsonDecode(responseBody);
        LoginModel login = LoginModel.fromJson(json);
        print("response $responseBody");
        return login;
      } else {
        print('Error ${response.reasonPhrase}');
        return null;
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
