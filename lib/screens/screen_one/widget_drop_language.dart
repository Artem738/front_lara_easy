import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/pr.dart';




class LanguageDropdown extends StatefulWidget {
  @override
  _LanguageDropdownState createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends State<LanguageDropdown> {
  final Map<String, String> _languages = {
    'All languages': '',
    'Ukrainian': 'ua',
    'English': 'en',
    'Poland': 'pl',
    'German': 'de',
    // Добавьте другие языки с их аббревиатурами, если необходимо
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      width: 150, // Установили максимальную ширину контейнера для языка
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
        isExpanded: true, // Добавили, чтобы расширить выпадающий список на всю ширину
        value: context.read<Pr>().selectedLanguage,
        onChanged: (String? newValue) {
          if (newValue != null) {
            setState(() {
              context.read<Pr>().selectedLanguage = newValue; // Обновляем выбранный язык
              context.read<Pr>().searchDataChanged(); // Обновляем выбранный язык
              // Здесь можно выполнить дополнительные действия при выборе языка
            });
          }
        },
        items: _languages.keys.map<DropdownMenuItem<String>>((String language) {
          return DropdownMenuItem<String>(
            value: _languages[language], // Use the two-letter abbreviation as the value
            child: Text(language),
          );
        }).toList(),
      ),
    );
  }
}
