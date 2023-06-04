import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:marinos_app/ui/restaurant/detail/restaurant_detail_screen.dart';
import 'package:marinos_app/ui/restaurant/restaurant_provider.dart';

class RestaurantScreen extends ConsumerWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restaurantListAsyncValue = ref.watch(restaurantProvider);
    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: restaurantListAsyncValue.when(
        data: (restaurants) {
          return ListView.builder(
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(),
                  ),
                ),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RestaurantDetailScreen(
                          restaurants: restaurants,
                          index: index,
                        ),
                      ),
                    );
                  },
                  leading: restaurants[index]['image_url'] != ""
                      ? Image.network(
                          '${restaurants[index]['image_url']}',
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          width: 80,
                          height: 80,
                          color: Colors.grey.shade300,
                          child: const Icon(Icons.fastfood),
                        ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                  ),
                  title: Text(
                    restaurants[index]['name'],
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text(
                    restaurants[index]['location']['address1'],
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => const Center(child: Text('An error occurred')),
      ),
    );
  }
}
