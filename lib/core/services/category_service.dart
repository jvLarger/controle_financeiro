import 'package:controle_financeiro/data/category_dao.dart';
import 'package:controle_financeiro/exceptions/business_exception.dart';
import 'package:controle_financeiro/models/category.dart';

class CategoryService {
  final CategoryDao _dao = CategoryDao();

  Future<void> addCategory(Category category) async {
    if (category.name.trim().isEmpty) {
      throw Exception('O nome da categoria é obrigatório.');
    }

    await _dao.insert(category);
  }

  Future<List<Category>> getAllCategories() async {
    return await _dao.getAll();
  }

  Future<List<Category>> getCategoriesByType(CategoryType type) async {
    return await _dao.getByType(type);
  }

  Future<void> updateCategory(Category category) async {
    if (category.id == null) {
      throw BusinessException('ID da categoria é obrigatório para atualizar.');
    }
    if (category.name.trim().isEmpty) {
      throw BusinessException('O nome da categoria é obrigatório.');
    }

    await _dao.update(category);
  }

  Future<void> deleteCategory(int id) async {
    await _dao.delete(id);
  }
}
