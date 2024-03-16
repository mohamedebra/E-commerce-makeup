
class Item {
  int id;
  String imgPath;
  double price;
  String name;
  int? pQuantity;
  double averageRating;


  Item({required this.name, required this.imgPath, required this.price,required this.id,required this .averageRating});

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json['id'],
    name: json['name'],
    imgPath: json['imgPath'],
    price: json['price'],
    averageRating:  json['averageRating'],
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['imgPath'] = this.imgPath;
    data['price'] = this.price;
    data['averageRating'] = this.averageRating;

    return data;
  }

}
final List items = [
  Item(name: "Product1", imgPath: "assets/images/1.png", price: 112.98, id: 1, averageRating: 0),
  Item(name: "Product2", imgPath: "assets/images/2.png", price: 212.99, id: 2, averageRating: 0),
  Item(name: "Product3", imgPath: "assets/images/3.png", price: 312.99, id: 3, averageRating: 0),
  Item(name: "Product4", imgPath: "assets/images/4.png", price: 412.99, id: 4, averageRating: 0),
  Item(name: "Product5", imgPath: "assets/images/5.png", price: 512.99, id: 5, averageRating: 0),
  Item(name: "Product6", imgPath: "assets/images/6.png", price: 612.99, id: 6, averageRating: 0),
  Item(name: "Product7", imgPath: "assets/images/7.png", price: 712.99, id: 7, averageRating: 0),
];
