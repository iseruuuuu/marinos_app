import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:marinos_app/constants/restaurant_constants.dart';

class YelpService {
  final String _apiKey = RestaurantConstants.restaurantApikey;
  final String _yelpApiUrl = 'https://api.yelp.com/v3/businesses/search';

  Future<List<dynamic>> getRestaurants() async {
    final response = await http.get(
      Uri.parse('$_yelpApiUrl?location=ShinYokohama'),
      headers: {'Authorization': 'Bearer $_apiKey'},
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      return result["businesses"];
    } else {
      throw Exception('Failed to load restaurant data');
    }
  }
}
