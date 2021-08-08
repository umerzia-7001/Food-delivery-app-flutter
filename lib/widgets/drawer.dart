import 'package:feed_me/providers/auth_provider.dart';
import 'package:feed_me/screens/add_foods.dart';
import 'package:feed_me/screens/auth_screen.dart';
import 'package:feed_me/screens/carts_screen.dart';
import 'package:feed_me/screens/home_screen.dart';
import 'package:feed_me/screens/items_overview.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../responsiveness/responsive.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

import '../drawer/drawer_items.dart';

class ECommerceDrawer extends StatelessWidget {
  const ECommerceDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        padding: EdgeInsets.only(top: kIsWeb ? 20 : 0),
        color: Theme.of(context).accentColor,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: 80),
                DrawerItems(
                  onPressed: () {
                    selected:
                    false;
                    Navigator.of(context).pushNamed(
                      homeScreen.routeName,
                    );
                  },
                  title: "Main Menu ",
                  icon: Icons.food_bank_rounded,
                  number: 1,
                ),
                SizedBox(height: 20),
                DrawerItems(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      addFoodsScreen.routeName,
                    );
                  },
                  title: "Add Orders",
                  icon: Icons.fastfood,
                  number: 2,
                ),
                SizedBox(height: 20),
                DrawerItems(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      CartsScreen.routeName,
                    );
                  },
                  title: "View Cart",
                  icon: Icons.local_grocery_store,
                  number: 3,
                ),
                SizedBox(height: 20 * 2),
                ConstrainedBox(
                  constraints: BoxConstraints.tightFor(
                    width: 300,
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(
                            vertical: 20,
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                            Colors.white.withOpacity(0.8))),
                    child: Text(
                      "Log out",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    onPressed: () {
                      Provider.of<Auth>(context, listen: false).logout();

                      Navigator.of(context).pushNamed(
                        auth_screen.routeName,
                      );
                    },
                  ),
                ),
                SizedBox(height: 20 * 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
