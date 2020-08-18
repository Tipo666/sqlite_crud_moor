part of database;

@UseDao(tables: [Product])
class ProductDao extends DatabaseAccessor<AppDatabase> with _$ProductDaoMixin {
  final AppDatabase db;

  ProductDao(this.db) : super(db);

  Future<List<Product>> getAllUsers() => select(users).get();

  Stream<List<Product>> watchAllUsers() => select(users).watch();

  Future<Product> firstUser() => select(users).getSingle();

  Future insertUser(Product user) => into(users).insert(user);

  Future updateUser(Product user) => update(users).replace(user);

  Future deleteUser(Product user) => delete(users).delete(user);

  Future<Product> findUserById(int id) =>
      (select(users)..where((u) => u.id.equals(id))).getSingle();
}
