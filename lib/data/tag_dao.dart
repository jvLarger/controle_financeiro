import 'package:controle_financeiro/core/services/database_service.dart';
import 'package:controle_financeiro/models/tag.dart';

class TagDao {
  Future<int> insert(Tag tag) async {
    final db = await DatabaseService.database;
    return await db.insert('tags', tag.toMap());
  }

  Future<List<Tag>> getAll() async {
    final db = await DatabaseService.database;
    final maps = await db.query('tags', orderBy: 'name COLLATE NOCASE ASC');
    return maps.map((e) => Tag.fromMap(e)).toList();
  }

  Future<int> update(Tag tag) async {
    final db = await DatabaseService.database;
    return await db.update(
      'tags',
      tag.toMap(),
      where: 'id = ?',
      whereArgs: [tag.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await DatabaseService.database;
    return await db.delete('tags', where: 'id = ?', whereArgs: [id]);
  }
}
