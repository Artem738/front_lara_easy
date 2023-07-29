import 'package:flutter/material.dart';

class FilterForm extends StatelessWidget {
  final String selectedLanguage;
  final String selectedYear;
  final DateTime selectedStartDate;
  final DateTime selectedEndDate;
  final ValueChanged<String> onLanguageChanged;
  final ValueChanged<String> onYearChanged;
  final ValueChanged<DateTime> onStartDateChanged;
  final ValueChanged<DateTime> onEndDateChanged;

  const FilterForm({
    required this.selectedLanguage,
    required this.selectedYear,
    required this.selectedStartDate,
    required this.selectedEndDate,
    required this.onLanguageChanged,
    required this.onYearChanged,
    required this.onStartDateChanged,
    required this.onEndDateChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DropdownButton<String>(
            value: selectedLanguage,
            onChanged: (String? newValue) {
              // Ваш код обработки изменения языка с новым значением `newValue`
            },
            items: <String>['', 'ua', 'en', 'pl', 'de'].map<DropdownMenuItem<String>>(
                  (String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value.isEmpty ? 'All Languages' : value.toUpperCase()),
                );
              },
            ).toList(),
          ),

          SizedBox(height: 16),
          TextField(
            keyboardType: TextInputType.number,
            onChanged: onYearChanged,
            decoration: InputDecoration(
              hintText: 'Year',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),
          TextButton(
            onPressed: () => _selectStartDate(context),
            child: Text('Start Date: ${_getFormattedDate(selectedStartDate)}'),
          ),
          SizedBox(height: 16),
          TextButton(
            onPressed: () => _selectEndDate(context),
            child: Text('End Date: ${_getFormattedDate(selectedEndDate)}'),
          ),
        ],
      ),
    );
  }

  String _getFormattedDate(DateTime date) {
    return '${date.toLocal()}'.split(' ')[0];
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedStartDate,
      firstDate: DateTime(1800),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selectedStartDate) {
      onStartDateChanged(picked);
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedEndDate,
      firstDate: DateTime(1800),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selectedEndDate) {
      onEndDateChanged(picked);
    }
  }
}
