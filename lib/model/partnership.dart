class Partnership {
  final bool is_partner;
  final int partners_count;
  final bool? partnership_status;

  Partnership({
    required this.is_partner,
    required this.partners_count,
    this.partnership_status = null,
  });

  factory Partnership.fromJSON(Map<String, dynamic> json) {

    return Partnership(
        is_partner: json['is_partner'],
        partners_count: json['partners_count'],
        partnership_status: json['partnership_status'],
    );
  }
}