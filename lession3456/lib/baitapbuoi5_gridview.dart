import 'package:flutter/material.dart';
import 'package:lession3456/cart_home.dart';
import 'package:lession3456/model/ProductItem.dart';

import 'baitapbuoi5_product_detail.dart';

void main() {
  runApp(const BaiTapGridView());
}

class BaiTapGridView extends StatelessWidget {
  const BaiTapGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const BaiTapBuoi5GridHomePage(
        title: "MyShop",
      ),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/cart': (context) => CartHome(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == "/cart") {
          return MaterialPageRoute<void>(
              settings: settings,
              builder: (BuildContext context) {
                return CartHome();
              });
        } else {
          return null;
        }
      },
    );
  }
}

class BaiTapBuoi5GridHomePage extends StatefulWidget {
  final String title;

  const BaiTapBuoi5GridHomePage({super.key, required this.title});

  @override
  State<StatefulWidget> createState() {
    return BaiTapBuoi5GridState();
  }
}

class BaiTapBuoi5GridState extends State<BaiTapBuoi5GridHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget buildMenu(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
          ),
          ListTile(
            selected: _selectedIndex == 1,
            title: const Text('Item 1'),
            onTap: () {
              _onItemTapped(1);
              Navigator.pop(context);
            },
          ),
          ListTile(
            selected: _selectedIndex == 2,
            title: const Text('Item 2'),
            onTap: () {
              _onItemTapped(2);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: buildMenu(context),
        // endDrawer: buildCartHome(context),
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                color: Colors.white,
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              tooltip: 'Show Snackbar',
              onPressed: () {},
            ),
            Stack(
              children: [
                Builder(builder: (BuildContext context) {
                  return IconButton(
                    icon: const Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                    tooltip: 'Show Snackbar',
                    onPressed: () async {
                      final result = await Navigator.pushNamed(context, "/cart",
                          arguments: cartList) as Map<ProductItem, int>;
                      setState(() {
                        cartList = result;
                      });
                    },
                  );
                }),
                Positioned(
                  top: 5,
                  right: 11,
                  child: Container(
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Center(
                      child: Text(
                        "${cartList.length}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
          title: Text(
            widget.title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        body: Center(
          child: buildGirdProduct(),
        ),
      ),
    );
  }

  List<ProductItem> productFavorite = <ProductItem>[];
  Map<ProductItem, int> cartList = {};
  List<ProductItem> products = [
    ProductItem.name(
      id: 1,
      name: 'Product 1',
      image:
          'https://i.natgeofe.com/n/4f5aaece-3300-41a4-b2a8-ed2708a0a27c/domestic-dog_thumb_square.jpg',
      price: 29.99,
      description: 'This is the description for product 1.',
    ),
    ProductItem.name(
      id: 2,
      name: 'Product 2',
      image:
          'https://i.natgeofe.com/n/4f5aaece-3300-41a4-b2a8-ed2708a0a27c/domestic-dog_thumb_square.jpg',
      price: 59.99,
      description: 'This is the description for product 2.',
    ),
    ProductItem.name(
      id: 1,
      name: 'Product 3',
      image:
          'https://i.natgeofe.com/n/4f5aaece-3300-41a4-b2a8-ed2708a0a27c/domestic-dog_thumb_square.jpg',
      price: 29.99,
      description: 'This is the description for product 1.',
    ),
    ProductItem.name(
      id: 2,
      name: 'Product 4',
      image:
          'https://i.natgeofe.com/n/4f5aaece-3300-41a4-b2a8-ed2708a0a27c/domestic-dog_thumb_square.jpg',
      price: 59.99,
      description: 'This is the description for product 2.',
    ),
  ];

  Widget buildGirdProduct() {
    return GridView.builder(
      primary: false,
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
      ),
      itemCount: products.length,
      itemBuilder: (BuildContext context, int index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Stack(
            children: [
              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BaiTapBuoi5ProductDetail(
                          productItem: products[index],
                        ),
                      ),
                    );
                  },
                  child: Image(
                    image: NetworkImage(products[index].image),
                  )),
              Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.8),
                    ),
                    width: 100,
                    height: 50,
                    child: Center(
                      child: Row(
                        children: [
                          Expanded(
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (!productFavorite
                                        .contains(products[index])) {
                                      productFavorite.add(products[index]);
                                    } else {
                                      productFavorite.remove(products[index]);
                                    }
                                  });
                                },
                                icon: Icon(
                                    productFavorite.contains(products[index])
                                        ? Icons.favorite
                                        : Icons.favorite_outline),
                                color: const Color(0xFF9C27B0)),
                          ),
                          Expanded(
                              child: Center(
                            child: Text(
                              products[index].name,
                              style: const TextStyle(color: Colors.white),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )),
                          Expanded(
                            child: IconButton(
                                onPressed: () {
                                  if (cartList[products[index]] == null) {
                                    setState(() {
                                      cartList[products[index]] = 1;
                                    });
                                  }
                                },
                                icon: const Icon(Icons.shopping_cart),
                                color: const Color(0xFF9C27B0)),
                          )
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        );
      },
    );
  }
}
