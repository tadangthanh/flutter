import 'package:flutter/material.dart';
import 'package:lession3456/model/ProductItem.dart';

// void main() {
//   runApp(const EditProduct());
// }
//
// class EditProduct extends StatelessWidget {
//   const EditProduct({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: "Edit Product",
//       home: EditProductHomePage(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

class EditProductHomePage extends StatefulWidget {
  const EditProductHomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return EditProductState();
  }
}

class EditProductState extends State<EditProductHomePage> {
  var titleController = TextEditingController();
  var priceController = TextEditingController();
  var descriptionController = TextEditingController();
  var imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)?.settings.arguments as ProductItem?;
    if(product!=null){
        titleController.text=product.name;
        priceController.text=product.price.toString();
        descriptionController.text=product.description;
        imageController.text=product.image;
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Center(
                child: Text(
              product == null ? "Add Product" : "Edit Product",
              style: const TextStyle(color: Colors.white, fontSize: 25),
            )),
          ),
          backgroundColor: Colors.blue,
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: IconButton(
                  onPressed: () {
                      final productUpdate= ProductItem.name(id: DateTime.now().millisecondsSinceEpoch, name: titleController.text, image: imageController.text, price: double.parse(priceController.text), description: descriptionController.text);
                      Navigator.pop(context,productUpdate);
                  },
                  icon: const Icon(
                    Icons.save,
                    color: Colors.white,
                  )),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text("Expanded"),
                    Expanded(
                        child: Container(
                      alignment: Alignment.centerLeft,
                      height: 15,
                      decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: const Text("1"),
                    )),
                    Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          height: 15,
                          decoration: const BoxDecoration(
                              color: Colors.orange,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: const Center(child: Text("1")),
                        )),
                    Expanded(
                        child: Container(
                      alignment: Alignment.centerRight,
                      height: 15,
                      decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: const Text(
                        "1",
                        style: TextStyle(backgroundColor: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    )),
                  ],
                ),
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: "Title"),
                ),
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(labelText: "Price"),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: "Description"),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10, right: 10),
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              width: 1.5, color: const Color(0xCCCCCCCC))),
                      child: IconButton(
                          onPressed: () {}, icon: const Icon(Icons.image)),
                    ),
                    Expanded(
                      child: TextField(
                        controller: imageController,
                        decoration:
                            const InputDecoration(labelText: "Image URL"),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
