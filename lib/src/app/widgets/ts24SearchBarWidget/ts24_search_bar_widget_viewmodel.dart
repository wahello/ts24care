import 'dart:async';

import 'package:ts24care/packages/loader_search_bar/src/SearchBarController.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/helper/utils.dart';

enum SearchBarState { active, cancel, clear, submit }
typedef OnQueryCallBack = void Function(String query);
typedef SearchBarStateCallBack = void Function(SearchBarState state);

class TS24SearchBarWidgetViewModel extends ViewModelBase {
  SearchBarController searchBarController;
  SearchBarState searchBarState = SearchBarState.cancel;
  List<String> listHistorySearch = List();
  List<String> listHistoryFiltered = List();
  bool searching = false;
  String query = '';
  Timer _timer;
//  List<ItemTicketsModel> listTicketFiltered = List();
  TS24SearchBarWidgetViewModel();
  onListen(SearchBarStateCallBack searchBarStateCallBack) {
    searchBarController = SearchBarController(onActivatedChanged: (status) {
      onActivatedChangedSearchBar(status);
      searchBarStateCallBack(searchBarState);
    }, onCancelSearch: () {
      onCancelSearchBar();
      searchBarStateCallBack(searchBarState);
    }, onClearQuery: () {
      onClearQuery();
      searchBarStateCallBack(searchBarState);
    });
  }

  onTapCreateTicket() {
//    Navigator.pushNamed(context, TicketNewPage.routeName);
  }

  onActivatedChangedSearchBar(bool status) {
    print("ON_ACTIVATED");
    searchBarController.startSearch();
    searchBarState = SearchBarState.active;
    this.updateState();
  }

  onCancelSearchBar() {
    print("ON_CANCEL");
    searchBarController.cancelSearch();
    searchBarState = SearchBarState.cancel;
    this.updateState();
  }

  onClearQuery() {
    print("ON_CLEAR");
    searchBarController.clearQuery();
    searchBarState = SearchBarState.clear;
    this.updateState();
  }

  onQueryChanged(String query) {
    print("ON_CHANGED");
    if (query != '' && query != null) {
      if (this.query != query) {
        searching = true;
        if (_timer != null && _timer.isActive) {
          _timer.cancel();
          print("Cancel:" + query);
        }
      }
      this.query = query;
    } else {
      if (query == "" && _timer != null && _timer.isActive) {
        _timer.cancel();
        searching = false;
      }
      searchBarState = SearchBarState.active;
    }
    listHistoryFiltered = _filterTicketHistory(query, listHistorySearch);
    _timer = new Timer(const Duration(seconds: 2), () {
      if (this.query != '' && this.query == query) {
        if (listHistorySearch.contains(query)) listHistorySearch.remove(query);
        listHistorySearch.insert(0, query);
        searchBarState = SearchBarState.submit;
        searching = false;
        this.updateState();
      }
    });
    this.updateState();
  }

  onQuerySubmitted(String query) {
    print("ON_SUBMIT");
//    listTicketFiltered =
//        _filterItemTicket(query, ItemTicketsModel.listItemTickets);
    if (listHistorySearch.contains(query)) listHistorySearch.remove(query);
    listHistorySearch.insert(0, query);
    searchBarState = SearchBarState.submit;
    searching = false;
    this.updateState();
  }

  onTapItemTicketHistory(String text) {
    searchBarController.setQueryText(text);
    searchBarController.state.onUnFocus();
    onQuerySubmitted(text);
  }

  List<String> _filterTicketHistory(
      String text, List<String> listTicketHistory) {
    return (text != '' && listTicketHistory.length > 0)
        ? listTicketHistory.where((item) => compareText(item, text)).toList()
        : listTicketHistory;
  }

  @override
  void dispose() {
    if (_timer.isActive) _timer.cancel();
    super.dispose();
  }
}
