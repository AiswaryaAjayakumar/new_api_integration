// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:new_api_integration/view/home_screen/widgets/category/widgets/business_details.dart';
import 'package:new_api_integration/view/home_screen/widgets/category/widgets/sports_details.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      //width: MediaQuery.sizeOf(context).width,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          //shrinkWrap: true,
          //  physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => InkWell(
                onTap: () {
                  if (index == 0) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BusinessDetails(),
                        ));
                  } else if (index == 1) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SportsDetails(),
                        ));
                  }
                },
                child: Container(
                  height: 20,
                  width: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.red, width: .5),
                      color: Color.fromARGB(255, 242, 208, 205)),
                  child: Center(child: Text("Business")),
                ),
              ),
          separatorBuilder: (context, index) => SizedBox(
                width: 10,
              ),
          itemCount: 7),
    );
  }
}
