import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_api_login/lib/models/patient_model.dart';
import 'package:test_api_login/lib/service/patientList_service.dart';
import 'package:test_api_login/lib/service/register.dart';

class Patient_list extends StatefulWidget {
  const Patient_list({super.key});

  @override
  State<Patient_list> createState() => _Patient_listState();
}

class _Patient_listState extends State<Patient_list> {
  @override
  Widget build(BuildContext context) {
      final patientProvider = Provider.of<PatientProvider>(context);
    return  Scaffold(
      appBar: AppBar(
        title: Text('Patients'),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>register()));
    }, icon: Icon(Icons.arrow_forward))
        ],
      ),
      body: FutureBuilder<List<Patient>?>(
        future: patientProvider.getPatients(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No patients found'));
          } else {
            final patients = snapshot.data!;
            return ListView.builder(
              itemCount: patients.length,
              itemBuilder: (context, index) {
                final patient = patients[index];
                return ListTile(
                  title: Text(patient.name ?? 'No name'),
                  subtitle: Text(patient.dateNdTime != null
                      ? patient.dateNdTime!.toLocal().toString()
                      : 'No date'),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class PatientProvider with ChangeNotifier {
  final PatientService _patientService = PatientService();

  Future<List<Patient>?> getPatients() async {
    return await _patientService.getData();
  }
}
