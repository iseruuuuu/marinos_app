import 'package:flutter/material.dart';
import 'package:marinos_app/ui/restaurant/detail/restaurant_webview_screen.dart';

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
            //TODO 評価をStarにしたい。
            Text('Rating: ${restaurants[index]['rating']}'),
            //TODO 電話番号を日本版に直したい。
            Text(restaurants[index]['phone']),
            Text(restaurants[index]['display_phone']),
            //TODO カテゴリーをたくさん取得できるようにしたい。
            Text(restaurants[index]['categories'][0]['title']),
            Text(restaurants[index]['categories'][0]['alias']),
            Text(restaurants[index]['categories'].toString()),
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
          ],
        ),
      ),
    );
  }
}
