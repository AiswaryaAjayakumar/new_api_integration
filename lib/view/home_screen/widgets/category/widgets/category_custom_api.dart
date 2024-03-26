// ignore_for_file: prefer_const_constructors, camel_case_types, sized_box_for_whitespace, must_be_immutable, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:new_api_integration/controller/business_screen_controller.dart';
//import 'package:new_api_integration/controller/home_screen_controller.dart';
import 'package:new_api_integration/view/home_screen/widgets/news_details.dart';
import 'package:provider/provider.dart';

class CategoryCustomApi extends StatelessWidget {
  CategoryCustomApi({
    super.key,
    required this.imageUrl,
    required this.author,
    required this.title,
    required this.des,
    required this.dateTime,
    required this.content,

  });
  String imageUrl;
  String author;
  String title;
  String des;
  String dateTime;
  String content;


  @override
  Widget build(BuildContext context) {
    var providerObj = Provider.of<BusinessController>(context);

    int index = 0;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      width: MediaQuery.sizeOf(context).height,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewsDetails(
                      date: (providerObj.articles[index].publishedAt) != null
                          ? DateFormat("dd MM yyy")
                              .format(providerObj.articles[index].publishedAt!)
                          : "Null",
                      title: providerObj.articles[index].title ?? "",
                      imgUrl: providerObj.articles[index].urlToImage ?? "",
                      author: providerObj.articles[index].author != null
                          ? providerObj.articles[index].author ?? ""
                          : "null",
                      des: providerObj.articles[index].description ?? "",
                    ),
                  ));
            },
            child: CachedNetworkImage(
              height: 150,
              width: 100,
              fit: BoxFit.cover,
              imageUrl: imageUrl,
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 247, 225, 224),
                      border: Border.all(color: Colors.red, width: .5)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(title),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  des,
                  maxLines: 8,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      author,
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      dateTime,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                Text(content)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
