import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/pr.dart';

class ScreenTwo extends StatefulWidget {
  @override
  _ScreenTwoState createState() => _ScreenTwoState();
}

class _ScreenTwoState extends State<ScreenTwo> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final pr = Provider.of<Pr>(context, listen: false);
    pr.fetchData(
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      selectedLanguage: 'en',
      selectedYear: '2022',
    );
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final double maxScroll = _scrollController.position.maxScrollExtent;
    final double currentScroll = _scrollController.position.pixels;
    final double delta = 200.0; // Минимальное расстояние для начала загрузки новых данных

    if (maxScroll - currentScroll <= delta) {
      final pr = Provider.of<Pr>(context, listen: false);
      pr.fetchData(
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        selectedLanguage: 'en',
        selectedYear: '2022',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final pr = Provider.of<Pr>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Books List'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Верхнее меню формирования ссылки
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // ... ваш код для верхнего меню ...
                ElevatedButton(
                  onPressed: () {
                    pr.fetchData(
                      startDate: DateTime.now(),
                      endDate: DateTime.now(),
                      selectedLanguage: 'en',
                      selectedYear: '2022',
                    );
                  },
                  child: const Text('Fetch Data'),
                ),
              ],
            ),
          ),
          // Список книг
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => pr.fetchData(
                startDate: DateTime.now(),
                endDate: DateTime.now(),
                selectedLanguage: 'en',
                selectedYear: '2022',
              ),
              child: ListView.builder(
                controller: _scrollController,
                itemCount: pr.books.length,
                itemBuilder: (context, index) {
                  final book = pr.books[index];
                  return ListTile(
                    title: Text(book.name),
                    subtitle: Text('Year: ${book.year}'),
                    // Другие поля, которые вы хотите отобразить для каждой книги
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

