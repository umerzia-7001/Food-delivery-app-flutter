import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../helpers/colors.dart' as color;
import '../providers/cart.dart';
import 'package:flutter_checkout_payment/flutter_checkout_payment.dart';

class checkoutSection extends StatelessWidget {
  checkoutSection();

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final deviceSize = MediaQuery.of(context).size;
    return Material(
      color: Colors.black26,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Row(
                children: <Widget>[
                  Text(
                    "Total Amount : ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  Text(
                    cart.ttlAmount.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  )
                ],
              )),
          InkWell(
            child: Container(
              color: Theme.of(context).accentColor,
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                // leading: Icon(
                //  // FontAwesomeIcons.paypal,
                //   //color: Colors.indigo,
                // ),
                title: Text("Stripe"),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
          ),
          Container(
            color: Theme.of(context).accentColor,
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              // leading: Icon(
              //  // FontAwesomeIcons.paypal,
              //   //color: Colors.indigo,
              // ),
              title: Text("Paypal"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
          Container(
            color: Theme.of(context).accentColor,
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              // leading: Icon(
              //   FontAwesomeIcons.applePay,
              //   color: Colors.indigo,
              // ),
              title: Text("Apple Pay"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Material(
              color: Theme.of(context).accentColor,
              elevation: 1.0,
              child: InkWell(
                splashColor: Theme.of(context).accentColor,
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Checkout",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
