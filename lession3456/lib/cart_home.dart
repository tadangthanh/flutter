import 'package:flutter/material.dart';
import 'package:lession3456/baitapbuoi5_gridview.dart';
import 'package:provider/provider.dart';

class CartHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CartHomeState();
  }
}

class CartHomeState extends State<CartHome> {
  @override
  Widget build(BuildContext context) {
    MyCart myCart = Provider.of<MyCart>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
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
                            child: Consumer<MyCart>(
                                builder: (context, cart, child) {
                              return Text(
                                "\$${cart.totalPrice}",
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
                  Expanded(child: buildMapCartView(myCart)),
                ],
              ),
            ),
          ),
        ));
  }
}

bool isNonNegativeNumeric(String input) {
  final regExp = RegExp(r'^\d+$');
  return regExp.hasMatch(input);
}

Widget buildMapCartView(MyCart myCart) {
  return Consumer<MyCart>(builder: (context, value, child) {
    return ListView.builder(
        itemCount: myCart.products.length,
        itemBuilder: (BuildContext context, int index) {
          var countController =
              TextEditingController(text: "${myCart.products[index].quantity}");
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
                    child: Image.network(myCart.products[index].image),
                  ),
                  title: Text(myCart.products[index].name),
                  subtitle: Text("Total: \$${myCart.products[index].price}"),
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
                                            myCart.removeProduct(
                                                myCart.products[index]);
                                            Navigator.of(context).pop(true);
                                          },
                                        )
                                      ],
                                    ),
                                  );
                                } else {
                                  myCart.decrementQuantity(
                                      myCart.products[index]);
                                  countController.text =
                                      "${int.parse(countController.text) - 1}";
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
                                          myCart.removeProduct(
                                              myCart.products[index]);
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  ),
                                );
                              } else {
                                myCart.setQuantity(
                                    myCart.products[index], int.parse(text));
                              }
                            } else if (!isNonNegativeNumeric(
                                    countController.text) &&
                                text.trim() != "") {
                              countController.text = "1";
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
                                countController.text =
                                    "${int.parse(countController.text) + 1}";
                                myCart
                                    .incrementQuantity(myCart.products[index]);
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
  });
}
