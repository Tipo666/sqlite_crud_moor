library database;

import 'dart:io';
import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

part 'daos/product_dao.dart';

@DataClassName('Product')
class Product extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name =>text().withLength(max: 50)();

}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}


@UseMoor(tables: [Product], daos: [ProductDao])
class AppDatabase extends _$AppDatabase {
//  AppDatabase() : super(_openConnection());

  AppDatabase()
      : super((FlutterQueryExecutor.inDatabaseFolder(
    path: 'db.sqlite',
    logStatements: true,
  )));

  @override
  int get schemaVersion => 1;
}
