import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../responsiveness/responsive_layout.dart';
import '../widgets/drawer.dart';

class ECommerceItems extends StatefulWidget {
  const ECommerceItems({
    Key? key,
  }) : super(key: key);

  @override
  _ECommerceItemsState createState() => _ECommerceItemsState();
}

class _ECommerceItemsState extends State<ECommerceItems> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 250),
        child: ECommerceDrawer(),
      ),
      body: Container(
        padding: EdgeInsets.only(top: kIsWeb ? 20 : 0),
        color: Theme.of(context).accentColor,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  // ignore: prefer_const_constructors
                  SizedBox(
                    width: 20,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.shopping_bag_outlined,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 4),
                      child: TextField(
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          hintText: "Search",
                          fillColor: Colors.white.withOpacity(0.5),
                          filled: true,
                          // ignore: prefer_const_constructors
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(20 * 0.70),
                            child: Icon(Icons.search),
                          ),
                          // ignore: prefer_const_constructors
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (!ResponsiveLayout.isMacbook(context))
                    IconButton(
                      icon: Icon(Icons.menu),
                      onPressed: () {
                        _scaffoldKey.currentState!.openEndDrawer();
                      },
                    ),
                  SizedBox(width: 20 / 2)
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Sellar eCommerce",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Text('hello'),
            ],
          ),
        ),
      ),
    );
  }
}
