class ProductModel {
  String name;
  int stock;
  String? urlPhotos;
  int price;
  int denda;
  String description;

  ProductModel(
      {required this.name,
      required this.stock,
      required this.urlPhotos,
      required this.price,
      required this.denda,
      required this.description});
}
