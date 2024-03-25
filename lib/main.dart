/// Import necessary packages and files
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// For input formatters
import 'package:get/get.dart';

/// For navigation
import 'information_screen.dart';

/// Importing another Dart file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: InputScreen(),

      /// Setting InputScreen as the home screen
    );
  }
}

/// InputScreen class, defining the input form for blood pressure
class InputScreen extends StatelessWidget {
  /// Text editing controllers for systolic and diastolic input fields
  final TextEditingController systolicController = TextEditingController();
  final TextEditingController diastolicController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    /// Scaffold widget for basic layout structure
    return Scaffold(
      appBar: AppBar(
        title: Text('Blood Pressure Monitor'),
        backgroundColor: Color.fromARGB(255, 145, 3, 3),

        /// Custom background color
        foregroundColor: Colors.white,

        /// Text color
      ),
      backgroundColor: Color.fromARGB(255, 241, 216, 216), // Background color
      body: Padding(
        padding: const EdgeInsets.all(16.0),

        /// Column
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 1),

            /// Spacer
            Image.asset(
              'assets/image1.png',

              /// Image asset
              width: 300,
              height: 200,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 1),

            /// Spacer
            /// Text form field for systolic input
            TextFormField(
              controller: systolicController,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(3),
              ],
              decoration: InputDecoration(
                labelText: 'Systolic (40-180) mm Hg',
                suffixText: 'mm Hg',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              textInputAction: TextInputAction.next,
              onEditingComplete: () => FocusScope.of(context).nextFocus(),
              autofocus: true,
            ),
            SizedBox(height: 10),

            /// Spacer
            /// Text form field for diastolic input
            TextFormField(
              controller: diastolicController,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(3),
              ],
              decoration: InputDecoration(
                labelText: 'Diastolic (40-120) mm Hg',
                suffixText: 'mm Hg',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              textInputAction: TextInputAction.done,
              onEditingComplete: () => _submit(context),
            ),
            SizedBox(height: 20),

            /// Spacer
            /// Elevated button to submit blood pressure values
            ElevatedButton(
              onPressed: () => _submit(context),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromARGB(255, 128, 18, 10),
                ),
                foregroundColor: MaterialStateProperty.all<Color>(
                  Colors.white,
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              child: Text('Show Info'),

              /// Button text
            ),
          ],
        ),
      ),
    );
  }

  /// Function to submit blood pressure values and navigate to InformationScreen
  void _submit(BuildContext context) {
    final systolic = double.tryParse(systolicController.text);
    final diastolic = double.tryParse(diastolicController.text);

    /// Check if input values are valid
    if (systolic != null &&
        systolic >= 40 &&
        systolic <= 180 &&
        diastolic != null &&
        diastolic >= 40 &&
        diastolic <= 120) {
      /// Navigate to InformationScreen with blood pressure values
      Get.to(InformationScreen(
        systolic: systolic,
        diastolic: diastolic,
      ));
    } else {
      /// Show error dialog for invalid input values
      Get.defaultDialog(
        title: 'Error',
        middleText:
            'Please enter valid blood pressure values (Systolic: 40-180 mm Hg, Diastolic: 40-120 mm Hg).',
      );
    }
  }
}
