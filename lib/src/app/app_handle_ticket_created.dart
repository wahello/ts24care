import 'dart:async';

class HandleTicketCreated {
  StreamController streamController = StreamController<bool>();

  void dispose() {
    streamController.close();
    streamController = StreamController();
  }
}