import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/book.dart';
import '../provider/pr.dart';
import 'screen_one/widget_drop_language.dart';

class ScreenOne extends StatefulWidget {
  @override
  State<ScreenOne> createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.atEdge &&
        _scrollController.position.pixels != 0) {
      // User has scrolled to the end of the ListView
      // Call your method here to fetch more data or perform any other action
      context.read<Pr>().getBookData();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            LanguageDropdown(), // Placing the dropdown menu at the top
            SizedBox(height: 16), // Adding some spacing between the dropdown and the button
            ElevatedButton(
              onPressed: () {
                context.read<Pr>().getBookData();
              },
              child: const Text('Load Data'),
            ),
            SizedBox(height: 16), // Adding some spacing between the dropdown and the button
            ElevatedButton(
              onPressed: () {
                context.read<Pr>().showData();
              },
              child: const Text('Show Data'),
            ),
            SizedBox(height: 16), // Adding some spacing between the button and the text
            if (context.watch<Pr>().books.isEmpty)
              CircularProgressIndicator() // Show a loading spinner if _isLoading is true
            else
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: context.watch<Pr>().books.length,
                  itemBuilder: (context, index) {
                    Book book = context.watch<Pr>().books[index];
                    return ListTile(
                      title: Text(book.name),
                      subtitle: Text(book.year.toString()),
                      // Other fields you want to display for each book
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
