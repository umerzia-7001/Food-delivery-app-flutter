import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../responsiveness/responsive_layout.dart';
import './splash_screen.dart';
import '../widgets/drawer.dart';
import 'items_overview.dart';

class homeScreen extends StatelessWidget {
  static const routeName = '/home';
  homeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: ResponsiveLayout(
        iphone: itemsOverview(),
        macbook: Row(
          children: [
            Expanded(
              flex: _size.width > 1200 ? 9 : 11,
              child: itemsOverview(),
            ),
            Expanded(
              flex: _size.width > 1200 ? 3 : 5,
              child: ECommerceDrawer(),
            ),
          ],
        ),
      ),
    );
  }
}
