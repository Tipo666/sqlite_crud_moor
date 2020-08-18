import 'package:flutter/material.dart';
import 'package:sqlite_crud_moor/src/data/database.dart';


class DBListPage extends StatefulWidget {

  final String title;
  DBListPage({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DBListPageState();
  }
}

class _DBListPageState extends State<DBListPage> {

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
        list(),
      ],
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