import 'package:feed_me/providers/foods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'food_item.dart';

class grid_view extends StatefulWidget {
  grid_view({Key? key}) : super(key: key);

  @override
  _grid_viewState createState() => _grid_viewState();
}

class _grid_viewState extends State<grid_view> {
  @override
  Widget build(BuildContext context) {
    final foods = Provider.of<Foods>(context).foods1;
    final screenSize = MediaQuery.of(context).size;

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: foods.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: foods[i], // filling with products list and displaying in grid
        child: food_item(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: screenSize.width >= 600 ? 2 : 1,
        childAspectRatio: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
    );
  }
}
