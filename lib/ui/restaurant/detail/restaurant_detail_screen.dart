import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:marinos_app/ui/restaurant/detail/restaurant_webview_screen.dart';
import 'package:marinos_app/utils/restaurant_utils.dart';
import 'package:url_launcher/url_launcher.dart';

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
      appBar: AppBar(elevation: 0),
      body: Center(
        child: Column(
          children: [
            Text(restaurants[index]['name']),
            Text(restaurants[index]['alias']),
            Container(
              width: 200,
              height: 200,
              color: Colors.grey.shade300,
              child: restaurants[index]['image_url'] != ""
                  ? Image.network(
                      restaurants[index]['image_url'],
                      fit: BoxFit.cover,
                    )
                  : const Icon(Icons.fastfood),
            ),
            Text(restaurants[index]['location']['address1']),
            const Text(
              'レビュー数',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            RatingBarIndicator(
              rating: restaurants[index]['rating'],
              unratedColor: Colors.grey,
              itemSize: 30,
              itemBuilder: (context, index) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
            ),
            TextButton(
              onPressed: () async {
                //TODO 電話をかける(実機で確かめる)
                String url =
                    'tel:${RestaurantUtils().getNumber(restaurants[index]['phone'])}';
                if (await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(Uri.parse(url));
                }
              },
              child: Text(
                RestaurantUtils().getNumber(
                  restaurants[index]['phone'],
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RestaurantWebViewScreen(
                      url: restaurants[index]['url'],
                    ),
                  ),
                );
              },
              child: const Text('URLを開く'),
            ),

            TextButton(
              onPressed: () {
                //TODO Mapを開く

                //TODO iOS/Androidの既存のMapを開く？
              },
              child: const Text('Mapを開く'),
            ),
            const Text(
              'カテゴリー',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: restaurants[index]['categories'].length,
                itemBuilder: (BuildContext context, int categories) {
                  return Center(
                    child: Column(
                      children: [
                        Text(
                          restaurants[index]['categories'][categories]['title'],
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          restaurants[index]['categories'][categories]['alias'],
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
