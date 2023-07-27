import 'package:flutter/material.dart';

class LanguageDropdown extends StatefulWidget {
  @override
  _LanguageDropdownState createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends State<LanguageDropdown> {
  String _selectedLanguage = 'English'; // Начальное значение выбранного языка

  // Список доступных языков
  final Map<String, String> _languages = {
    'Ukrainian': 'ua',
    'English': 'en',
    'Poland': 'pl',
    'German': 'de',
    // Добавьте другие языки, если необходимо
  };

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _selectedLanguage,
      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() {
            _selectedLanguage = newValue; // Обновляем выбранный язык
            // Здесь можно выполнить дополнительные действия при выборе языка
          });
        }
      },
      items: _languages.keys.map<DropdownMenuItem<String>>((String language) {
        return DropdownMenuItem<String>(
          value: language,
          child: Text(language),
        );
      }).toList(),
    );
  }
}
