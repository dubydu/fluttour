import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttour/generated/l10n.dart';
import 'package:fluttour/pages/tickets/tickets_bloc.dart';
import 'package:fluttour/pages/tickets/tickets_event.dart';
import 'package:fluttour/pages/tickets/tickets_state.dart';
import 'package:fluttour/utils/extension/app_extension.dart';
import 'package:fluttour/app_define/app_enum.dart';
import 'package:fluttour/pages/base/p_material.dart';
import 'package:fluttour/utils/widgets/w_header.dart';

class PTickets extends StatefulWidget {
  @override
  _PTicketsState createState() => _PTicketsState();
}

class _PTicketsState extends State<PTickets> {

  ///TicketsProvider
  late TicketsBloc _ticketsBloc;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      _ticketsBloc = BlocProvider.of<TicketsBloc>(context, listen: false);
      _fetchTicketsEvent();
    });
  }

  _fetchTicketsEvent() {
    _ticketsBloc.add(TicketsFetchingEvent());
  }

  _loadingMoreEvent() {
    _ticketsBloc.add(TicketsLoadingMoreEvent());
  }

  @override
  Widget build(BuildContext context) {
    return PMaterial(
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              WHeader(title: Tutorial.pagination.getName(),
                  isShowBackButton: true),
              BlocBuilder<TicketsBloc, TicketsState>(
                buildWhen: (_, state) {
                  return (state is TicketsFetchedState ||
                      state is TicketsFetchingState ||
                      state is TicketsEmptyState);
                },
                builder: (context, state) {
                  if (state is TicketsFetchedState) {
                    return _buildListViewWidget(context, state);
                  } else if (state is TicketsFetchingState) {
                    return Container(padding: EdgeInsets.only(top: 150.H),
                        child: CupertinoActivityIndicator(radius: 16.SP,));
                  } else {
                    return Container(padding: EdgeInsets.only(top: 150.H),
                      child: Text(S.of(context).ticket_empty),
                    );
                  }
                }
              ),
            ],
          ),
        )
    );
  }

  Widget _buildListViewWidget(BuildContext context, TicketsFetchedState state) {
    final ticketList = state.ticketModel;
    final noMoreData = state.noMoreData;
    final loadingMore = state.isLoading;
    return Expanded(
      child: NotificationListener<ScrollNotification>(
          child: SafeArea(
            top: false,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()
              ),
              child: Column(
                children: <Widget>[
                  ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: ticketList?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            padding: EdgeInsets.all(50.SP),
                            child: Row(
                              children: <Widget>[
                                Text("> • $index  ${ticketList?[index]
                                    .status}   /   ${ticketList?[index]
                                    .date.toString()}"),
                                Spacer(),
                              ],
                            )
                        );
                      }),
                  Container(
                      margin: EdgeInsets.only(bottom: noMoreData ? 30.H : 200.H),
                      child: noMoreData ? Container(child: Text(S.of(context).no_more_data))
                          : loadingMore ? CupertinoActivityIndicator(radius: 8.SP) : null),
                ],
              ),
            ),
          ),
          onNotification: (ScrollNotification scroll) {
            if (scroll.metrics.pixels >
                (scroll.metrics.maxScrollExtent - 200.H) && !loadingMore && !noMoreData) {
              Future.delayed(const Duration(milliseconds: 100), () async {
                _loadingMoreEvent();
              });
            }
            return true;
          }
      ),
    );
  }

  @override
  void deactivate() {
    _ticketsBloc.resetState();
    super.deactivate();
  }
}
