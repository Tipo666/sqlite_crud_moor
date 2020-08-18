import 'package:flutter/material.dart';

import 'package:sqlite_crud_moor/src/data/database.dart';

class DBInsertPage extends StatefulWidget {

  final String title;
  DBInsertPage({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DBInsertPageState();
  }
}

class _DBInsertPageState extends State<DBInsertPage> {

  Future<List<Product>> products;
  TextEditingController controller = TextEditingController();
  String name;
  int curUserId;
  final formKey = new GlobalKey<FormState>();
  var dbHelper;
  bool isUpdating;

  ///Método initState()
  ///
  ///
  ///
  ///
  ///
  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    isUpdating = false;
    refreshList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        form(),
        list(),
      ],
    );
  }

  ///Método form()
  ///
  ///
  ///Con este método cremos el formulario para introducir los datos
  ///
  ///
  form() {
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            TextFormField(
              controller: controller,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'Nombre'),
              validator: (val) => val.length == 0 ? 'Ingresar nombre' : null,
              onSaved: (val) => name = val,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  onPressed: validate,
                  child: Text('Agregar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ///Método refreshList()
  ///
  ///Con este método refrescamos la lista cada vez que se produce un cambio dentro de la base de datos.
  ///
  ///
  ///
  refreshList() {
    setState(() {
      products = dbHelper.getProducts();
    });
  }

  ///Método validate()
  ///
  ///Con este método validamos la entrada de los datos antes de ingresarlos a la Base de Datos.
  ///
  ///
  ///
  validate() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      if (isUpdating) {
        Product e = Product(curUserId, name);
        dbHelper.update(e);
        setState(() {
          isUpdating = false;
        });
      } else {
        Product e = Product(null, name);
        dbHelper.save(e);
      }
      clearName();
      refreshList();
    }
  }

  ///Método clearName()
  ///
  ///Con este método limpiamos el TextForm cuando se realiza un Insert o un Update.
  ///
  ///
  ///
  clearName() {
    controller.text = '';
  }

  ///Método list()
  ///
  ///Con este método mostramos los datos contenidos dentro de la BD.
  ///
  ///
  ///
  list() {
    return Expanded(
      child: FutureBuilder(
        future: products,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return dataTable(snapshot.data);
          }

          if (null == snapshot.data || snapshot.data.length == 0) {
            return Text("No se encontraron datos");
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }

  ///Método dataTable()
  ///
  ///Con este método mediante un DataTable elegimos que mostrar dentro de ella
  ///En este caso se mostrara la lista de Productos
  ///
  ///
  ///
  SingleChildScrollView dataTable(List<Product> products) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: [
          DataColumn(
            label: Text('Nombre'),
          ),
        ],
        rows: products
            .map(
              (product) => DataRow(cells: [
            DataCell(
              Text(product.name),

            ),

          ]),
        )
            .toList(),
      ),
    );
  }

}