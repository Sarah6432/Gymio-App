import 'package:gymio/features/classes/data/datasources/classes_datasource.dart';
import 'package:gymio/features/classes/data/models/classes_model.dart';

class AulasRepository {
  final AulasRemoteDatasource datasource;

  AulasRepository(this.datasource);

  Future<List<AulaModel>> getAulas() async {
    try {
      final aulas = await datasource.fetchAll();

      return aulas;
    } catch (e) {
      throw Exception("Erro ao buscar aulas");
    }
  }
}
