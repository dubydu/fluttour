import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttour/data/api/request/ticket_request.dart';
import 'package:fluttour/domain/models/ticket_model.dart';
import 'package:fluttour/pages/tickets/tickets_event.dart';
import 'package:fluttour/pages/tickets/tickets_state.dart';

class TicketsBloc extends Bloc<TicketsEvent, TicketsState> {
  late TicketRequest ticketRequest;

  TicketsBloc({required this.ticketRequest}) : super(TicketsUninitializedState()) {
    on<TicketsEvent>(_mapEventToState);
  }

  /// Seek forwards from start of list if tickets.
  int _seekForwardsCount = 7;
  /// Seek backwards from end of list if tickets.
  int _seekBackwardsCount = 0;
  /// List of TicketModel
  List<TicketModel>? _tickets = <TicketModel>[];
  /// isLoadingMore
  bool _isLoadingMore = false;
  /// isNoMoreData
  bool _isNoMoreData = false;

  Future<void> _mapEventToState(
      TicketsEvent event,
      Emitter<TicketsState> emit)
  async {
    try {
      if (event is TicketsFetchingEvent) {
        emit(TicketsFetchingState());
        List<TicketModel>? result = await this.ticketRequest.getTickets(
            first: _seekForwardsCount,
            skip: _seekBackwardsCount
        );
        if (result.isEmpty) {
          emit(TicketsEmptyState());
        } else {
          _tickets?.addAll(result);
          _seekBackwardsCount += 7;
          emit(TicketsFetchedState(ticketModel: _tickets));
        }
      } else if ((event is TicketsLoadingMoreEvent) && !_isLoadingMore) {
        _isLoadingMore = true;
        emit(TicketsFetchedState(
            ticketModel: _tickets,
            isLoading: _isLoadingMore,
            noMoreData: _isNoMoreData
        ));
        List<TicketModel>? result = await this.ticketRequest.getTickets(
            first: _seekForwardsCount,
            skip: _seekBackwardsCount
        );
        if (result.isEmpty) {
          _isNoMoreData = true;
        } else {
          _tickets?.addAll(result);
          _seekBackwardsCount += 7;
        }
        await Future.delayed(const Duration(milliseconds: 200), () async {
          emit(TicketsFetchedState(
              ticketModel: _tickets,
              isLoading: false,
              noMoreData: _isNoMoreData
          ));
          _isLoadingMore = false;
        });
      }
    } catch (e) {
      emit(TicketsErrorState());
    }
  }

  void resetState() {
    _seekBackwardsCount = 0;
    _isLoadingMore = false;
    _isNoMoreData = false;
    _tickets = <TicketModel>[];
  }
}