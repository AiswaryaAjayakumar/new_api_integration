// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_api_integration/model/home_screen_model/api_res_model.dart';
import 'package:http/http.dart' as http;

class SearchScreenController with ChangeNotifier{
   bool isLoading = false;
  List<Article> SearchArticles = [];

    Future<void> SearchNews({required String query}) async {
    isLoading = true;
    notifyListeners();
    final url = Uri.parse(
        "https://newsapi.org/v2/everything?q=$query&apiKey=6ce4f289ab0845ce946c96e79c8ef442");
    var responseData = await http.get(url);
    // print(responseData.statusCode);
    // print(responseData.body);
    if (responseData.statusCode == 200) {
      var decodedData = jsonDecode(responseData.body);

      SampleApiResModel apiRes = SampleApiResModel.fromJson(decodedData);
      SearchArticles = apiRes.articles ?? [];
    }
    isLoading = false;
    notifyListeners();
  }
}