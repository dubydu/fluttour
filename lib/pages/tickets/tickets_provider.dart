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

  /// Loading state
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// No more data
  bool isNoMoreData = false;

  /// Seek forwards from start of list if tickets.
  int seekForwardsCount = 7;

  /// Seek backwards from end of list if tickets.
  int seekBackwardsCount = 0;

  /// Get Tickets
  Future<void> getTickets() async {
    final result = await this._ticketRequest.getTickets(first: seekForwardsCount, skip: seekBackwardsCount);
    if (this.tickets == null) {
      this.tickets = <TicketModel>[];
    }
    this.tickets?.addAll(result);
    isNoMoreData = result.isEmpty;
    seekBackwardsCount += 7;
    isLoading = false;
  }

  @override
  void resetState() {
    seekForwardsCount = 7;
    seekBackwardsCount = 0;
    _isLoading = false;
    isNoMoreData = false;
    _tickets = null;
  }
}