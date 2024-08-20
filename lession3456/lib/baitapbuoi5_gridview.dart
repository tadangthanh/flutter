import 'package:flutter/material.dart';

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
  List<String> product = <String>['Demo', 'product name kk', 'Ao thun'];
  List<String> images = <String>["ao1", "ao2", "ao3"];

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
              Image(
                image: AssetImage("assets/${images[index]}.png"),
              ),
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
                                onPressed: () {},
                                icon: Icon(Icons.favorite_border),
                                color: Color(0xFF9C27B0)),
                          ),
                          Expanded(
                              child: Center(
                            child: Text(
                              "${product[index]}",
                              style: TextStyle(color: Colors.white),
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
                                icon: Icon(Icons.shopping_cart),
                                color: Color(0xFF9C27B0)),
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
