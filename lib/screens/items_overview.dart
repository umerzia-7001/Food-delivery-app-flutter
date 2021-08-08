// ignore_for_file: camel_case_types
import 'package:flutter/painting.dart';

import '../helpers/colors.dart' as colors;
import 'package:feed_me/providers/food.dart';
import 'package:feed_me/providers/cart.dart';
import 'package:feed_me/providers/orders.dart';
import 'package:feed_me/providers/foods.dart';
import 'package:feed_me/responsiveness/responsive_layout.dart';
import 'package:feed_me/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import '../providers/foods.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../widgets/grid_view.dart';
import '../helpers/style.dart';

class itemsOverview extends StatefulWidget {
  itemsOverview({Key? key}) : super(key: key);

  @override
  _itemsOverviewState createState() => _itemsOverviewState();
}

class _itemsOverviewState extends State<itemsOverview> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final CarouselController _controller = CarouselController();

  static const routeName = '/overview';

  List _isHovering = [false, false, false, false, false, false, false];
  List _isSelected = [true, false, false, false, false, false, false];

  int _current = 0;

// adding manually or can be saved in database and fetched.
  final List<String> images = [
    'assets/images/offers/offer1.jpg',
    'assets/images/offers/offer2.jpg',
    'assets/images/offers/offer3.jpg',
    'assets/images/offers/offer4.jpg',
    'assets/images/offers/offer5.jpg',
  ];

  List<Widget> generateImageTiles(screenSize) {
    return images
        .map(
          (element) => ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.asset(
              element,
              fit: BoxFit.cover,
            ),
          ),
        )
        .toList();
  }

  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<Foods>(context).fetchFoods().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }
  // fetching foods

  @override
  Widget build(BuildContext context) {
    final double kPadding = 20;
    final screenSize = MediaQuery.of(context).size;
    var imageSliders = generateImageTiles(screenSize);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      key: _scaffoldKey,
      endDrawer: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 250),
        child: ECommerceDrawer(),
      ),
      body: Container(
        height: screenSize.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: screenSize.width > 600 ? 3 : 2,
              child: Row(
                children: [
                  Spacer(),
                  if (ResponsiveLayout.isIphone(context))
                    IconButton(
                      icon: Icon(Icons.menu),
                      onPressed: () {
                        _scaffoldKey.currentState!.openEndDrawer();
                      },
                    ),
                ],
              ),
            ),
            Expanded(
              flex: screenSize.width > 600 ? 5 : 4,
              child: Stack(
                children: [
                  CarouselSlider(
                    items: imageSliders,
                    options: CarouselOptions(
                        height: 200,
                        viewportFraction: 0.3,
                        autoPlay: true,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        aspectRatio: 2,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }),
                    carouselController: _controller,
                  ),
                  AspectRatio(
                    aspectRatio: 2,
                    child: Center(
                      child: Text(
                        '', // can add text here
                        style: TextStyle(
                          letterSpacing: 8,
                          decoration: TextDecoration.none,
                          fontFamily: 'Electrolize',
                          fontSize: screenSize.width / 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 10, left: 5, bottom: 20),
                child: PrimaryText(
                    text: 'Popular',
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    size: 22),
              ),
            ),
            Expanded(
                flex: screenSize.width > 600 ? 7 : 6,
                child: Container(
                  color: Colors.black12,
                  child: grid_view(),
                )),
          ],
        ),
      ),
    );
  }
}

class popularFoodCard extends StatefulWidget {
  popularFoodCard({Key? key}) : super(key: key);

  @override
  _popularFoodCardState createState() => _popularFoodCardState();
}

class _popularFoodCardState extends State<popularFoodCard> {
  final name = 'pizza';
  final weight = '1.5 lbs';
  final star = '4 star';
  final String imagePath = 'assets/images/placeholder.jpg';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => FoodDetail(imagePath)))
      },
      child: Container(
        margin: EdgeInsets.only(right: 25, left: 20, top: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black12)],
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 25, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.black12,
                            size: 20,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'top of the week',
                          )
                        ],
                      ),
                      SizedBox(height: 15),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.2,
                        child: Text(name),
                      ),
                      Text(weight),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 45, vertical: 20),
                      decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: const Radius.circular(20),
                            topRight: const Radius.circular(20),
                          )),
                      child: Icon(Icons.add, size: 20),
                    ),
                    SizedBox(width: 20),
                    SizedBox(
                      child: Row(
                        children: [
                          Icon(Icons.star, size: 12),
                          SizedBox(width: 5),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              transform: Matrix4.translationValues(30.0, 25.0, 0.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    const BoxShadow(color: Colors.black26, blurRadius: 20)
                  ]),
              child: Hero(
                tag: imagePath,
                child: Image.asset(imagePath,
                    width: MediaQuery.of(context).size.width / 2.9),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
