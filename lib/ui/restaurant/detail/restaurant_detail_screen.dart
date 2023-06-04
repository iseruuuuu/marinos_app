import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:marinos_app/ui/restaurant/detail/component/restaurant_list_tile.dart';
import 'package:marinos_app/ui/restaurant/detail/restaurant_webview_screen.dart';
import 'package:marinos_app/utils/restaurant_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import 'component/restaurant_category_item.dart';

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
      body: Center(
        child: Column(
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
            Container(
              color: Colors.blueAccent,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        restaurants[index]['alias'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      restaurants[index]['name'],
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      restaurants[index]['location']['address1'],
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      children: [
                        RatingBarIndicator(
                          rating: restaurants[index]['rating'],
                          unratedColor: Colors.white,
                          itemSize: 25,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Text(
                          restaurants[index]['rating'].toString(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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
              onTap: () async {
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
            Flexible(
              child: Container(
                color: Colors.grey,
                //TODO リストの上の方を詰めたい。
                child: ListView.builder(
                  itemCount: restaurants[index]['categories'].length,
                  itemBuilder: (BuildContext context, int categories) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Wrap(
                            runSpacing: 16,
                            spacing: 16,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
