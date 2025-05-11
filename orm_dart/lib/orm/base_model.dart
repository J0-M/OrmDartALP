import 'field.dart';

abstract class BaseModel {
  String get collectionName;

  List<Field> get fields;

  Map<String, dynamic> toFirestoreJson() {
    final data = <String, dynamic>{};
    for (var field in fields) {
      data[field.name] = field.toFirestoreValue();
    }
    return {"fields": data};
  }
}
