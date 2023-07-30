import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/book.dart';

part 'pr_initialize_part.dart';
part 'pr_search_form_part.dart';




class Pr with ChangeNotifier {
  //static const String baseUrl = 'http://lara-pro.loc/api/books/';
  //static const String baseUrl = 'http://176.37.2.137/api/books/';
  static const String baseUrl = 'https://iamtex.com.ua/art-api/a738_bot/proxy/index.php'; //proxy!


  String httpError = '...';

  List<Book> _books = [];

  int _lastId = 1;
  List<Book> get books => _books; // Геттер для получения списка книг
  int get lastId => _lastId; // Геттер для получения списка книг

  void notify(){
    notifyListeners();
  }

  // pr_search_form_part
  SearchFormData searchFormData = SearchFormData();

  // GOGOGO getBookData
  Future<void> getBookData() async {
    // _isLoading = true;

    String selectedYearString = '';
    if (searchFormData.selectedYear != 0) {
      selectedYearString = searchFormData.selectedYear.toString();
    }
    String formattedStartDate = searchFormData.selectedStartDate.toString().replaceAll(' ', 'T');
    String formattedEndDate = searchFormData.selectedEndDate.toString().replaceAll(' ', 'T');
    String apiUrl = "$baseUrl?startDate=$formattedStartDate&endDate=$formattedEndDate"
        "&year=$selectedYearString&lang=${searchFormData.selectedLanguage}&lastId=$_lastId";
    print(apiUrl);
    // exit(0);
    final url = Uri.parse(apiUrl);

    fetchBooks(apiUrl, 3);

  }

  Future<void> fetchBooks(String apiUrl, int retryCount) async {
    final url = Uri.parse(apiUrl);

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        //print(response.body);
        final jsonData = json.decode(response.body);
        final data = jsonData['data'];
        final meta = jsonData['meta'];
        final error = jsonData['error'];
        final totalCount = meta['totalCount'];

        _books.addAll(totalCount == 0 ? [] : parseBooks(data));

        _lastId = meta['lastId'];

       // httpError += response.statusCode.toString() + "...";
        notify();
      } else if (response.statusCode == 422) {
       // httpError += response.statusCode.toString() + "...";
        notify();
      } else {
       // httpError += response.statusCode.toString() + "...";
        notify();
      }
    } catch (e) {
     // httpError += e.toString() + "...";
      notify();

      if (retryCount > 0) {
        await Future.delayed(Duration(seconds: 1)); // Ждем 2 секунды перед повторным запросом
        await fetchBooks(apiUrl, retryCount - 1); // Повторяем запрос с уменьшенным счетчиком попыток
      }
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
