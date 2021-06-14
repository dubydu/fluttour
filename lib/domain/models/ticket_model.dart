
class TicketModel {
  TicketModel({
    this.raceId,
    this.date,
    this.tickets,
    this.status,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) => TicketModel(
    raceId: (json['race_id'] != null) ? json['race_id'] as int : null,
    date: (json['date'] != null) ? json['date'] as String : null,
    tickets: (json['tickets'] != null) ? (json['tickets'] as List<dynamic>).map((e) => Ticket.fromJson(e as Map<String, dynamic>)).toList() : null,
    status: (json['ticket_status'] != null) ? json['ticket_status'] as String : null,
  );

  final int? raceId;
  final String? date;
  final List<Ticket?>? tickets;
  final String? status;
}

class Ticket {
  Ticket({
    this.type,
    this.purchaseCount,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
    type: (json['type'] != null) ? json['type'] as String : null,
    purchaseCount: (json['purchase_count'] != null) ? json['purchase_count'] : null,
  );

  final String? type;
  final int? purchaseCount;
}