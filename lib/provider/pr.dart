
import 'package:flutter/material.dart';

import '../models/book.dart';
//import '../system/static_func.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Add this line

part 'pr_initialize_part.dart';

class Pr with ChangeNotifier {
  int test = 10;



  List<Book> _books = [];

  List<Book> get books => _books;

  String getBooks () {

    return _books.toString();
  }

  Future<void> fetchBooks() async {
    try {
      final response = await http.get(Uri.parse('http://lara-pro.loc/api/books/?startDate=1821-07-15&endDate=1847-07-16&year=2000'));
      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);
        final List<dynamic> data = responseData['data'];
        _books = [];

        for (var item in data) {
          var book = Book(
            id: item['id'],
            name: item['name'],
            year: item['year'],
            lang: item['lang'],
            pages: item['pages'],
          );

          _books.add(book); // Добавляем книгу в список
        }

        print(_books);
        notifyListeners();
      } else {
        // Если запрос завершился с ошибкой, обрабатываем ее
        throw Exception('Failed to load data');
      }
    } catch (error) {
      throw Exception('Failed to connect to the server');
    }
  }


}