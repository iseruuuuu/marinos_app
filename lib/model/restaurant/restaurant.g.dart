// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Restaurant _$BusinessFromJson(Map<String, dynamic> json) => Restaurant(
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      rating: (json['rating'] as num).toDouble(),
      phone: json['phone'] as String,
    );

Map<String, dynamic> _$BusinessToJson(Restaurant instance) => <String, dynamic>{
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'rating': instance.rating,
      'phone': instance.phone,
    };
