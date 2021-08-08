import 'package:feed_me/providers/food.dart';
import 'package:feed_me/providers/foods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class addFoodsScreen extends StatefulWidget {
  static const routeName = '/addFoods';

  @override
  _addFoodsScreenState createState() => _addFoodsScreenState();
}

class _addFoodsScreenState extends State<addFoodsScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _priceController = TextEditingController();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Food(
    id: '',
    name: '',
    description: '',
    image: '',
    category: '',
    ratings: 0,
    price: '',
  );
  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context)!.settings.arguments as String;
      if (productId != null) {
        _editedProduct =
            Provider.of<Foods>(context, listen: false).findById(productId);
        _initValues = {
          'name': _editedProduct.name,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          'category': _editedProduct.category,
          'ratings': _editedProduct.ratings.toString(),
          'image': _editedProduct.image,
        };
        _imageUrlController.text = _editedProduct.image;
        _nameController.text = _editedProduct.name;
        _priceController.text = _editedProduct.price;
        _descriptionController.text = _editedProduct.description;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    _descriptionController.dispose();
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState!.validate(); // validating form
    if (!isValid) {
      return;
    }
    _form.currentState!.save(); // saving form state
    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<Foods>(context, listen: false).addFood(_editedProduct);
    } catch (error) {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An error occurred!'),
          content: Text('Something went wrong.'),
          actions: <Widget>[
            FlatButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text('Edit Food'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _initValues['name'],
                      decoration: InputDecoration(labelText: 'name'),
                      textInputAction: TextInputAction.next,
                      controller: _nameController,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please provide a value.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Food(
                          name: value!,
                          price: _editedProduct.price,
                          description: _editedProduct.description,
                          image: _editedProduct.image,
                          id: _editedProduct.id,
                          category: _editedProduct.category,
                          ratings: _editedProduct.ratings,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['price'],
                      decoration: InputDecoration(labelText: 'Price'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _priceFocusNode,
                      // controller: _priceController,
                      onFieldSubmitted: (_) {
                        // focus for next field
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },

                      onSaved: (value) {
                        // saving the form with object parameters recieved
                        _editedProduct = Food(
                          name: _editedProduct.name,
                          price: _editedProduct.price,
                          description: _editedProduct.description,
                          image: value!,
                          id: _editedProduct.id,
                          category: _editedProduct.category,
                          ratings: _editedProduct.ratings,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['description'],
                      decoration: InputDecoration(labelText: 'Description'),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionFocusNode,
                      // controller: _descriptionController,

                      onSaved: (value) {
                        _editedProduct = Food(
                          name: _editedProduct.name,
                          price: _editedProduct.price,
                          description: value!,
                          image: _editedProduct.image,
                          id: _editedProduct.id,
                          category: _editedProduct.category,
                          ratings: _editedProduct.ratings,
                        );
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(
                            top: 8,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          child: _imageUrlController.text.isEmpty
                              ? Text('Enter a URL')
                              : FittedBox(
                                  child: Image.network(
                                    _imageUrlController.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'Image URL'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            focusNode: _imageUrlFocusNode,
                            onFieldSubmitted: (_) {
                              _saveForm();
                            },
                            validator: (value) {},
                            onSaved: (value) {
                              _editedProduct = Food(
                                name: _editedProduct.name,
                                price: _editedProduct.price,
                                description: _editedProduct.description,
                                image: value!,
                                id: _editedProduct.id,
                                category: _editedProduct.category,
                                ratings: _editedProduct.ratings,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
