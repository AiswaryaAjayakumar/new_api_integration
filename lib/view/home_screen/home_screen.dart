// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_api_integration/controller/home_screen_controller.dart';
import 'package:new_api_integration/controller/search_screen_controller.dart';
import 'package:new_api_integration/view/home_screen/widgets/cutom_api_card.dart';
import 'package:new_api_integration/view/home_screen/widgets/news_details.dart';
import 'package:new_api_integration/view/search_screen/search_screen.dart';

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
      Provider.of<HomeScreenController>(context, listen: false)
          .getTopHeadlines();
      Provider.of<HomeScreenController>(context, listen: false)
          .getDataCategory();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final providerObj = Provider.of<HomeScreenController>(context);
    return DefaultTabController(
      length: 4,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Center(child: Text("News App")),
            titleTextStyle: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider(
                                  create: (context) => SearchScreenController(),
                                  child: SearchScreen(),
                                )));
                  },
                  icon: Icon(
                    Icons.search_sharp,
                    size: 30,
                    color: Colors.black,
                  ))
            ],
          ),
          body: Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 350,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.easeInToLinear,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  scrollDirection: Axis.horizontal,
                ),
                items: List.generate(
                    providerObj.topHeadlinesList.length,
                    (index) => Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CachedNetworkImage(
                              width: double.infinity,
                              fit: BoxFit.cover,
                              imageUrl: providerObj
                                      .topHeadlinesList[index].urlToImage ??
                                  "",
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        )),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: List.generate(
                  HomeScreenController.categoryList.length,
                  (index) => InkWell(
                    onTap: () async {
                      await Provider.of<HomeScreenController>(context,
                              listen: false)
                          .getDataCategory(
                              index: index,
                              category:
                                  HomeScreenController.categoryList[index]);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Chip(
                        side: BorderSide(
                            color: const Color.fromARGB(255, 237, 101, 91)),
                        color: MaterialStatePropertyAll(
                            HomeScreenController.selectedIndex == index
                                ? Color.fromARGB(255, 232, 194, 192)
                                : null),
                        label: Text(HomeScreenController.categoryList[index]
                            .toUpperCase()),
                      ),
                    ),
                  ),
                )),
              ),
              Expanded(
                child: providerObj.isLoading == true
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.separated(
                        itemCount: providerObj.articles.length,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        itemBuilder: (context, index) => customNewsCard(
                            imageUrl:
                                providerObj.articles[index].urlToImage ?? "",
                            author: providerObj.articles[index].author ?? "",
                            des: providerObj.articles[index].source?.name ?? "",
                            title: providerObj.articles[index].title ?? "",
                            dateTime: providerObj.articles[index].publishedAt !=
                                    null
                                ? DateFormat("dd MMM yyyy ").format(
                                    providerObj.articles[index].publishedAt!)
                                : "",
                                onDetailedTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetails(articleDetails: providerObj.articles[index]),));
                                },
                                ),

                        separatorBuilder: (context, index) => Divider(),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
