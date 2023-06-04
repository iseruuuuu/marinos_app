import 'dart:io';
import 'package:flutter/material.dart';
import 'package:marinos_app/ui/restaurant/component/restaurant_list_tile.dart';
import 'package:marinos_app/ui/restaurant/component/restaurant_title_item.dart';
import 'package:marinos_app/ui/restaurant/detail/restaurant_webview_screen.dart';
import 'package:marinos_app/utils/restaurant_utils.dart';
import 'package:url_launcher/url_launcher.dart';
import '../component/restaurant_category_item.dart';

class RestaurantDetailScreen extends StatelessWidget {
  const RestaurantDetailScreen({
    Key? key,
    required this.restaurants,
    required this.index,
  }) : super(key: key);

  final List<dynamic> restaurants;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                color: Colors.grey.shade300,
                child: restaurants[index]['image_url'] != ""
                    ? Image.network(
                        restaurants[index]['image_url'],
                        fit: BoxFit.cover,
                      )
                    : const Icon(Icons.fastfood),
              ),
              AppBar(backgroundColor: Colors.transparent),
            ],
          ),
          RestaurantTitleItem(
            restaurant: restaurants[index]['alias'],
            restaurantName: restaurants[index]['name'],
            address: restaurants[index]['location']['address1'],
            rate: restaurants[index]['rating'],
          ),
          RestaurantListTile(
            onTap: () async {
              //TODO 電話をかける(実機で確かめる)
              String url =
                  'tel:${RestaurantUtils().getNumber(restaurants[index]['phone'])}';
              if (await canLaunchUrl(Uri.parse(url))) {
                await launchUrl(Uri.parse(url));
              }
            },
            icon: Icons.call,
            title: RestaurantUtils().getNumber(
              restaurants[index]['phone'],
            ),
          ),
          RestaurantListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RestaurantWebViewScreen(
                    url: restaurants[index]['url'],
                  ),
                ),
              );
            },
            icon: Icons.web,
            title: 'サイトを開く',
          ),
          RestaurantListTile(
            onTap: () async {
              var latitude = restaurants[index]['coordinates']['latitude'];
              var longitude = restaurants[index]['coordinates']['longitude'];
              if (Platform.isIOS) {
                String appleUrl =
                    'http://maps.apple.com/?q=$latitude,$longitude';
                if (await canLaunch(appleUrl)) {
                  await launch(appleUrl);
                } else {
                  throw 'Could not launch $appleUrl';
                }
              } else {
                String googleUrl =
                    'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
                if (await canLaunch(googleUrl)) {
                  await launch(googleUrl);
                } else {
                  throw 'Could not launch $googleUrl';
                }
              }
            },
            icon: Icons.map,
            title: 'Mapを開く',
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              'カテゴリー',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          //TODO リストの上の方を詰めたい。
          ListView.builder(
            shrinkWrap: true,
            itemCount: restaurants[index]['categories'].length,
            itemBuilder: (BuildContext context, int categories) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Wrap(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            RestaurantCategoryItem(
                              category: restaurants[index]['categories']
                                  [categories]['title'],
                            ),
                            RestaurantCategoryItem(
                              category: restaurants[index]['categories']
                                  [categories]['alias'],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
