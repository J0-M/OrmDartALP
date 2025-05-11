import '../orm/base_model.dart';
import '../orm/field.dart';

class User extends BaseModel {
    final StringField name = StringField("name");
    final IntField age = IntField("age");

    User({String? name, int? age}) {
      this.name.value = name;
      this.age.value = age;
    }

    //User({this.name, this.age});

    @override
    String get collectionName => "users";

    @override
    List<Field> get fields => [name, age];

    factory User.fromMap(Map<String, dynamic> data) {
      final fields = data['fields'];
      return User(
        name: fields['name']['stringValue'],
        age: int.parse(fields['age']['integerValue']),
      );
    }

    Map<String, dynamic> toJson() {
      return {
        "fields": {
          "name": {"stringValue": name.value},
          "age": {"integerValue": age.value.toString()},
        }
      };
    }
}
