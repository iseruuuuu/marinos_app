import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RestaurantTitleItem extends StatelessWidget {
  const RestaurantTitleItem({
    Key? key,
    required this.restaurant,
    required this.restaurantName,
    required this.address,
    required this.rate,
  }) : super(key: key);

  final String restaurant;
  final String restaurantName;
  final String address;
  final dynamic rate;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                restaurant,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              restaurantName,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            Text(
              address,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            Row(
              children: [
                RatingBarIndicator(
                  rating: rate,
                  unratedColor: Colors.white,
                  itemSize: 25,
                  itemBuilder: (context, index) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  rate.toString(),
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
    );
  }
}
