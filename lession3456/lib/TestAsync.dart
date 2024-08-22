// createOrderMessage() async {
//   // var order = await fetchUserOrder();
//   // return "you order is : $order";
//   return await fetchUserOrder().then((value) {
//     return "you order is : $value";
//   }).catchError((onError){
//     print(onError);
//   });
// }
//
// Future<String> fetchUserOrder() async {
//   throw Exception("ASdasd");
//   return Future.delayed(const Duration(seconds: 2), () => "Large Latte");
// }
//
// Future<void> main() async {
//   print("Fetching user order ....");
//   print(await createOrderMessage());
// }
Future<void> printOrderMessage() async {
  print('Awaiting user order...');
  var order = await fetchUserOrder();
  print('Your order is: $order');
}

Future<String> fetchUserOrder() {
  // Imagine that this function is more complex and slow.
  return Future.delayed(const Duration(seconds: 4), () => 'Large Latte');
}

void main() async {
  countSeconds(4);
  await printOrderMessage();
}

// You can ignore this function - it's here to visualize delay time in this example.
void countSeconds(int s) {
  for (var i = 1; i <= s; i++) {
    Future.delayed(Duration(seconds: i), () => print(i));
  }
}