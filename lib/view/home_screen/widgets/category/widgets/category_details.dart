// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_api_integration/controller/business_screen_controller.dart';
import 'package:new_api_integration/view/home_screen/widgets/category/widgets/category_custom_api.dart';
//import 'package:new_api_integration/view/home_screen/widgets/cutom_api_card.dart';
import 'package:provider/provider.dart';

class CategoryDetails extends StatefulWidget {
  const CategoryDetails({super.key});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  void initState() {
    WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) {
      Provider.of<BusinessController>(context, listen: false).getData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var providerObj = Provider.of<BusinessController>(context);
    return Scaffold(
      body: ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => CategoryCustomApi(
                imageUrl: providerObj.articles[index].urlToImage != null
                    ? providerObj.articles[index].urlToImage ?? ""
                    : "null",
                author: providerObj.articles[index].author != null
                    ? providerObj.articles[index].author ?? ""
                    : "null",
                des: providerObj.articles[index].description ?? "",
                title: providerObj.articles[index].title ?? "",
                dateTime: (providerObj.articles[index].publishedAt) != null
                    ? DateFormat("dd MM yyy")
                        .format(providerObj.articles[index].publishedAt!)
                    : "",
                content: providerObj.articles[index].content ?? "",

                //  dateTime:  DateFormat("dd MMM yyyy ")
                //     .format(providerObj.articles[index].publishedAt!),
              ),
          separatorBuilder: (context, index) => Divider(),
          itemCount: providerObj.articles.length),
    );
  }
}
