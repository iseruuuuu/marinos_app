import 'package:json_annotation/json_annotation.dart';

part 'restaurant.g.dart';

@JsonSerializable()
class Restaurant {
  final String name;
  final String imageUrl;
  final double rating;
  final String phone;

  Restaurant({
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.phone,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) =>
      _$BusinessFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessToJson(this);
}
