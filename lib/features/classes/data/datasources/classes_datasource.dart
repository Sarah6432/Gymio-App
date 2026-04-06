import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:gymio/features/classes/data/models/classes_model.dart';

class AulasRemoteDatasource {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<AulaModel>> fetchAll() async {
    final List<dynamic> rows = await _client
        .from('aulas')
        .select()
        .order('dia_semana', ascending: true)
        .order('horario', ascending: true);

    return rows
        .map((e) => AulaModel.fromRow(Map<String, dynamic>.from(e as Map)))
        .toList();
  }
}
