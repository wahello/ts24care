import 'package:flutter/material.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/models/item_tickets_model.dart';
import 'package:ts24care/src/app/pages/ticket/ticket_page_viewmodel.dart';
import 'package:ts24care/src/app/widgets/item_tickets_widget.dart';
import 'package:ts24care/src/app/widgets/ts24_scaffold_widget.dart';

class TicketsPage extends StatefulWidget {
  static const String routeName = "/ticketsPage";
  @override
  _TicketsPageState createState() => _TicketsPageState();
}

class _TicketsPageState extends State<TicketsPage> {
  TicketPageViewModel viewModel = TicketPageViewModel();
  @override
  Widget build(BuildContext context) {
    viewModel.context = context;
    Widget _appBar() {
      return AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {},
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 15),
            child: Text(
              "Edit",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        title: Row(
          children: <Widget>[
            Text(
              "Your unsolved tickets (3)",
              style: TextStyle(color: Colors.black87),
            ),
            Icon(Icons.keyboard_arrow_down,color: Colors.black87,)
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.black87,
            ),
            onPressed: (){
              viewModel.onTapCreateTicket();
            },
          )
        ],
        bottom: PreferredSize(
          child: Column(
            children: <Widget>[
              Container(
                height: 0.5,
                color: Colors.grey[300],
                width: MediaQuery.of(context).size.width,
              ),
//              SizedBox(
//                height: 10,
//              ),
              Container(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Status: Open",
                      style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.arrow_downward,
                          color: Colors.blue,
                        ),
                        Text(
                          "Default",
                          style: TextStyle(color: Colors.blue),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          preferredSize: Size(MediaQuery.of(context).size.width, 55),
        ),
      );
    }

    Widget _body() {
      return ListView.builder(
          itemCount: ItemTicketsModel.listItemTickets.length,
          itemBuilder: (context, index) {
            var itemTickets = ItemTicketsModel.listItemTickets[index];
            return Container(
              width: MediaQuery.of(context).size.width,
              height: 90,
              child: ItemTicketsWidget(
                title: itemTickets.title,
                avatarUrl: itemTickets.avatarUrl,
                content: itemTickets.content,
                name: itemTickets.userName,
                time: itemTickets.time,
              ),
            );
          });
    }

    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder(
        stream: viewModel.stream,
        builder: (context, snapshot) {
          return TS24Scaffold(
            appBar: _appBar(),
            body: _body(),
          );
        },
      ),
    );
  }
}
