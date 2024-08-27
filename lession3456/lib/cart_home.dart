import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lession3456/model/ProductItem.dart';
import 'package:provider/provider.dart';

class CartHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CartHomeState();
  }
}

int countProductInCart(ProductItem product, List<ProductItem> mapCart) {
  return mapCart.where((item) => item == product).length;
}

class Cart extends ChangeNotifier {
  Map<ProductItem, int> cartList;


  Cart(this.cartList);

  void incrementProduct(ProductItem p) {
    if (cartList.containsKey(p)) {
      cartList[p] = cartList[p]! + 1;
    } else {
      cartList[p] = 1;
    }
    notifyListeners();
  }

  void decrementProduct(ProductItem p) {
    if (cartList.containsKey(p)) {
      cartList[p] = cartList[p]! - 1;
      notifyListeners();
    }
  }

  void deleteProduct(ProductItem p) {
    if (cartList.containsKey(p)) {
      cartList.remove(p);
      notifyListeners();
    }
  }

  void setQuantityProduct(ProductItem p, int quantity) {
    if (cartList.containsKey(p)) {
      cartList[p] = quantity;
      notifyListeners();
    }
  }
}

class CartHomeState extends State<CartHome> {
  Map<ProductItem, int> mapCart = {};


  @override
  Widget build(BuildContext context) {
    mapCart =
        ModalRoute.of(context)?.settings.arguments as Map<ProductItem, int>;
Cart cart =Cart(mapCart);
    return ChangeNotifierProvider<Cart>(
      create: (BuildContext context) {
        return cart;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context, mapCart);
            },
          ),
          title: const Text(
            "Your Cart",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.purple,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 0,
                            blurRadius: 0,
                            offset: const Offset(
                                0, 1), // changes position of shadow
                          ),
                        ]),
                    child: Row(
                      children: [
                        const Expanded(child: Text("Total")),
                        Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child:
                                Consumer<Cart>(builder: (context, cart, child) {
                                  double result =
                                  cart.cartList.entries.fold(0, (sum, entry) {
                                return sum + (entry.key.price * entry.value);
                              });
                              return Text(
                                "\$${double.parse(result.toStringAsFixed(2))}",
                                style:
                                    const TextStyle(color: Color(0xffd7abdf)),
                              );
                            })),
                        ElevatedButton(
                          onPressed: () {
                            FocusScope.of(context)
                                .unfocus(); // ẩn bàn phím khi click nút ordernow
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                          ),
                          child: const Text(
                            "ORDER NOW",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: buildMapCartView(cart)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

bool isNonNegativeNumeric(String input) {
  final regExp = RegExp(r'^\d+$');
  return regExp.hasMatch(input);
}

Widget buildMapCartView(Cart cart) {
  List<ProductItem> list = cart.cartList.keys.toList();
  Map<ProductItem,int> cartMap= cart.cartList;
  return ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        var countController =
            TextEditingController(text: "${cartMap[list[index]]}");
        return InkWell(
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 0,
                    blurRadius: 0,
                    offset: const Offset(0, 1), // changes position of shadow
                  ),
                ]),
            child: ListTile(
                leading: CircleAvatar(
                  child: Image.network(list[index].image),
                ),
                title: Text(list[index].name),
                subtitle: Text("Total: \$${list[index].price}"),
                trailing: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 0,
                                blurRadius: 2,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ]),
                        width: 30,
                        height: 30,
                        child: IconButton(
                            padding: EdgeInsets.zero,
                            color: Colors.white,
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            onPressed: () {
                              if (int.parse(countController.text) == 1) {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Thông báo'),
                                    content: const Text(
                                        'Bạn có chắc muốn xóa sản phẩm này không?.'),
                                    actions: [
                                      TextButton(
                                        child: const Text('Đóng'),
                                        onPressed: () {
                                          Navigator.of(context).pop(false);
                                        },
                                      ),
                                      TextButton(
                                        child: const Text('Có'),
                                        onPressed: () {
                                          cart.deleteProduct(list[index]);
                                          Navigator.of(context).pop(true);
                                        },
                                      )
                                    ],
                                  ),
                                );
                              } else {
                                Cart cart =
                                    Provider.of<Cart>(context, listen: false);
                                countController.text =
                                    "${int.parse(countController.text) - 1}";
                                cart.decrementProduct(list[index]);
                              }
                            },
                            icon: const Icon(
                              Icons.remove,
                              size: 20,
                            ))),
                    SizedBox(
                      width: 30,
                      child: TextField(
                        onChanged: (text) {
                          if (isNonNegativeNumeric(countController.text)) {
                            countController.text = text;
                            if (int.parse(text) == 0) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Thông báo'),
                                  content: const Text(
                                      'Bạn có chắc muốn xóa sản phẩm này không?.'),
                                  actions: [
                                    TextButton(
                                      child: const Text('Đóng'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: const Text('Có'),
                                      onPressed: () {
                                        cart.deleteProduct(list[index]);
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                ),
                              );
                            } else {
                              Cart cart =
                                  Provider.of<Cart>(context, listen: false);
                              cart.setQuantityProduct(
                                  list[index], int.parse(text));
                            }
                          }else if(!isNonNegativeNumeric(countController.text) && text.trim()!=""){
                            countController.text="1";
                          }
                        },
                        controller: countController,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          isDense: true,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 0,
                              blurRadius: 2,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ]),
                      width: 30,
                      height: 30,
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          color: Colors.white,
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          onPressed: () {
                            if (int.parse(countController.text) >= 1) {
                              Cart cart =
                                  Provider.of<Cart>(context, listen: false);
                              cart.incrementProduct(list[index]);
                              countController.text =
                                  "${int.parse(countController.text) + 1}";
                            }
                          },
                          icon: const Icon(
                            Icons.add,
                            size: 20,
                          )),
                    ),
                  ],
                )),
          ),
        );
      });
}
