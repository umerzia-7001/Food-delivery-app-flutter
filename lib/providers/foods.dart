import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import './food.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class Foods extends ChangeNotifier {
  List<Food> _foods = [];

  Foods(this.authToken, this.userID, this._foods);

  final String authToken; // transfered from auth provider
  final String userID;

  // example list for manual testing
  List<Food> _foods1 = [
    Food(
      id: 'p0',
      name: 'pasta',
      category: '',
      description:
          'Pasta is a very good substitute to rice, bread and other starchy foods because it can get you a long way without feeling hungry. Just toss some vegetables to make a salad, served with your choice of dressing such as lemon vinaigrette. Alternatively, you can serve it with your favorite homemade pasta sauce such as pesto sauce, tomato-based sauce, cream-based sauce, or oil-based sauce.',
      price: '49.99',
      image: 'assets/images/pasta.jpg',
      ratings: 5,
    ),
    Food(
      id: 'p1',
      name: 'Spagetti',
      description:
          'Filipino Spaghetti is the Pinoy version of Spaghetti with meat sauce. This version has a sweet tomato based sauce with lots of meat ingredients such as ground pork, luncheon meat, and hotdogs. It is often served during kid’s birthday parties along with some yummy fried chicken and cake.',
      price: '49.99',
      image: 'assets/images/spagetti.jpg',
      category: 'spicy',
      ratings: 4,
    ),
    Food(
      id: 'p2',
      name: 'Wings',
      description:
          'Add half the chicken wing parts to the oil and fry them until theyre golden brown and fully cooked, 5 to 7 minutes. Remove and drain on paper towels. Repeat with the other half of the wing parts. In a saucepan, heat the cayenne sauce and butter over medium-low heat. Add the Worcestershire and hot sauce. Let it bubble up, and then turn off the heat. Place the wings in an ovenproof dish and pour the hot sauce over the top. Toss to coat, and then bake in the oven for 15 minutes. ',
      price: '65',
      category: 'spicy',
      image: 'assets/images/wings.jpg',
      ratings: 4,
    ),
    Food(
      id: 'p3',
      category: 'not spicy',
      name: 'fried chicken',
      description:
          'Southern fried chicken, also known simply as fried chicken, is a dish consisting of chicken pieces that have been coated with seasoned flour or batter and pan-fried, deep fried, pressure fried, or air fried. The breading adds a crisp coating or crust to the exterior of the chicken while retaining juices in the meat. Broiler chickens are most commonly used.',
      price: '19.99',
      image: 'assets/images/fried-chicken.jpg',
      ratings: 3,
    ),
  ];

  List<Food> get foods1 {
    return [..._foods1];
  }

  List<Food> get foods {
    return [..._foods];
  }

  // search list by id
  Food findById(String id) {
    return _foods1.firstWhere((prod) => prod.id == id);
  }

  // fetching food items
  Future<void> fetchFoods([bool filterByUser = false]) async {
    final filterString = 'orderBy="creatorId"&equalTo="$userID"';

    final auths = int.parse(authToken);
    final url = Uri.parse(
        'https://feed-me-cf20b-default-rtdb.asia-southeast1.firebasedatabase.app/foods.json?auth=$authToken');

    try {
      final response = await http.get(url);

      final responseData = json.decode(response.body) as Map<String, dynamic>;

      if (responseData == null) {
        return;
      }

      final List<Food> loadedFoods = [];

      responseData.forEach((prodId, prodData) {
        loadedFoods.add(Food(
          id: prodId,
          name: prodData['name'],
          description: prodData['description'],
          price: prodData['price'],
          category: prodData['category'],
          image: prodData['image'],
          ratings: prodData['ratings'],
        ));
      });

      _foods = loadedFoods;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  // adding food items
  Future<void> addFood(Food food) async {
    final url = Uri.parse(
        'https://feed-me-cf20b-default-rtdb.asia-southeast1.firebasedatabase.app/foods.json?');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'name': food.name,
          'description': food.description,
          'image': food.image,
          'price': food.price,
          'category': food.category,
          'creatorId': userID,
          'token': authToken,
          'ratings': food.ratings,
        }),
      );

      final newFood = Food(
          category: food.category,
          id: json.decode(response.body)['name'],
          description: food.description,
          price: food.price,
          image: food.image,
          ratings: food.ratings,
          name: food.name);
      _foods.add(newFood);

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateFood(String id, Food food) async {
    final itemIndex = _foods.indexWhere((element) => element.id == id);
    if (itemIndex >= 0) {
      final url = Uri.parse(
          'https://feed-me-cf20b-default-rtdb.asia-southeast1.firebasedatabase.app/foods/$id.json?');

      final response = http.patch(url,
          body: json.encode({
            'name': food.name,
            'description': food.description,
            'image': food.image,
            'price': food.price,
            'category': food.category,
            'ratings': food.ratings,
          }));
      _foods[itemIndex] = food;
      notifyListeners();
    } else {
      print('empty update');
    }
  }

  Future<void> deleteFood(String id) async {
    final url = Uri.parse(
        'https://feed-me-cf20b-default-rtdb.asia-southeast1.firebasedatabase.app/foods/$id.json?auth=$authToken');

    notifyListeners();

    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
  }
}
