import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lession3456/model/ProductItem.dart';

class CartHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CartHomeState();
  }
}
int countProductInCart(ProductItem product, List<ProductItem> mapCart) {
  return mapCart.where((item) => item == product).length;
}


class CartHomeState extends State<CartHome> {
  Map<ProductItem,int> mapCart = {};
  double total = 0;
  // Khai báo FocusNode
  final FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    // Thêm listener để theo dõi sự thay đổi focus
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    // Xóa listener khi widget bị hủy
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }
  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
     setState(() {

     });
    }
  }
  @override
  Widget build(BuildContext context) {
    mapCart = ModalRoute.of(context)?.settings.arguments as Map<ProductItem,int>;
    double total = mapCart.entries.fold(0, (sum, entry) {
      return sum + (entry.key.price * entry.value);
    });
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () {
            Navigator.pop(context,mapCart);
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
                          offset:
                              const Offset(0, 1), // changes position of shadow
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
                          child: Text(
                            "\$${double.parse(total.toStringAsFixed(2))}",
                            style: const TextStyle(color: Color(0xffd7abdf)),
                          )),
                      ElevatedButton(
                        onPressed: () {},
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
                Expanded(child: buildMapCartView()),
              ],
            ),
          ),
        ),
      ),
    );
  }
  bool isNonNegativeNumeric(String input) {
    final regExp = RegExp(r'^\d+$');
    return regExp.hasMatch(input);
  }
  Widget buildMapCartView() {
    List<ProductItem>list= mapCart.keys.toList();
    return ListView.builder(
        itemCount: mapCart.length,
        itemBuilder: (BuildContext context, int index) {
          var countController = TextEditingController(text: "${mapCart[list[index]]}");
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
                          child: Builder(builder: (BuildContext context){
                            return IconButton(
                                padding: EdgeInsets.zero,
                                color: Colors.white,
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                ),
                                onPressed: () {
                                  setState(() {
                                    if(int.parse(countController.text)==1){
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text('Thông báo'),
                                          content: const Text('Bạn có chắc muốn xóa sản phẩm này không?.'),
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
                                                countController.text =
                                                "${int.parse(countController.text) - 1}";
                                                mapCart[list[index]]=mapCart[list[index]]!-1;
                                                Navigator.of(context).pop();
                                                setState(() {
                                                  mapCart.remove(list[index]);
                                                  list.remove(list[index]);
                                                });
                                              },
                                            )
                                          ],
                                        ),
                                      );
                                    }else{
                                      countController.text =
                                      "${int.parse(countController.text) - 1}";
                                      mapCart[list[index]]=mapCart[list[index]]!-1;
                                    }
                                  });
                                },
                                icon: const Icon(
                                  Icons.remove,
                                  size: 20,
                                ));
                          })
                      ),
                      SizedBox(
                        width: 30,
                        child: TextField(
                          focusNode: _focusNode,
                          onChanged: (text) {
                            if (isNonNegativeNumeric(countController.text)) {
                              countController.text =text;
                              total += (list[index].price * int.parse(text));
                              mapCart[list[index]]=int.parse(text);
                              if(int.parse(text)==0){
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Thông báo'),
                                    content: const Text('Bạn có chắc muốn xóa sản phẩm này không?.'),
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
                                          Navigator.of(context).pop();
                                          setState(() {
                                            mapCart.remove(list[index]);
                                            list.remove(list[index]);
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                );
                              }
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
                               setState(() {
                                 countController.text =
                                 "${int.parse(countController.text) + 1}";
                                 total += list[index].price;
                                 mapCart[list[index]]=mapCart[list[index]]!+1;
                               });
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
}
