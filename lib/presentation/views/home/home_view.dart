import 'package:flutter/material.dart';
import 'package:media_care/presentation/views/Doctor%20Speciality/DocSpeciality.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Hello MediCare",
              style: TextStyle(fontSize: 50),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DoctorSpecialityScreen(),
                    ));
              },
              child: Text('Go To Doctor Speciality Screen >>'),
              style: ButtonStyle(
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                backgroundColor: WidgetStatePropertyAll(Colors.cyan),
              ),
            )
          ],
        ),
      ),
    );
  }
}
