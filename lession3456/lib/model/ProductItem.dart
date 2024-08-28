class ProductItem {
  final int id;
  final String name;
  final String image;
  final double price;
  final String description;
  int quantity = 1;

  ProductItem.name({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.description,
  });

  // Overriding == operator and hashCode to compare ProductItem instances
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProductItem && other.id == id;
  }

  void incrementQuantity() {
    ++quantity;
  }
  void decrementQuantity() {
    --quantity;
  }
  void setQuantity(int q){
    quantity=q;
  }
  @override
  int get hashCode => id.hashCode;
}
