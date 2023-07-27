class Book {
  final int id;
  final String name;
  final int year;
  final String lang;
  final int pages;
  final Category category; // Поле для хранения категории
  final DateTime createdAt;
  final DateTime updatedAt;

  Book({
    required this.id,
    required this.name,
    required this.year,
    required this.lang,
    required this.pages,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
  });


  // Геттер для получения ID книги
  int get bookId => id;

  // Геттер для получения имени книги
  String get bookName => name;

  // Геттер для получения года выпуска книги
  int get bookYear => year;

  // Геттер для получения языка книги
  String get bookLang => lang;

  // Геттер для получения количества страниц книги
  int get bookPages => pages;

  // Геттер для получения категории книги
  Category get bookCategory => category;

  // Геттер для получения даты создания книги
  DateTime get bookCreatedAt => createdAt;

  // Геттер для получения даты обновления книги
  DateTime get bookUpdatedAt => updatedAt;

}

class Category {
  final int id;
  final String name;

  Category({
    required this.id,
    required this.name,
  });



}