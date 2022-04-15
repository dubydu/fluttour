import 'package:fluttour/domain/models/ticket_model.dart';

abstract class TicketsState { }

class TicketsUninitializedState extends TicketsState { }

class TicketsFetchingState extends TicketsState { }

// class TicketsLoadingMoreState extends TicketsState {
//   final bool isLoading;
//   final bool noMoreData;
//   TicketsLoadingMoreState({required this.isLoading, required this.noMoreData});
// }

class TicketsFetchedState extends TicketsState {
  final List<TicketModel>? ticketModel;
  bool isLoading;
  bool noMoreData;
  TicketsFetchedState({
    required this.ticketModel,
    this.isLoading = false,
    this.noMoreData = false
  });
}

class TicketsErrorState extends TicketsState { }

class TicketsEmptyState extends TicketsState { }