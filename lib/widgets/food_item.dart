// ignore_for_file: camel_case_types
import 'dart:ui';
import 'package:feed_me/providers/cart.dart';

import '../screens/food_detail_screen.dart';
import 'package:feed_me/providers/food.dart';
import 'package:feed_me/providers/foods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../helpers/style.dart';

class food_item extends StatefulWidget {
  food_item({Key? key}) : super(key: key);

  @override
  _food_itemState createState() => _food_itemState();
}

class _food_itemState extends State<food_item> {
  final String imagePath = 'assets/images/placeholder.jpg';

  @override
  Widget build(BuildContext context) {
    int rating = 5;
    final food = Provider.of<Food>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              food_detail.routeName,
              arguments: food.id,
            );
          },
          child: Container(
            margin: EdgeInsets.only(right: 0, left: 0, top: 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black12)],
              color: Colors.white,
            ),
            child: Hero(
              tag: food.id,
              child: FadeInImage(
                placeholder: AssetImage(imagePath),
                image: AssetImage(food.image),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.white,
          leading: Consumer<Food>(
            // getting individual product with particular id
            // ignore: prefer_const_constructors
            builder: (ctx, product, _) => IconTheme(
              // ignore: prefer_const_constructors
              data: IconThemeData(
                color: Colors.amber,
                size: 18,
              ),
              child: StarDisplay(value: food.ratings),
            ),
          ),
          title: FittedBox(
            fit: BoxFit.scaleDown,
            child: PrimaryText(
              text: food.name,
              size: 22,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).accentColor,
            ),
          ),
          trailing: IconButton(
            icon: Icon(Icons.add, size: 22),
            onPressed: () {
              Provider.of<Cart>(context, listen: false)
                  .addToCart(food.id, double.parse(food.price), food.name);
            },
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}

class StarDisplay extends StatelessWidget {
  final int value;
  const StarDisplay({Key? key, this.value = 0}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < value ? Icons.star : Icons.star_border,
        );
      }),
    );
  }
}
