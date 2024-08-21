import 'package:flutter/material.dart';

import 'baitapbuoi5_product_detail.dart';

void main() {
  runApp(const BaiTapGridView());
}

class BaiTapGridView extends StatelessWidget {
  const BaiTapGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BaiTapBuoi5GridHomePage(
        title: "MyShop",
      ),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              IconButton(
                icon: const Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
                tooltip: 'Show Snackbar',
                onPressed: () {},
              ),
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
                      "$productCount",
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
    );
  }

  int productCount = 1;
  List<String> productFavorite = <String>[];
  List<String> product = <String>['Demo', 'product name kk', 'Ao thun'];
  List<String> images = <String>["ao1", "ao2", "ao3"];
  List<double> prices = <double>[92.56, 100.92, 19.2];
  List<String> descriptions = <String>[
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, w",
    "t is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the li",
    "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words"
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
      itemCount: product.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BaiTapBuoi5ProductDetail(
                          desc: descriptions[index],
                          nameProduct: product[index],
                          image: images[index],
                          price: prices[index],
                        ),
                      ),
                    );
                  },
                  child: Image(
                    image: AssetImage("assets/${images[index]}.png"),
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
                                        .contains(product[index])) {
                                      productFavorite.add(product[index]);
                                    } else {
                                      productFavorite.remove(product[index]);
                                    }
                                  });
                                },
                                icon: Icon(
                                    productFavorite.contains(product[index])
                                        ? Icons.favorite
                                        : Icons.favorite_outline),
                                color: const Color(0xFF9C27B0)),
                          ),
                          Expanded(
                              child: Center(
                            child: Text(
                              product[index],
                              style: const TextStyle(color: Colors.white),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )),
                          Expanded(
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    productCount++;
                                  });
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
