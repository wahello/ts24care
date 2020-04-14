import 'dart:async';

class HandleTicketStatus {
  StreamController streamController = StreamController<int>();

  void dispose() {
    streamController.close();
    streamController = StreamController();
  }
}