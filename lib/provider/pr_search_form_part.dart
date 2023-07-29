
part of 'pr.dart';

class SearchFormData {
  DateTime selectedStartDate = DateTime.parse('2000-01-01');
  DateTime selectedEndDate = DateTime.now();
  String selectedLanguage = 'en';
  int selectedYear = 2023;
}

extension PrMainSearchForm on Pr {


  void searchDataChanged() {
    _books = [];
    _lastId = 1;
    getBookData();
    notify();
  }
}