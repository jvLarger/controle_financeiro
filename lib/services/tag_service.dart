import 'package:controle_financeiro/data/tag_dao.dart';
import 'package:controle_financeiro/exceptions/business_exception.dart';
import 'package:controle_financeiro/models/tag.dart';

class TagService {
  final TagDao _dao = TagDao();

  Future<List<Tag>> getAllTags() async {
    return await _dao.getAll();
  }

  Future<void> addTag(Tag tag) async {
    if (tag.name.trim().isEmpty) {
      throw BusinessException('O nome da TAG não pode estar vazio.');
    }

    await _dao.insert(tag);
  }

  Future<void> updateTag(Tag tag) async {
    if (tag.id == null) {
      throw BusinessException('ID da TAG não pode ser nulo ao atualizar.');
    }
    if (tag.name.trim().isEmpty) {
      throw BusinessException('O nome da TAG não pode estar vazio.');
    }
    await _dao.update(tag);
  }

  Future<void> deleteTag(int id) async {
    await _dao.delete(id);
  }
}
