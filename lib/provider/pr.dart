import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/book.dart';

part 'pr_initialize_part.dart';

class Pr with ChangeNotifier {
  int test = 10;
  List<Book> _books = [];

  List<Book> get books => _books; // Геттер для получения списка книг

  static const String baseUrl = 'http://lara-pro.loc/api/books/';

  List<dynamic> _data = [];
  bool _isLoading = true;

  int _lastId = 0;

  bool get isLoading => _isLoading;

  // static Future<List<dynamic>> fetchData({
  //   required DateTime startDate,
  //   required DateTime endDate,
  //   required String selectedLanguage,
  //   required String selectedYear,
  //   required int lastId,
  //   required int limit,
  // }) async {
  //   if (lastId == 0) {
  //     lastId = 1;
  //   }
  //   final url = Uri.parse('$baseUrl?startDate=$startDate&endDate=$endDate&year=$selectedYear&lang=$selectedLanguage&lastId=$lastId&limit=$limit');
  //   print(url);
  //   final response = await http.get(url);
  //   if (response.statusCode == 200) {
  //     final jsonData = json.decode(response.body);
  //     final data = jsonData['data'];
  //     return data;
  //   } else {
  //     throw Exception('Error: ${response.statusCode}');
  //   }
  // }

  // Метод для загрузки данных из API
  Future<void> fetchData({
    required DateTime startDate,
    required DateTime endDate,
    required String selectedLanguage,
    required String selectedYear,
  }) async {
    final url = Uri.parse('http://lara-pro.loc/api/books/?startDate=$startDate&endDate=$endDate&year=$selectedYear&lang=$selectedLanguage');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final data = jsonData['data'];
      final meta = jsonData['meta'];
      final totalCount = meta['totalCount'];

      _data = totalCount == 0 ? [] : data;
      _isLoading = false;
      _lastId = meta['lastId'];

      notifyListeners();
    } else if (response.statusCode == 422) {
      // Handle the error when API returns 422
      _data = [];
      _isLoading = false;
      notifyListeners();
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  // Метод для подгрузки данных
  Future<void> loadMoreData({
    required DateTime startDate,
    required DateTime endDate,
    required String selectedLanguage,
    required String selectedYear,
    required int limit,
  }) async {
    if (_isLoading) return;
    final url = Uri.parse('http://lara-pro.loc/api/books/?startDate=$startDate&endDate=$endDate&year=$selectedYear&lang=$selectedLanguage&lastId=$_lastId&limit=$limit');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final data = jsonData['data'];
      final meta = jsonData['meta'];

      _data.addAll(data);
      _lastId = meta['lastId'];

      notifyListeners();
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  // Метод для очистки списка книг
  void clearBooks() {
    _books.clear();
    notifyListeners();
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
        //print(_books);

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
