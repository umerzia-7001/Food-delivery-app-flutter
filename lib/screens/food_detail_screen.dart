// ignore: file_names
// ignore_for_file: camel_case_types

import 'dart:ui';
import 'package:feed_me/providers/cart.dart';

import '../helpers/colors.dart' as colors;
import 'package:feed_me/providers/food.dart';
import 'package:feed_me/providers/foods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../helpers/style.dart';

class food_detail extends StatefulWidget {
  food_detail({Key? key}) : super(key: key);

  static const routeName = '/details';

  @override
  _food_detailState createState() => _food_detailState();
}

class _food_detailState extends State<food_detail>
    with SingleTickerProviderStateMixin {
  final String imagePath = '';

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..forward();
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(0.5, 0.0),
    end: const Offset(0.0, 0.0),
  ).animate(CurvedAnimation(
    //  reverseCurve: Curve.,
    parent: _controller,
    curve: Curves.easeInCubic,
  ));

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final foodId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedFoods = Provider.of<Foods>(
      context,
      listen: false,
    ).findById(foodId);

    final cart = Provider.of<Cart>(
      context,
      listen: false,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: ConstrainedBox(
        constraints:
            BoxConstraints(minWidth: MediaQuery.of(context).size.width - 40),
        child: ElevatedButton(
          onPressed: () => {
            Provider.of<Cart>(context, listen: false).addToCart(
                foodId, double.parse(loadedFoods.price), loadedFoods.name),
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              PrimaryText(
                text: 'Add to Cart',
                fontWeight: FontWeight.w600,
                size: 18,
              ),
              Icon(Icons.shopping_cart),
            ],
          ),
          style: ElevatedButton.styleFrom(
              primary: Theme.of(context).accentColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              textStyle:
                  const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: ListView(
        children: [
          customAppBar(context),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SlideTransition(
                      textDirection: TextDirection.ltr,
                      position: _offsetAnimation,
                      child: Padding(
                        padding: EdgeInsets.only(left: 30, top: 10),
                        child: Hero(
                          tag: loadedFoods.id,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            width: MediaQuery.of(context).size.width /
                                (kIsWeb ? 3 : 2),
                            child: ClipPath(
                              clipper: CustomClipPath(),
                              //borderRadius: BorderRadius.all(30),
                              child: Image.asset(loadedFoods.image,
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // ignore: prefer_const_constructors
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ignore: prefer_const_constructors
                            PrimaryText(
                              text: 'Category',
                              color: Theme.of(context).accentColor,
                              size: 16,
                              fontWeight: FontWeight.w700,
                            ),
                            const SizedBox(
                              height: 8,
                            ),

                            PrimaryText(
                                color: Theme.of(context).accentColor,
                                text: 'not spicy',
                                fontWeight: FontWeight.w600),
                            const SizedBox(
                              height: 20,
                            ),
                            PrimaryText(
                              text: 'Ratings',
                              color: Theme.of(context).accentColor,
                              size: 16,
                              fontWeight: FontWeight.w700,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            IconTheme(
                              data: IconThemeData(
                                color: Colors.amber,
                                size: 18,
                              ),
                              child: StarDisplay(value: 3),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            PrimaryText(
                              text: 'Delivery in',
                              color: Theme.of(context).accentColor,
                              size: 16,
                              fontWeight: FontWeight.w700,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            PrimaryText(
                                color: Theme.of(context).accentColor,
                                text: '30 min',
                                fontWeight: FontWeight.w500),
                          ]),
                    ),
                    Column(
                      children: [
                        SizedBox(
                            width: deviceSize.width / 3,
                            child: ingredientCard(loadedFoods)),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //  Icon(Icons.money),
                              PrimaryText(
                                text: loadedFoods.price,
                                size: 48,
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context).accentColor,
                                height: 1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                PrimaryText(
                    color: Theme.of(context).accentColor,
                    text: 'Ingredients',
                    fontWeight: FontWeight.w700,
                    size: 22),
                const SizedBox(
                  height: 15,
                ),
                PrimaryText(
                    color: Theme.of(context).accentColor,
                    text: loadedFoods.description,
                    fontWeight: FontWeight.w400,
                    size: 16),
              ],
            ),
          ),
          const SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }

  Container ingredientCard(Food loadedFoods) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      margin: EdgeInsets.only(
        right: 10,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).accentColor,
          boxShadow: [
            BoxShadow(blurRadius: 10, color: Colors.black12),
          ]),
      child: Align(
        alignment: Alignment.center,
        child: PrimaryText(
          color: Colors.white,
          text: loadedFoods.name,
          size: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Padding customAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(width: 1, color: Colors.black12)),
              child: Icon(
                Icons.chevron_left,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  var radius = 10.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 4, size.height - 40, size.width / 2, size.height - 20);
    path.quadraticBezierTo(
        3 / 4 * size.width, size.height, size.width, size.height - 30);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class StarDisplay extends StatelessWidget {
  final int value;
  const StarDisplay({Key? key, this.value = 0})
      : assert(value != null),
        super(key: key);
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
