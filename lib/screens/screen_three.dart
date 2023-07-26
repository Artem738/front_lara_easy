import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/pr.dart';
import '../models/book.dart';

class ScreenThree extends StatefulWidget {
  @override
  _ScreenThreeState createState() => _ScreenThreeState();
}

class _ScreenThreeState extends State<ScreenThree> {
  @override
  void initState() {
    super.initState();
    // Вызов функции fetchBooks() при инициализации страницы
    Provider.of<Pr>(context, listen: false).fetchBooks();
  }

  @override
  Widget build(BuildContext context) {
    var prWatch = context.watch<Pr>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Books List'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              Provider.of<Pr>(context, listen: false).fetchBooks();
            },
          ),
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              // Очистка списка книг
              Provider.of<Pr>(context, listen: false).clearBooks();
            },
          ),
        ],
      ),
      body: prWatch.books.isEmpty
          ? Center(
        child: CircularProgressIndicator(), // Показываем индикатор загрузки, пока данные загружаются
      )
          : ListView.builder(
        itemCount: prWatch.books.length,
        itemBuilder: (context, index) {
          Book book = prWatch.books[index];
          return ListTile(
            title: Text(book.name),
            subtitle: Text(book.year.toString()),
            // Другие поля, которые вы хотите отобразить для каждой книги
          );
        },
      ),
    );
  }
}
