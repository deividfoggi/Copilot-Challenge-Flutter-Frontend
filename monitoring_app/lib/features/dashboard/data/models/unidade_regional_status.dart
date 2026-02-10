/// Modelo de status de unidade regional
class UnidadeRegionalStatus {
  const UnidadeRegionalStatus({
    required this.nome,
    required this.roteador,
    required this.firewall,
    required this.sdwan,
    required this.starlink,
  });

  final String nome;
  final int roteador;
  final int firewall;
  final int sdwan;
  final int starlink;

  int get totalAlertas => roteador + firewall + sdwan + starlink;

  bool get hasAlertas => totalAlertas > 0;

  factory UnidadeRegionalStatus.fromJson(Map<String, dynamic> json) {
    return UnidadeRegionalStatus(
      nome: json['nome'] as String,
      roteador: json['roteador'] as int? ?? 0,
      firewall: json['firewall'] as int? ?? 0,
      sdwan: json['sdwan'] as int? ?? 0,
      starlink: json['starlink'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'roteador': roteador,
      'firewall': firewall,
      'sdwan': sdwan,
      'starlink': starlink,
    };
  }

  UnidadeRegionalStatus copyWith({
    String? nome,
    int? roteador,
    int? firewall,
    int? sdwan,
    int? starlink,
  }) {
    return UnidadeRegionalStatus(
      nome: nome ?? this.nome,
      roteador: roteador ?? this.roteador,
      firewall: firewall ?? this.firewall,
      sdwan: sdwan ?? this.sdwan,
      starlink: starlink ?? this.starlink,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UnidadeRegionalStatus &&
        other.nome == nome &&
        other.roteador == roteador &&
        other.firewall == firewall &&
        other.sdwan == sdwan &&
        other.starlink == starlink;
  }

  @override
  int get hashCode {
    return nome.hashCode ^
        roteador.hashCode ^
        firewall.hashCode ^
        sdwan.hashCode ^
        starlink.hashCode;
  }
}
