class CartItem {
  final String id;
  final String title;
  final int quantily;
  final double price;

  CartItem({
    required this.id,
    required this.title,
    required this.quantily,
    required this.price,
  });

  CartItem copyWith({
    String? id,
    String? title,
    int? quantily,
    double? price,
  }) {
    return CartItem(
        id: id ?? this.id,
        title: title ?? this.title,
        quantily: quantily ?? this.quantily,
        price: price ?? this.price);
  }
}
