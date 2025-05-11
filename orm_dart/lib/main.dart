import 'dart:io';
import 'models/user.dart';
import 'orm/firestore_repository.dart';

void main() async {
    final token = 'ya29.c.c0ASRK0GZ62-wqYDT2CgrPELM2QHjjDaG9PMsHspdUDAIAAWfVLm8bv0w6oJMa18L7ekKCHkJP5RdiDm44C4awe7gSNE-PLyNDDTlJ6Wjeb0n-uYxy-8a-BGcL6fiVfhF1YDtgjhsvTmnKG9DY3NElssGhF8a1Nl7EX41V8Th5HKco28-jcKSjyGS2QGrHmetINmtgHCpr3nH-E5MJl2lZHvVwQflSdcB_FafgaPRDUjrsPd0ly0gnjxD3tuDGcY6olJirT5SSbaSyMEq_205b29XODro70tEFbO2kJ7JAUV265ORipVqAyF4scYge2_JY9qXEtF1bUgMHLWt-xJz_wPp9q1hQfg7NYQqq3hDiEAeRuLfyWi2NDaOpZv4UA4q7Ms7bUQH399PYjBgUyRnFl4Sn21kly09smn-Ojft9YQReiMUtaMk5vubrOSzd75Z1Fb29Ukiq6vMB2dxryjXmrtaMgmXZUb59Ju6kX_zwuRqsbF1x5ZFie7Vsr84vtv4rcOMimMmnReslkSYcjV-4XMz-zm7fyMwsMeZwzninyUcWQe-ds2eYtcuVOXkXr5WYMch5Jkp78kRuBMYUjVyZM1-Z5pUk9JVReVRsXdIVO64l2q6XYovlnF45qq6gyUUuldBWVQVU48n8qqvFg2F8y0fuuf_25_9lwuzZzm3-hqhrsneyJ-tnywl-cYy0ifYQrl34U86mudtyQBW1Q7IuYcdO5Qu1SbB5Vf-jnrFQ6fOaa4n5mV0uBBoxp00tbqw1oJwakVRr2yl5dhB-4kSXjXzJXRk1h-YymrU2-2amsI3XnkQyqh4nqt4VmJI6Meg7_VX334snoF_jfR7gZgIrdBSbsc7tOcOalYFJ0Z4w5lVjhha-MXfQqUYV2cMbhsZfe2aJyo6akmr1cklMop0YQevv5xJXtelQbwIkSycdxkWJIg_5dzylaYl8d1B0wukvkI22yep1fwB1d5i-8dg-RoQOnlV-tS7iqM_RU39iOj5YXFS6qIiId';
    final repo = FirestoreRepository(token);

    String loop = 'y';

    while(loop == 'y'){
      print('1 - Criar usuário');
      print('2 - Listar usuários');
      print('3 - Atualizar usuário');
      print('4 - Deletar usuário');
      stdout.write('\nEscolha uma opção: ');
      final op = stdin.readLineSync();

      switch (op) {
        case '1':
          stdout.write('Nome: ');
          final name = stdin.readLineSync();

          stdout.write('Idade: ');
          final age = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

          final user = User(name: name, age: age);

          await repo.create(user);
          break;

        case '2':
          await repo.readAll();
          break;

        case '3':
          stdout.write('ID do documento para atualizar (sem /users/): ');
          final id = stdin.readLineSync();

          stdout.write('Novo nome: ');
          final name = stdin.readLineSync();

          stdout.write('Nova idade: ');
          final age = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

          final user = User(name: name, age: age);

          await repo.update(id!,user);
          break;

        case '4':
          stdout.write('ID do documento para deletar (sem /users/): ');
          final id = stdin.readLineSync();
          await repo.delete(id!);
          break;

        default:
          print('Insira Opção inválida!');
      }
      stdout.write('Deseja realizar outra operação? (y/n): ');
      loop = stdin.readLineSync() ?? 'n';
    }
}

