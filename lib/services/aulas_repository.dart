import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:gymio/models/aula.dart';

class AulasRepository {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<Aula>> fetchAll() async {
    final List<dynamic> rows = await _client
        .from('aulas')
        .select()
        .order('dia_semana', ascending: true)
        .order('horario', ascending: true);

    return rows
        .map((e) => Aula.fromRow(Map<String, dynamic>.from(e as Map)))
        .toList();
  }
}