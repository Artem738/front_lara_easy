import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/pr.dart';
import '../models/book.dart';

class ScreenThree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Books List'),
      ),
      body: Consumer<Pr>(
        builder: (context, pr, _) {
          if (pr.books.isEmpty) {
            return Center(
              child: CircularProgressIndicator(), // Показываем индикатор загрузки, пока данные загружаются
            );
          } else {
            return ListView.builder(
              itemCount: pr.books.length,
              itemBuilder: (context, index) {
                Book book = pr.books[index];
                return ListTile(
                  title: Text(book.name),
                  subtitle: Text(book.year.toString()),
                  // Другие поля, которые вы хотите отобразить для каждой книги
                );
              },
            );
          }
        },
      ),
    );
  }
}