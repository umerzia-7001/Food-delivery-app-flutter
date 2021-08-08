import '../providers/cart.dart';
import '../widgets/checkout_item.dart' show checkoutItem;
import '../widgets/checkout_section.dart' show checkoutSection;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../helpers/colors.dart' as colors;

class checkoutScreen extends StatelessWidget {
  static const routeName = "/checkout";
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    final cart = Provider.of<Cart>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Theme.of(context).accentColor,
          title: Text('Checkout'),
        ),
        body: Column(
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (ctx, i) => ConstrainedBox(
                  constraints: BoxConstraints(
                      minWidth: 100,
                      minHeight: 100,
                      maxWidth: deviceSize.width,
                      maxHeight: deviceSize.height / 4.6),
                  child: checkoutItem(
                    cart.items.values.toList()[i].id,
                    cart.items.keys.toList()[i],
                    cart.items.values.toList()[i].price,
                    cart.items.values.toList()[i].quantity,
                    cart.items.values.toList()[i].name,
                  ),
                ),
              ),
            ),
            checkoutSection(),
          ],
        ));
  }
}
