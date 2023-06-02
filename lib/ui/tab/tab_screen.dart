import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:marinos_app/ui/restaurant/restaurant_screen.dart';
import 'package:marinos_app/ui/tab/tab_provider.dart';
import 'package:marinos_app/ui/transportation/transportation_screen.dart';
import 'package:marinos_app/ui/weather/weather_screen.dart';

class TabScreen extends ConsumerWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider);
    return Scaffold(
      body: [
        const RestaurantScreen(),
        TransportationScreen(),
        WeatherScreen(),
      ][selectedIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(width: 0, color: Colors.black),
          ),
        ),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          iconSize: 30,
          currentIndex: selectedIndex,
          onTap: (index) {
            ref.read(selectedIndexProvider.notifier).state = index;
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.fastfood),
              label: 'レストラン',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.train),
              label: '交通情報',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sunny),
              label: '天気',
            ),
          ],
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
