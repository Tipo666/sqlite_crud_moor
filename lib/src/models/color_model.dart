class ColorModel {
  int id;
  String name;

  ColorModel({this.id, this.name});


  ColorModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
  }


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
