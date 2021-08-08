import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class checkoutItem extends StatefulWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  checkoutItem(
    this.id,
    this.productId,
    this.price,
    this.quantity,
    this.title,
  );

  @override
  State<checkoutItem> createState() => _checkoutItemState();
}

class _checkoutItemState extends State<checkoutItem> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      elevation: 10,
      child: GlassmorphicContainer(
        height: deviceSize.height / 4.6,
        width: deviceSize.width,
        borderRadius: 0,
        blur: 10,
        alignment: Alignment.center,
        border: 2,
        linearGradient: LinearGradient(colors: [
          Colors.white24.withOpacity(0.2),
          Colors.white60.withOpacity(0.2)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderGradient: LinearGradient(colors: [
          Colors.indigo.withOpacity(0.5),
          Colors.indigo.withOpacity(0.5),
        ]),
        child: Container(
          padding: const EdgeInsets.all(0),
          margin: EdgeInsets.all(0),
          height: 130,
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    alignment: Alignment.center,
                    width: 130,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      alignment: Alignment.center,
                      image: AssetImage('assets/images/wings.jpg'),
                      fit: BoxFit.fill,
                    )),
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 30),
                      Row(
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              widget.title,
                              overflow: TextOverflow.fade,
                              softWrap: true,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 20),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          Text("Sub Total: "),
                          SizedBox(
                            width: 5,
                          ),
                          Text(widget.price.toString(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ))
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "Free Delivery",
                            style: TextStyle(color: Colors.amber),
                          ),
                          Spacer(),
                          Row(
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  setState() {
                                    cart.removeSingleItem(widget.productId);
                                  }
                                },
                                splashColor: Colors.redAccent.shade200,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50)),
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Icon(
                                      Icons.remove,
                                      color: Colors.redAccent,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(widget.quantity.toString()),
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              InkWell(
                                onTap: () {},
                                splashColor: Colors.lightBlue,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50)),
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.green,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
