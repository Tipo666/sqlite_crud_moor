import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _menuItems = [
    {'label': 'Agregar Usuario', 'route': 0},
    {'label': 'Listar Usuarios', 'route': 1},
    {'label': 'Actualizar Usuario', 'route': 2},
    {'label': 'Eliminar Usuario', 'route': 3},
  ];

  int _selectedPage = 4;

  @override
  Widget build(BuildContext context) {
    // usersBloc.listUsers();
    return Scaffold(
      appBar: AppBar(
        title: Text('SQLite CRUD Básico'),
        centerTitle: true,
      ),
      body: _getContentWidget(),
      drawer: Drawer(
        child: ListView(children: _menu(context)),
      ),
    );
  }

  Widget _menuHeader() {
    return DrawerHeader(
      child: Text("Con Moor", style: TextStyle(fontSize: 25.0),),
      decoration: BoxDecoration(

        color: Colors.blue,

      ),

    );
  }

  Widget menuItem(BuildContext context, Map item) {
    return ListTile(
      title: Text(item['label']),
      leading: Icon(Icons.play_circle_outline),
      onTap: () {
        setState(() {
          print(item['route']);
          _selectedPage = item['route'];
          Navigator.pop(context);
        });
      },
    );
  }

  List<Widget> _menu(BuildContext context) {
    List<Widget> list = List<Widget>();
    list.add(_menuHeader());
    for (Map it in _menuItems) {
      list.add(menuItem(context, it));
    }
    return list;
  }

  Widget _getContentWidget() {
    switch (_selectedPage) {
      case 0:
        return null;
      case 1:
        return null;
      case 2:
        return null;
      case 3:
        return null;

      default:
        return Center(
            child: Text(
              "Favor seleccione una de las opciones válidas en el Drawer.",
              style: TextStyle(fontSize: 32.0, color: Colors.red),
            ));
    }
  }
}