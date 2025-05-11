abstract class Field<T> {
  final String name;
  T? value;

  Field(this.name, [this.value]);

  Map<String, dynamic> toFirestoreValue();
}

class StringField extends Field<String> {
  StringField(String name, [String? value]) : super(name, value);

  @override
  Map<String, dynamic> toFirestoreValue() {
    return {"stringValue": value ?? ""};
  }
}

class IntField extends Field<int> {
  IntField(String name, [int? value]) : super(name, value);

  @override
  Map<String, dynamic> toFirestoreValue() {
    return {"integerValue": value?.toString() ?? "0"};
  }
}
