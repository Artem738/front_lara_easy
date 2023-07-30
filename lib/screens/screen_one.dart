import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/book.dart';
import '../provider/pr.dart';
import 'book_detail_page.dart';
import 'screen_one/widget_date_picker.dart';
import 'screen_one/widget_drop_language.dart';
import 'screen_one/widget_form_year.dart';

class ScreenOne extends StatefulWidget {
  @override
  State<ScreenOne> createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  final ScrollController _scrollController = ScrollController();
  bool _isFilterMenuOpen = false;

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
    if (_scrollController.position.atEdge && _scrollController.position.pixels != 0) {
      // User has scrolled to the end of the ListView
      // Call your method here to fetch more data or perform any other action
      context.read<Pr>().getBookData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ExpansionTile(
            childrenPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            title: _isFilterMenuOpen
                ? Text(
              'Закрыть меню фильтра',
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
            ) // Hide the text when menu is open
                : const Text(
              'Открыть меню фильтра',
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            onExpansionChanged: (value) {
              setState(() {
                _isFilterMenuOpen = value;
              });
            },
            children: [
              // Your filter menu widgets go here
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 0),
                  // Text(context.watch<Pr>().httpError),
                  // SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 16),
                      LanguageDropdown(),
                      SizedBox(width: 5),
                      YearWidget(),
                      SizedBox(width: 16),
                    ],
                  ),
                  SizedBox(height: 7),
                  DatePickerWidget(),
                  SizedBox(height: 10),
                ],
              ),
            ],
          ),
          //SizedBox(height: 16),
          //if (!_isFilterMenuOpen) // Hide the button when the filter menu is expanded

          if (context
              .watch<Pr>()
              .books
              .isEmpty)
            CircularProgressIndicator()
          else
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: context
                    .watch<Pr>()
                    .books
                    .length,
                itemBuilder: (context, index) {
                  Book book = context
                      .watch<Pr>()
                      .books[index];
                  return ListTile(
                    leading: ClipOval(
                      child: Image.network(
                        book.imageSmall ?? 'https://picsum.photos/id/1/100/100',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.network(
                            'https://picsum.photos/id/1/100/100',
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                    title: Text(book.name, style: TextStyle(fontSize: 15)),
                    subtitle: Text("Year: ${book.year.toString()},  pages: ${book.pages}, lang: ${book.lang}"),
                    trailing: Text("$index - ${book.id.toString()}"),
                    dense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 24.0),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => BookDetailPage(bookIndex: index, bookId: book.id),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
