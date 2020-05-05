import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ts24care/src/app/models/helpdesk-stage.dart';

class SharedPreferencesTicketStatus {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences prefs;
  SharedPreferencesTicketStatus() {
    _init();
  }
  _init() async {
    prefs = await _prefs;
  }

  setTicketStatus(List<HelpDeskStage> listStatus) {
    if (listStatus.length > 0) {
      var _listContact = json.encode(listStatus);
      if (prefs != null) {
        prefs.setString('ticketsStatus', _listContact).then((bool value) {
          print(value);
        });
      } else
        _prefs.then((prefs) {
          prefs.setString('ticketsStatus', _listContact).then((bool value) {
            print(value);
          });
        });
    }
  }

  List<HelpDeskStage> getTicketStatus() {
    String text = '';
    if (prefs != null) {
      text = prefs.getString('ticketsStatus');
    } else
      _prefs.then((prefs) {
        text = prefs.getString('ticketsStatus');
      });
    if (text != null) {
      List _listContact = json.decode(text);
      List<HelpDeskStage> list = _listContact
          .map((contact) => HelpDeskStage.fromJson(contact))
          .toList();
//      list.sort((a,b)=>a.name.compareTo(b.name));
      return list;
    }
    return null;
  }
}
