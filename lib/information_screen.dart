//information_screen.dart
import 'package:flutter/material.dart';

class InformationScreen extends StatelessWidget {
  final double systolic;
  final double diastolic;

  const InformationScreen({
    Key? key,
    required this.systolic,
    required this.diastolic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String category = _getCategory(systolic, diastolic);

    List<DataRow> rows = [
      DataRow(
        cells: [
          DataCell(Text('LOW', style: TextStyle(fontWeight: FontWeight.bold))),
          DataCell(Text('40-90')),
          DataCell(Text('40-60')),
        ],
      ),
      DataRow(
        cells: [
          DataCell(
              Text('NORMAL', style: TextStyle(fontWeight: FontWeight.bold))),
          DataCell(Text('91-120')),
          DataCell(Text('61-80')),
        ],
      ),
      DataRow(
        cells: [
          DataCell(Text('PREHYPERTENSION',
              style: TextStyle(fontWeight: FontWeight.bold))),
          DataCell(Text('121-140')),
          DataCell(Text('81-90')),
        ],
      ),
      DataRow(
        cells: [
          DataCell(Text('STAGE 1 HYPERTENSION',
              style: TextStyle(fontWeight: FontWeight.bold))),
          DataCell(Text('141-160')),
          DataCell(Text('91-100')),
        ],
      ),
      DataRow(
        cells: [
          DataCell(Text('STAGE 2 HYPERTENSION',
              style: TextStyle(fontWeight: FontWeight.bold))),
          DataCell(Text('161-180')),
          DataCell(Text('101-120')),
        ],
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Blood Pressure Monitor'),
        backgroundColor: Color.fromARGB(255, 179, 12, 12),
        foregroundColor: Colors.white,
      ),
      backgroundColor: Color.fromARGB(255, 241, 216, 216),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text(
                'Systolic: $systolic mm Hg',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Diastolic: $diastolic mm Hg',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Category: $category',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 194, 17, 17)),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50),
              Text(
                'Blood Pressure Categories',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DataTable(
                  headingRowColor: MaterialStateColor.resolveWith(
                      (states) => Color.fromARGB(255, 134, 105, 105)!),
                  columns: [
                    DataColumn(
                        label: Text('Type',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('SYS',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('DIA',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                  rows: rows
                      .asMap()
                      .entries
                      .map((entry) => DataRow(
                          color: MaterialStateColor.resolveWith(
                              (states) => _getRowColor(category, entry.key)),
                          cells: entry.value.cells))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getCategory(double systolic, double diastolic) {
    if (systolic > 160 || diastolic > 100) {
      return 'Stage 2 Hypertension';
    } else if ((systolic >= 141 && systolic <= 160) ||
        (diastolic >= 91 && diastolic <= 100)) {
      return 'Stage 1 Hypertension';
    } else if ((systolic >= 121 && systolic <= 140) ||
        (diastolic >= 81 && diastolic <= 90)) {
      return 'Prehypertension';
    } else if ((systolic >= 91 && systolic <= 120) ||
        (diastolic >= 61 && diastolic <= 80)) {
      return 'Normal';
    } else {
      return 'Low';
    }
  }

  Color _getRowColor(String category, int index) {
    switch (category) {
      case 'Stage 2 Hypertension':
        if (index == 4) {
          return const Color.fromARGB(255, 175, 23, 13);
        }
        break;
      case 'Stage 1 Hypertension':
        if (index == 3) {
          return Color.fromARGB(255, 189, 32, 32);
        }
        break;
      case 'Prehypertension':
        if (index == 2) {
          return Color.fromARGB(255, 221, 32, 32);
        }
        break;
      case 'Normal':
        if (index == 1) {
          return Color.fromARGB(255, 240, 124, 124);
        }
        break;
      case 'Low':
        if (index == 0) {
          return Color.fromARGB(255, 247, 171, 171);
        }
        break;
      default:
        break;
    }
    return Colors.white;
  }
}
