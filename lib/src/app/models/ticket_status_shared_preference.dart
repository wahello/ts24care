import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ts24care/src/app/models/helpdesk-stage.dart';

class SharedPreferencesTicketStatus {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences prefs;
  final String _aliasName = "ticketsStatus";
  SharedPreferencesTicketStatus() {
    _init();
  }
  _init() async {
    if (prefs == null) prefs = await _prefs;
  }

  setTicketStatus(List<HelpDeskStage> listStatus) async {
    await _init();
    if (listStatus.length > 0) {
      var _listContact = json.encode(listStatus);
      if (prefs != null) {
        prefs.setString(_aliasName, _listContact).then((bool value) {
          print(value);
        });
      } else
        _prefs.then((prefs) {
          prefs.setString(_aliasName, _listContact).then((bool value) {
            print(value);
          });
        });
    }
  }

  Future<List<HelpDeskStage>> getTicketStatus() async {
    await _init();
    String text = '';
    if (prefs != null) {
      text = prefs.getString(_aliasName);
    } else
      _prefs.then((prefs) {
        text = prefs.getString(_aliasName);
      });
    if (text != null) {
      List _listContact = json.decode(text);
      List<HelpDeskStage> list = _listContact
          .map((contact) => HelpDeskStage.fromJson(contact))
          .toList();
//      list.sort((a,b)=>a.name.compareTo(b.name));
      return list;
    }
    return [];
  }
}
