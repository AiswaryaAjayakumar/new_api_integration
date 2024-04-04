// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_api_integration/controller/search_screen_controller.dart';
import 'package:new_api_integration/view/home_screen/widgets/cutom_api_card.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController s1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final providerObj = Provider.of<SearchScreenController>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: s1,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (s1.text.isNotEmpty) {
                      Provider.of<SearchScreenController>(context,
                              listen: false)
                          .SearchNews(query: s1.text);
                    } else {
                      null;
                    }
                  },
                  child: Text("Search")),
              Expanded(
                child: providerObj.isLoading == true
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.separated(
                        itemCount: providerObj.SearchArticles.length,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        itemBuilder: (context, index) => customNewsCard(
                            imageUrl:
                                providerObj.SearchArticles[index].urlToImage ??
                                    "",
                            author:
                                providerObj.SearchArticles[index].author ?? "",
                            des: providerObj.SearchArticles[index].source?.name ??
                                "",
                            title:
                                providerObj.SearchArticles[index].description ??
                                    "",
                            dateTime: providerObj
                                        .SearchArticles[index].publishedAt !=
                                    null
                                ? DateFormat("dd MMM yyyy ").format(providerObj
                                    .SearchArticles[index].publishedAt!)
                                : ""),
                        separatorBuilder: (context, index) => Divider(
                          thickness: .5,
                          indent: 30,
                          endIndent: 30,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
