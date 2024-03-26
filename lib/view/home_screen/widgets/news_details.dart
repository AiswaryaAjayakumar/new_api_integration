// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NewsDetails extends StatefulWidget {
  NewsDetails({
    super.key,
    required this.date,
    required this.title,
    required this.imgUrl,
    required this.author,
    required this.des,
  });

  String date;
  String title;
  String imgUrl;
  String author;
  String des;

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.date),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.title,
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
                  imageUrl: widget.imgUrl,
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                
              ),
              SizedBox(
                height: 20,
              ),
              Text(widget.author),
              SizedBox(
                height: 20,
              ),
              Text(widget.des)
            ],
          ),
        ),
      ),
    );
  }
}
