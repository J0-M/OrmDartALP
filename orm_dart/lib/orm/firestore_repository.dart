import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/user.dart';

class FirestoreRepository {
    final String _token;
    final String _collection = 'users';
    final String _projectId = 'dart-orm';

    FirestoreRepository(this._token);

    String get _baseUrl =>
        'https://firestore.googleapis.com/v1/projects/$_projectId/databases/(default)/documents/$_collection';

    Future<void> create(User user) async {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_token',
        },
        body: jsonEncode(user.toJson()),
      );

      if (response.statusCode == 200) {
        print('Usuário salvo com sucesso!');
      } else {
        print('Erro ao salvar usuário: ${response.body}');
      }
    }

    Future<void> readAll() async {
      final response = await http.get(
        Uri.parse(_baseUrl),
        headers: {'Authorization': 'Bearer $_token'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final docs = data['documents'] ?? [];
        for (var doc in docs) {
          final user = User.fromMap(doc);
          print('${user.name.value}, ${user.age.value} anos');
        }
      } else {
        print('Erro ao buscar usuários: ${response.body}');
      }
    }
    Future<void> update(String documentId, User user) async {
    final url = '$_baseUrl/$documentId';

    final response = await http.patch(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      print('Usuário atualizado com sucesso!');
    } else {
      print('Erro ao atualizar usuário: ${response.body}');
    }
  }

    Future<void> delete(String documentId) async {
      final url = '$_baseUrl/$documentId';

      final response = await http.delete(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $_token'},
      );

      if (response.statusCode == 200) {
        print('Usuário deletado com sucesso!');
      } else {
        print('Erro ao deletar usuário: ${response.body}');
      }
    }
}
