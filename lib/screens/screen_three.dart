import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../provider/pr.dart';
import '../models/book.dart';

class ScreenThree extends StatefulWidget {
  @override
  _ScreenThreeState createState() => _ScreenThreeState();
}

class _ScreenThreeState extends State<ScreenThree> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrollingDown = false; // Флаг для отслеживания прокрутки вниз
  int _scrolledItemCount = 0; // Счетчик прокрученных элементов

  @override
  void initState() {
    super.initState();
    context.read<Pr>().fetchBooks();
    _scrollController.addListener(_onScroll); // Добавляем слушателя прокрутки
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll); // Удаляем слушателя прокрутки при удалении страницы
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
      // Пользователь начал прокрутку вниз
      _isScrollingDown = true;
      print("scrolling DOWN");
    }

    if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
      // Пользователь начал прокрутку вверх
      _isScrollingDown = false;
      print("scrolling UP");
    }

    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels == 0) {
        // Пользователь прокрутил вверх до начала списка
        print('Top of the list');
        // Здесь вы можете выполнить дополнительные действия при прокрутке вверх
      } else {
        // Пользователь прокрутил вниз до конца списка
        print('Bottom of the list');
        // Вызовите функцию для подгрузки дополнительных данных или обновления списка

        if (_isScrollingDown) {
          // Если пользователь прокручивает вниз, увеличиваем счетчик прокрученных элементов
          _scrolledItemCount++;
          print('Scrolled items: $_scrolledItemCount');
        }
        context.read<Pr>().fetchBooks();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var prRead = context.read<Pr>();
    var prWatch = context.watch<Pr>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Books List'),
      ),
      body: prWatch.books.isEmpty
          ? Center(
              child: CircularProgressIndicator(), // Показываем индикатор загрузки, пока данные загружаются
            )
          : ListView.builder(
              controller: _scrollController, // Подключаем ScrollController к ListView.builder
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<Pr>(context, listen: false).fetchBooks(); // Вызов функции fetchBooks() при нажатии на FloatingActionButton
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
