// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_api_integration/controller/home_screen_controller.dart';

import 'package:new_api_integration/view/home_screen/widgets/category/category.dart';
import 'package:new_api_integration/view/home_screen/widgets/cutom_api_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<HomeScreenController>(context, listen: false).getData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var providerObj = Provider.of<HomeScreenController>(context);
    return Scaffold(
        body: providerObj.isLoading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
                  child: Column(
                    children: [
                      Category(),
                      ListView.separated(
                            shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => customNewsCard(
                              imageUrl:
                                  providerObj.articles[index].urlToImage ?? "",
                              author: providerObj.articles[index].author != null
                                  ? providerObj.articles[index].author ?? ""
                                  : "null",
                              des:
                                  providerObj.articles[index].description ?? "",
                              title: providerObj.articles[index].title ?? "",
                              dateTime: (providerObj
                                          .articles[index].publishedAt) !=
                                      null
                                  ? DateFormat("dd MM yyy").format(
                                      providerObj.articles[index].publishedAt!)
                                  : ""
                              //  dateTime:  DateFormat("dd MMM yyyy ")
                              //     .format(providerObj.articles[index].publishedAt!),
                              ),
                          separatorBuilder: (context, index) => Divider(),
                          itemCount: providerObj.articles.length),
                    ],
                  ),
                ),
              ));
  }
}
