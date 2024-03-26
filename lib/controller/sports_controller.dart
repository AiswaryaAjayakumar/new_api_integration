import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:new_api_integration/model/home_screen_model/api_res_model.dart';

class SportsController with ChangeNotifier {
  bool isLoading = false;
  List<Article> articles = [];

  Future<void> getData() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&category=sports&apiKey=6ce4f289ab0845ce946c96e79c8ef442");
    var responseData = await http.get(url);
    // print(responseData.statusCode);
    // print(responseData.body);
    if (responseData.statusCode == 200) {
      var decodedData = jsonDecode(responseData.body);

      SampleApiResModel apiRes = SampleApiResModel.fromJson(decodedData);
      articles = apiRes.articles ?? [];
    }
    isLoading = false;
    notifyListeners();
  }
}
