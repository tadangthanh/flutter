import 'package:flutter/material.dart';
import 'package:lession3456/model/ProductItem.dart';
import 'package:lession3456/shop_product_update_screen.dart';

void main() {
  runApp(FlowUI());
}

class FlowUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "FLow UI",
      home: FlowUIHomePage(),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/add': (context) => const EditProductHomePage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == "/edit") {
          return MaterialPageRoute<void>(
              settings: settings,
              builder: (BuildContext context) {
                return const EditProductHomePage();
              });
        } else {
          return null;
        }
      },
    );
  }
}

class FlowUIHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FlowUIHomePageState();
  }
}

class FlowUIHomePageState extends State<FlowUIHomePage> {
  late Future<List<ProductItem>> products;

  @override
  void initState() {
    super.initState();
    products = initProducts();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          flexibleSpace: const Padding(
            padding: EdgeInsets.only(top: 30),
            child: Center(
                child: Text(
              "Your Products",
              style: TextStyle(color: Colors.white, fontSize: 25),
            )),
          ),
          backgroundColor: Colors.blue,
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: IconButton(
                  onPressed: () async {
                    final productAdd =
                        await Navigator.pushNamed(context, "/add")
                            as ProductItem?;
                    setState(() {
                      if (productAdd != null) {
                        products.then((onValue) {
                          onValue.add(productAdd);
                        });
                      }
                    });
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  )),
            ),
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: futureBuilderWithListView(),
            ),
          ),
        ),
      ),
    );
  }

  Widget futureBuilderWithListView() {
    return FutureBuilder(
        future: products,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return listViewShowData(snapshot.data!);
          }
          return const CircularProgressIndicator();
        });
  }

  Widget listViewShowData(List<ProductItem> list) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        var product = list[index];
        return ListTile(
            leading: CircleAvatar(
              child: Image.network(product.image),
            ),
            title: Text(product.name),
            subtitle: Text(
              product.description,
              style: const TextStyle(overflow: TextOverflow.ellipsis),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () async {
                    final result = await Navigator.pushNamed(context, "/edit",
                        arguments: product) as ProductItem?;
                    setState(() {
                      if (result != null) {
                        products.then((onValue) {
                          onValue[index] = result;
                        });
                      }
                    });
                  },
                  style: TextButton.styleFrom(iconColor: Colors.purple),
                ),
                IconButton(
                  icon: const Icon(Icons.business_outlined),
                  onPressed: () {},
                  style: TextButton.styleFrom(iconColor: Colors.green),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      products.then((onValue) {
                        onValue.remove(product);
                      });
                    });
                  },
                  style: TextButton.styleFrom(iconColor: Colors.red),
                ),
              ],
            ));
      },
    );
  }
}

Future<List<ProductItem>> initProducts() async {
  return [
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
    // Add more products here
  ];
}
