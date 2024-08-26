class ProductItem {
  final int id;
  final String name;
  final String image;
  final double price;
  final String description;

  ProductItem.name(
      {required this.id,
      required this.name,
      required this.image,
      required this.price,
      required this.description});

  // Overriding == operator and hashCode to compare ProductItem instances
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProductItem && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
