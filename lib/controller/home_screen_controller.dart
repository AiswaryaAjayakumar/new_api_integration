import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:new_api_integration/model/home_screen_model/api_res_model.dart';

class HomeScreenController with ChangeNotifier {
  static int selectedIndex = 0;
  bool isLoading = false;
  List<Article> articles = [];

  static List<String> categoryList = [
    "business",
    "entertainment",
    "general",
    "health",
    "science",
    "sports",
    "technology"
  ];
  List<Article> topHeadlinesList = [];
  // Future<void> getData() async {
  //   isLoading = true;
  //   notifyListeners();
  //   final url = Uri.parse(
  //       "https://newsapi.org/v2/everything?q=india&apiKey=6ce4f289ab0845ce946c96e79c8ef442");
  //   var responseData = await http.get(url);
  //   // print(responseData.statusCode);
  //   // print(responseData.body);
  //   if (responseData.statusCode == 200) {
  //     var decodedData = jsonDecode(responseData.body);

  //     SampleApiResModel apiRes = SampleApiResModel.fromJson(decodedData);
  //     articles = apiRes.articles ?? [];
  //   }
  //   isLoading = false;
  //   notifyListeners();
  // }

  Future<void> getDataCategory(
      {String category = "business", int index = 0}) async {
    selectedIndex = index;
    isLoading = true;
    notifyListeners();
    final url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=6ce4f289ab0845ce946c96e79c8ef442");
    final responseData = await http.get(url);
    // print(responseData.statusCode);
    // print(responseData.body);
    if (responseData.statusCode == 200) {
      final decodedData = jsonDecode(responseData.body);

      SampleApiResModel apiRes = SampleApiResModel.fromJson(decodedData);
      articles = apiRes.articles ?? [];
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> getTopHeadlines() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&apiKey=6ce4f289ab0845ce946c96e79c8ef442");
    var responseData = await http.get(url);
    // print(responseData.statusCode);
    // print(responseData.body);
    if (responseData.statusCode == 200) {
      var decodedData = jsonDecode(responseData.body);

      SampleApiResModel apiRes = SampleApiResModel.fromJson(decodedData);
      topHeadlinesList = apiRes.articles ?? [];
    }
    isLoading = false;
    notifyListeners();
  }
}
