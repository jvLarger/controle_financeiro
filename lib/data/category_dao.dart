import 'package:controle_financeiro/core/services/database_service.dart';
import 'package:controle_financeiro/models/category.dart';

class CategoryDao {
  Future<int> insert(Category category) async {
    final db = await DatabaseService.database;
    return await db.insert('categories', category.toMap());
  }

  Future<List<Category>> getAll() async {
    final db = await DatabaseService.database;
    final result = await db.query(
      'categories',
      orderBy:
          "CASE type WHEN 'income' THEN 0 ELSE 1 END, name COLLATE NOCASE ASC",
    );
    return result.map((e) => Category.fromMap(e)).toList();
  }

  Future<List<Category>> getByType(CategoryType type) async {
    final db = await DatabaseService.database;
    final result = await db.query(
      'categories',
      where: 'type = ?',
      whereArgs: [type.value],
      orderBy: 'name COLLATE NOCASE ASC',
    );
    return result.map((e) => Category.fromMap(e)).toList();
  }

  Future<int> update(Category category) async {
    final db = await DatabaseService.database;
    return await db.update(
      'categories',
      category.toMap(),
      where: 'id = ?',
      whereArgs: [category.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await DatabaseService.database;
    return await db.delete('categories', where: 'id = ?', whereArgs: [id]);
  }
}
