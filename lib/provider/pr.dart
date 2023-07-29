import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/book.dart';

part 'pr_initialize_part.dart';

class Pr with ChangeNotifier {
  //static const String baseUrl = 'http://lara-pro.loc/api/books/';
  static const String baseUrl = 'http://176.37.2.137/api/books/';


  List<Book> _books = [];
  bool _isLoading = true;

  bool get isLoading => _isLoading;
  int _lastId = 1;

  DateTime selectedStartDate = DateTime.parse('2000-01-01');
  DateTime selectedEndDate = DateTime.now();
  String selectedLanguage = 'en';
  int selectedYear = 2023;

  List<Book> get books => _books; // Геттер для получения списка книг
  int get lastId => _lastId; // Геттер для получения списка книг

  // FILTER


  void searchDataChanged() {
    _books = [];
    _lastId = 1;
    getBookData();
    notifyListeners();
  }

  // GOGOGO getBookData
  Future<void> getBookData() async {
    // _isLoading = true;

    String selectedYearString = '';
    if (selectedYear != 0) {
      selectedYearString = selectedYear.toString();
    }
    String formattedStartDate = selectedStartDate.toString().replaceAll(' ', 'T');
    String formattedEndDate = selectedEndDate.toString().replaceAll(' ', 'T');
    String apiUrl = "$baseUrl?startDate=$formattedStartDate&endDate=$formattedEndDate"
        "&year=$selectedYearString&lang=$selectedLanguage&lastId=$_lastId";
    print(apiUrl);
    // exit(0);
    final url = Uri.parse(apiUrl);

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final data = jsonData['data'];
      final meta = jsonData['meta'];
      final error = jsonData['error'];
      final totalCount = meta['totalCount'];

      _books.addAll(totalCount == 0 ? [] : parseBooks(data));
      // _isLoading = false;
      _lastId = meta['lastId'];

      //print(_books[3].name);

      notifyListeners();
    } else if (response.statusCode == 422) {
      // Handle the error when API returns 422
      // _books.clear();
      // _isLoading = false;
      notifyListeners();
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  List<Book> parseBooks(List<dynamic> dataList) {
    //Adding random image    https://api.slingacademy.com/public/sample-photos/100.jpeg

    return dataList.map((data) {
      Random random = Random();
      int randomImageApiId = random.nextInt(100) + 1;

      return Book(
        id: data['id'],
        name: data['name'],
        year: data['year'],
        lang: data['lang'],
        pages: data['pages'],
        //image: "https://api.slingacademy.com/public/sample-photos/${random.nextInt(100) + 1}.jpeg",
        imageSmall: "https://picsum.photos/id/$randomImageApiId/100/100",
        imageLarge: "https://picsum.photos/id/$randomImageApiId/1000/1000",
        category: Category(
          id: data['category']['id'],
          name: data['category']['name'],
        ),
        createdAt: DateTime.parse(data['createdAt']),
        updatedAt: DateTime.parse(data['updatedAt']),
      );
    }).toList();
  }

  void showData() {
    print(_books);
  }
}
