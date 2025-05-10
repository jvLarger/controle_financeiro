enum CategoryType { expense, income }

extension CategoryTypeExtension on CategoryType {
  String get value {
    switch (this) {
      case CategoryType.expense:
        return 'expense';
      case CategoryType.income:
        return 'income';
    }
  }

  static CategoryType fromString(String type) {
    switch (type) {
      case 'expense':
        return CategoryType.expense;
      case 'income':
        return CategoryType.income;
      default:
        throw Exception('Invalid category type: $type');
    }
  }
}

class Category {
  final int? id;
  final String name;
  final CategoryType type;

  Category({this.id, required this.name, required this.type});

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as int?,
      name: map['name'] as String,
      type: CategoryTypeExtension.fromString(map['type'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'type': type.value};
  }
}
