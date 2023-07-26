import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/pr.dart';

class ScreenTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                    final pr = Provider.of<Pr>(context, listen: false);
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
            child: Consumer<Pr>(
              builder: (context, pr, _) {
                if (pr.isLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                    itemCount: pr.books.length,
                    itemBuilder: (context, index) {
                      final book = pr.books[index];
                      return ListTile(
                        title: Text(book.name),
                        subtitle: Text('Year: ${book.year}'),
                        // Другие поля, которые вы хотите отобразить для каждой книги
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
