import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttour/pages/tickets/tickets_provider.dart';
import 'package:fluttour/utils/extension/app_extension.dart';
import 'package:fluttour/app_define/app_route.dart';
import 'package:fluttour/app_define/app_enum.dart';
import 'package:fluttour/utils/widgets/p_material.dart';
import 'package:fluttour/utils/widgets/w_header.dart';
import 'package:provider/provider.dart';

class PTickets extends StatefulWidget {
  @override
  _PTicketsState createState() => _PTicketsState();
}

class _PTicketsState extends State<PTickets> with HeaderDelegate {

  ///TicketsProvider
  late TicketsProvider _provider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      _provider = Provider.of<TicketsProvider>(context, listen: false);
      await _provider.getTickets();
    });
  }

  @override
  void onBack() {
    _provider.tickets = null;
    context.navigator()?.pop();
  }

  @override
  Widget build(BuildContext context) {
    return PMaterial(
        child: Consumer<TicketsProvider>(
        builder: (BuildContext context, TicketsProvider provider, _) {
          final ticketList = provider.tickets;
          return Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                WHeader(title: Tutorial.fetching.getName(),
                    isShowBackButton: true,
                    delegate: this),
                if (ticketList == null)
                  Container(padding: EdgeInsets.only(top: 150.H),
                      child: CupertinoActivityIndicator(radius: 16.SP,))
                else if (ticketList.length == 0)
                  Text('Data is empty')
                else
                  Container(
                      child: Expanded(
                        child: ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: ticketList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                padding: EdgeInsets.all(50.SP),
                                child: Text("${ticketList[index]?.status}   /   ${ticketList[index]?.date.toString()}"),
                              );
                            }),
                      )
                  )
              ],
            ),
          );
        },
      )
    );
  }
}
