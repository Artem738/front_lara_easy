import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'dart:math';
import 'dart:convert';


class StaticFunc {

  static String getDayAddition (int num) {
    int preLastDigit = (num % 10);
    print(">>$preLastDigit<<");

    if (preLastDigit == 1) {
      return "дней";
    }

    switch (num % 10) {
      case 1:
        return "день";
      case 2:
      case 3:
      case 4:
        return "дня";
      default:
        return "дней";
    }


  }

  static String changeDateFormat(String oldDateString) {
    String newDateString = "";
    var dateArr = oldDateString.split(".");
    newDateString = "${dateArr[2]}-${dateArr[1]}-${dateArr[0]}";
    return newDateString;
  }

  static String getRandString(int len) {
    var random = Random.secure();
    var values = List<int>.generate(len, (i) =>  random.nextInt(255));
    return base64UrlEncode(values);
  }


  static bool isUrlValid (String url) {
    if(url == "") {
      return true;
    }
    if(url.length < 5) {
      return false;
    }
    if(!url.toLowerCase().contains("http://") && !url.toLowerCase().contains("https://")) {
      return false;
    }
    return true;
  }


  /*HTTP Функция. Принимает урлу, возвращает <String,String> из результата и ошибки */
  static Future getHttpBody(String urlToParse) async {
    print("getHttpBody - Start");

// проверяем нормальная ли вообще ссылка
    if ((urlToParse.contains('http://')) || (urlToParse.contains('https://'))) {
      print("OK - GOOD URL");
    } else {
      print("ERROR - WRONG URL");
//print("WWWWW $urlToParse >>>> ${urlToParse.contains('https://')} <<<<<<<");
      return ["", "Wrong URL, no http or https."];
    }

    var url = Uri.parse(urlToParse);
    bool _isValidUrl = false;

    try {
      http.Response response = await http.get(url);
      print("Received response code - ${response.statusCode}");
      _isValidUrl = true;
    } catch (http_error) {
      print("HTTP ERROR =>  ${http_error}");
      return ["", "$http_error"];
    }

    if (_isValidUrl) {
      http.Response response = await http.get(url);
      try {
        if (response.statusCode == 200) {
          print("getHttpBody - Done");
          return [response.body, "200"];
        } else {
          print("Error - not 200 - ${response.statusCode}");
          return ['', "${response.statusCode}"];
        }
      } catch (e) {
        print("Error - ${response.statusCode}");
        return ['', "${response.statusCode}"];
      }
    } else {
      return ['', "1"];
    }
  }



  static List<String> parseCont(String data, String left_str, String right_str, [bool? nogreed]) {
    if (nogreed == null) nogreed = false;
    List<String> splitedData;
    List<String> returnData = [];

    if (!data.contains(left_str)) {
      returnData.add("Error");
      returnData.add("Left String Not Found");
      return returnData;
    }
    if (!data.contains(right_str)) {
      returnData.add("Error");
      returnData.add("Right String Not Found");
      return returnData;
    }

    splitedData = data.split(left_str);
    for (var i = 1; i < splitedData.length; i++) {
      if (splitedData[i].contains(right_str)) {
        var strpos = splitedData[i].indexOf(right_str);
        String result = splitedData[i].substring(0, strpos);
        if (result != null) {
          if (nogreed) {
            result = left_str + result + right_str;
            returnData.add(result);
          } else {
            returnData.add(result);
          }
        }
      }
    }
    return returnData;
  }



  static String removeHtml(String htmlString) {
    var document = parse(htmlString);
    String parsedString = parse(document.body!.text).documentElement!.text;
    //parsedString = parsedString.replaceAll("\n", " ");
    parsedString = parsedString.replaceAll("\t", " ");
    parsedString = parsedString.replaceAll("  ", " ");
    parsedString = parsedString.replaceAll("  ", " ");
    parsedString = parsedString.replaceAll("\n \n ", "\n ");
    // parsedString = parsedString.replaceAll("\n \n ", "\n ");

    return parsedString.trim();
  }

}

