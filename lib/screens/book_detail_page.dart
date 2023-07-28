import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/book.dart';
import '../provider/pr.dart';

class BookDetailPage extends StatefulWidget {
  final int bookId;
  final int bookIndex;

  BookDetailPage({required this.bookId, required this.bookIndex});

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  @override
  Widget build(BuildContext context) {
    final Book book = context.read<Pr>().books.firstWhere((book) => book.id == widget.bookId);

    return Scaffold(
      body: Stack(
        children: [
          // Картинка на весь экран
          Image.network(
            book.imageLarge,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // Кастомный виджет сверху
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.black.withOpacity(0.5)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    book.name,
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          blurRadius: 5.0,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Year: ${book.year}, Pages: ${book.pages}',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          blurRadius: 5.0,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Category: ${book.category.name} - id:${book.category.id}',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          blurRadius: 5.0,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Lorem Ipsum текст внизу с тенью
          Positioned(
            bottom: 20.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(1),
                      blurRadius: 5.0,
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
