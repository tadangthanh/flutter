import 'package:flutter/material.dart';
import 'package:lession3456/model/ProductItem.dart';

class BaiTapBuoi5ProductDetail extends StatefulWidget {
  final ProductItem productItem;

  const BaiTapBuoi5ProductDetail({super.key, required this.productItem});

  @override
  State<StatefulWidget> createState() {
    return BaiTapBuoi5ProductDetailState();
  }
}

class BaiTapBuoi5ProductDetailState extends State<BaiTapBuoi5ProductDetail> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      // ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Center(
              child: ListView(
                children: [
                  Stack(
                    children: [
                      Image(image: NetworkImage(widget.productItem.image)),
                      Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            child: Center(
                              child: Text(
                                widget.productItem.name,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 40),
                              ),
                            ),
                          ))
                    ],
                  ),
                  Center(
                    child: Text(
                      "\$ ${widget.productItem.price}",
                      style: const TextStyle(
                          fontSize: 45, color: Color(0xFF9B9B9B)),
                    ),
                  ),
                  Center(
                    child: Text(
                      "\$ ${widget.productItem.description}",
                      style: const TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0, // Bỏ bóng dưới AppBar nếu cần
            ),
          )
        ],
      ),
    );
  }
}
