// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_api_integration/controller/home_screen_controller.dart';
import 'package:new_api_integration/model/home_screen_model/api_res_model.dart';
import 'package:new_api_integration/view/home_screen/widgets/cutom_api_card.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetails extends StatefulWidget {
  NewsDetails({
    super.key,
    required this.articleDetails,
  });

  final Article articleDetails;

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  @override
  Widget build(BuildContext context) {
    final providerObj = Provider.of<HomeScreenController>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.arrow_back),
                ],
              ),
              Text(widget.articleDetails.publishedAt.toString()),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.articleDetails.title.toString(),
                maxLines: 8,
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: CachedNetworkImage(
                  // height: 200,
                  // width: 300,
                  fit: BoxFit.cover,
                  imageUrl: widget.articleDetails.urlToImage.toString(),
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(widget.articleDetails.author.toString()),
              SizedBox(
                height: 20,
              ),
              Text(widget.articleDetails.description.toString()),
              Center(
                  child: TextButton(
                      onPressed: () async {
                        final url =
                            Uri.parse(widget.articleDetails.url.toString());
                        await launchUrl(url);
                      },
                      child: Text("Read more...")))
            ],
          ),
        ),
      ),
    );
  }
}
