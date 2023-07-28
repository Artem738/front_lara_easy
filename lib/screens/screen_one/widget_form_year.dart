import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/pr.dart';

class YearWidget extends StatefulWidget {
  @override
  _YearWidgetState createState() => _YearWidgetState();
}

class _YearWidgetState extends State<YearWidget> {
  // Создаем контроллер
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Устанавливаем изначальное значение года из провайдера
    _controller.text = context.read<Pr>().selectedYear.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      width: 100, // Установили максимальную ширину контейнера для года
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   'Year:',
          //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          // ),
          //SizedBox(height: 8),
          TextField(
            controller: _controller, // Устанавливаем контроллер для текстового поля
            keyboardType: TextInputType.number,
            onSubmitted: (value) {
              print ("TextInputType year");
              int year = int.tryParse(value) ?? 0;
              context.read<Pr>().selectedYear = year;
              context.read<Pr>().searchDataChanged();
            },
            decoration: InputDecoration(
              hintText: 'Year',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Обязательно очищаем контроллер при уничтожении виджета
    _controller.dispose();
    super.dispose();
  }
}
