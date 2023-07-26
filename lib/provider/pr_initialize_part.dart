part of 'pr.dart';

extension PrMainInitialize on Pr {


  // void addHiveBasesToBasesMapList() async {
  //   var box = await Hive.openBox(globalDecksBaseName);
  //   var allBase = box.keys.toList();
  //
  //   for (var i = 0; i < allBase.length; i++) {
  //     var boxItem = box.get(allBase[i]);
  //     basesListMap.add(boxItem);
  //   }
  //   notifyListeners();
  // }


  void addDefaultBases() {
    List<Map<String, String>> defaultBasesMapList = [
      {
        "lead": "🇺🇦",
        "name": "Ukrainian",
        "description": "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        "systemName": "789798",
        "url": "",
      },
      {
        "lead": "🇺🇸",
        "name": "United States of America",
        "description": "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
        "systemName": "789854",
        "url":
        "https://docs.google.com/spreadsheets/d/e/2PACX-1vR3aCQcetEK-d0e4eOh1wFyeU-Gzdn0bBZVbKMcY_QXUtEAqpIad5b6Gzl9oQ5Mbw7ptSEQzb2Rk29D/pubhtml",
      },
      {
        "lead": "🇬🇧",
        "name": "United Kingdom",
        "description": "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
        "systemName": "789963",
        "url":
        "https://docs.google.com/spreadsheets/d/e/2PACX-1vR3aCQcetEK-d0e4eOh1wFyeU-Gzdn0bBZVbKMcY_QXUtEAqpIad5b6Gzl9oQ5Mbw7ptSEQzb2Rk29D/pubhtml",
      },
      {
        "lead": "👨‍💻",
        "name": "Staff and teachers",
        "description":
        "You can record the name of a teacher or employee at work, as well as indicate the position or subject taught. It might come in handy in your new job.",
        "systemName": "78996301",
        "url": "",
      },
      {
        "lead": "🚗",
        "name": "Driving Licence",
        "description":
        "The laws relating to the licensing of drivers vary between jurisdictions. In some jurisdictions, a permit is issued after the recipient has passed a driving test, while in others, a person acquires their permit before beginning to drive.",
        "systemName": "7899631",
        "url": "",
      },
      {
        "lead": "🍃",
        "name": "UTF",
        "description": "Cool UTF symbol from unicode-table.com",
        "systemName": "78996322",
        "url": "",
      },
    ];

    // for (var i = 0; i < defaultBasesMapList.length; i++) {
    //   addToBasesMapList(defaultBasesMapList[i]['lead']!, defaultBasesMapList[i]['name']!, defaultBasesMapList[i]['description']!,
    //       defaultBasesMapList[i]['url']!, defaultBasesMapList[i]['systemName']!);
    // }
    // notifyListeners();

  }
}