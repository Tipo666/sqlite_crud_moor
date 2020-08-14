class ProductModel {
  int id;
  String name;

  ProductModel({this.id, this.name});

  //Constructor
  ProductModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
  }

  //Method
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  String toString() {
    return 'Nombre: $name ($id)';
  }
}
