
import 'package:http/http.dart' as http;
import 'package:test_api_login/lib/models/patient_model.dart';


class PatientService {
  Future<List<Patient>?> getData() async {
    const token='eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxODA1NjA4NDY0LCJpYXQiOjE3MTkyMDg0NjQsImp0aSI6ImUyMDY1YWZiMDdlZjQ0OGFhYzA2OTM0NmMxM2Y4MzlkIiwidXNlcl9pZCI6MjF9.kSj-HMWbj9AFnvTmRrgViyuhP9lRaL5bxbk1Y0wlaI4';

    try {
      var headers = {
        'Authorization': 'Bearer $token',
      };
      var request = http.MultipartRequest(
          'GET', Uri.parse('https://flutter-amr.noviindus.in/api/PatientList'));
      request.fields.addAll({'username': 'test_user', 'password': '12345678'});
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        PatientModel patientModel = patientModelFromJson(responseBody);
        return patientModel.patient;
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e.toString());
    }
    return [];
  }
}