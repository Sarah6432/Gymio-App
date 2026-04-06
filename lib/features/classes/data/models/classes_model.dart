class AulaModel {
  final int id;
  final String nome;
  final String instrutor;
  final String diaSemana;
  final String horario;
  final int capacidade;
  final int alunosInscritos;

  AulaModel({
    required this.id,
    required this.nome,
    required this.instrutor,
    required this.diaSemana,
    required this.horario,
    required this.capacidade,
    required this.alunosInscritos,
  });

  factory AulaModel.fromRow(Map<String, dynamic> json) {
    return AulaModel(
      id: _asInt(json['id']),
      nome: json['nome']?.toString() ?? '',
      instrutor: json['instrutor']?.toString() ?? '',
      diaSemana: json['dia_semana']?.toString() ?? '',
      horario: json['horario']?.toString() ?? '',
      capacidade: _asInt(json['capacidade']),
      alunosInscritos: _asInt(json['alunos_inscritos']),
    );
  }

  static int _asInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString()) ?? 0;
  }
}
