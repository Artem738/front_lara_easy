import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/pr.dart';

class DatePickerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width, // Устанавливаем фиксированную ширину
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              _selectStartDate(context);
            },
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.watch<Pr>().searchFormData.selectedStartDate.toLocal().toString().split(' ')[0],
                    style: TextStyle(fontSize: 16),
                  ),
                  Icon(Icons.calendar_today),
                ],
              ),
            ),
          ),
          SizedBox(width: 8), // Add some space between the two date pickers
          InkWell(
            onTap: () {
              _selectEndDate(context);
            },
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.watch<Pr>().searchFormData.selectedEndDate.toLocal().toString().split(' ')[0],
                    style: TextStyle(fontSize: 16),
                  ),
                  Icon(Icons.calendar_today),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: context.read<Pr>().searchFormData.selectedStartDate,
      firstDate: DateTime(1970),
      lastDate: DateTime(DateTime.now().year), // Set last date to current year + 1 year
    );

    if (picked != null && picked != context.read<Pr>().searchFormData.selectedStartDate) {
      context.read<Pr>().searchFormData.selectedStartDate = picked;
      print(context.read<Pr>().searchFormData.selectedStartDate);
      context.read<Pr>().searchDataChanged();
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: context.read<Pr>().searchFormData.selectedEndDate,
      firstDate: DateTime(1970),
      lastDate: DateTime(DateTime.now().year + 1), // Set last date to current year + 1 year
    );

    if (picked != null && picked != context.read<Pr>().searchFormData.selectedEndDate) {
      context.read<Pr>().searchFormData.selectedEndDate = picked;
      print(context.read<Pr>().searchFormData.selectedEndDate);
      context.read<Pr>().searchDataChanged();
    }
  }
}
