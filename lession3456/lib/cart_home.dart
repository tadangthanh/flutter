import 'package:flutter/material.dart';
import 'package:lession3456/baitapbuoi5_gridview.dart';
import 'package:lession3456/model/ProductItem.dart';
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
    Delete delete = Delete();
    Trash trash = Trash();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => delete,
        ),
        ChangeNotifierProvider(create: (context) => trash)
      ],
      child: Scaffold(
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
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            child: ElevatedButton(
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
                          ),
                          Builder(builder: (context) {
                            return Consumer<Delete>(
                                builder: (context, value, child) {
                              return ElevatedButton(
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  value.setIsDelete(!value.isDelete);
                                  if (!value.isDelete && trash.trash.isNotEmpty) {
                                    myCart.removeAllProduct(trash.trash);
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content:
                                          const Text("Deleted selected items"),
                                      action: SnackBarAction(
                                          label: "Undo",
                                          onPressed: () {
                                            myCart.addAllProduct(trash.trash);
                                            trash.clear();
                                          }),
                                    ));
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  side: const BorderSide(
                                      width: 2.0, color: Colors.red),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                ),
                                child: Text(
                                  !value.isDelete
                                      ? "Delete"
                                      : "Delete Selected",
                                  style: const TextStyle(color: Colors.red),
                                ),
                              );
                            });
                          })
                        ],
                      ),
                    ),
                    Expanded(child: buildMapCartView(myCart)),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

bool isNonNegativeNumeric(String input) {
  final regExp = RegExp(r'^\d+$');
  return regExp.hasMatch(input);
}

Widget buildMapCartView(MyCart myCart) {
  return Consumer<MyCart>(builder: (context, value, child) {
    Delete delete = Provider.of<Delete>(context, listen: true);
    Trash trash = Provider.of<Trash>(context, listen: true);
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
                  leading: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      delete.isDelete
                          ? Consumer<Delete>(builder: (context, value, child) {
                              return Checkbox(
                                  value: trash.trash
                                      .contains(myCart.products[index]),
                                  onChanged: (bool? value) {
                                    !trash.trash
                                            .contains(myCart.products[index])
                                        ? trash
                                            .addProduct(myCart.products[index])
                                        : trash.removeProduct(
                                            myCart.products[index]);
                                    // delete.setIsDelete(true);
                                  });
                            })
                          : Container(),
                      CircleAvatar(
                          child: Image.network(myCart.products[index].image)),
                    ],
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

class Delete extends ChangeNotifier {
  bool isDelete = false;

  bool get delete => isDelete;

  void setIsDelete(bool value) {
    isDelete = value;
    notifyListeners();
  }
}

class Trash extends ChangeNotifier {
  List<ProductItem> trash = [];

  List<ProductItem> get listTrash => trash;

  void addProduct(ProductItem p) {
    trash.add(p);
    notifyListeners();
  }

  void removeProduct(ProductItem p) {
    trash.remove(p);
    notifyListeners();
  }

  void clear() {
    trash.clear();
    notifyListeners();
  }
}
