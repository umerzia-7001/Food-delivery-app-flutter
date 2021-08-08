
// developed by: Muhammad Umer Zia

import 'package:feed_me/providers/cart.dart';
import 'package:feed_me/providers/food.dart';
import 'package:feed_me/providers/orders.dart';
import 'package:feed_me/screens/add_foods.dart';
import 'package:feed_me/screens/carts_screen.dart';
import 'package:feed_me/screens/items_overview.dart';
import 'package:feed_me/screens/payment_screen.dart';
import 'screens/checkout_screen.dart';
import 'widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'helpers/colors.dart' as color;
import './screens/auth_screen.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import './screens/home_screen.dart';
import 'providers/auth_provider.dart';
import 'providers/foods.dart';
import '../screens/food_detail_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          // using in product overview screen
          value: Auth(tokens: '', userId: ''),
        ),
        ChangeNotifierProvider.value(
          // using in product overview screen
          value: Foods('', '', []),
        ),
        ChangeNotifierProvider.value(
          // using in product overview screen
          value: Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (context) => Orders('', '', []),
          update: (ctx, auth, previousOrders) => Orders(
            auth.token,
            auth.userId,
            previousOrders == null ? [] : previousOrders.orders,
          ),
        ),
        ChangeNotifierProvider.value(
          // using in product overview screen
          value: Food(
              id: '',
              category: '',
              description: '',
              name: '',
              price: '',
              image: '',
              ratings: 0),
        ),
        ChangeNotifierProxyProvider<Auth, Foods>(
          // moving parametrs from one provider to another
          create: (context) => Foods('', '', []),
          update: (ctx, auth, previousFoods) => Foods(
            auth.token, auth.userId,
            previousFoods == null ? [] : previousFoods.foods,
            // moving token and product list wrt token
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Feed Me',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              buttonTheme: const ButtonThemeData(
                buttonColor: Colors.indigo, //  <-- dark color
                textTheme: ButtonTextTheme
                    .primary, //  <-- this auto selects the right color
              ),
              brightness: Brightness.dark,
              primaryColor: Colors.indigo[400], // main theme color of the app
              accentColor: Colors.indigo,
              textTheme: const TextTheme(
                  headline1:
                      TextStyle(fontSize: 60.0, fontWeight: FontWeight.bold),
                  headline2:
                      TextStyle(fontSize: 32.0, fontStyle: FontStyle.italic),
                  bodyText1: TextStyle(fontSize: 16.0))),
          home: auth.authenticated ? auth_screen() : homeScreen(),
          routes: {
            homeScreen.routeName: (ctx) => homeScreen(),
            auth_screen.routeName: (ctx) => auth_screen(),
            food_detail.routeName: (ctx) => food_detail(),
            CartsScreen.routeName: (ctx) => CartsScreen(),
            checkoutScreen.routeName: (ctx) => checkoutScreen(),
            addFoodsScreen.routeName: (ctx) => addFoodsScreen(),
          },
        ),
      ),
    );
  }
}
