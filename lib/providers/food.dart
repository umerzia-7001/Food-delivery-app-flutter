import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Food extends ChangeNotifier{

  final String id;
  final String name;
  final String description;
  final String price;
  final String image;
  final String category;
  final int ratings;


  Food({ required this.category, required this.id,required this.description,required this.price, required this.image,required this.name,required this.ratings});

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        price: json['price'],
        image: json['image'],
        category: json['category'],
        ratings: json['ratings']);
  }


}
