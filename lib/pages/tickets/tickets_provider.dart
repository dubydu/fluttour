import 'package:fluttour/domain/models/ticket_model.dart';
import 'package:fluttour/data/api/request/ticket_request.dart';
import 'package:fluttour/utils/other/notifier_safety.dart';

class TicketsProvider extends ChangeNotifierSafety {
  TicketsProvider(this._ticketRequest);

  /// TicketRequest
  late TicketRequest _ticketRequest;

  /// List of TicketModel
  List<TicketModel?>? _tickets;

  List<TicketModel?>? get tickets => _tickets;

  set tickets(List<TicketModel?>? value) {
    _tickets = value;
    notifyListeners();
  }

  /// Get Tickets
  Future<void> getTickets() async {
    final result = await this._ticketRequest.getTickets();
    this.tickets = result;
  }

  @override
  void resetState() { }
}