import 'package:flutter/cupertino.dart';
import 'package:ts24care/packages/loader_search_bar/loader_search_bar.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/helper/utils.dart';
import 'package:ts24care/src/app/models/item_tickets_model.dart';
import 'package:ts24care/src/app/pages/ticket/new/ticket_new_page.dart';

enum SearchBarState { active, cancel, clear, submit }

class TicketPageViewModel extends ViewModelBase {
  SearchBarController searchBarController;
  SearchBarState searchBarState = SearchBarState.cancel;
  List<String> listHistorySearch = List();
  List<String> listHistoryFiltered = List();
  List<ItemTicketsModel> listTicketFiltered = List();
  TicketPageViewModel() {
    searchBarController = SearchBarController(
        onActivatedChanged: onActivatedChangedSearchBar,
        onCancelSearch: onCancelSearchBar,
        onClearQuery: onClearQuery);
  }
  onTapCreateTicket() {
    Navigator.pushNamed(context, TicketNewPage.routeName);
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
    listHistoryFiltered = _filterTicketHistory(query, listHistorySearch);
    this.updateState();
  }

  onQuerySubmitted(String query) {
    print("ON_SUBMIT");
    print(query);
    listTicketFiltered =
        _filterItemTicket(query, ItemTicketsModel.listItemTickets);
    listHistorySearch.insert(0, query);
    searchBarState = SearchBarState.submit;
    this.updateState();
  }

  List<ItemTicketsModel> _filterItemTicket(
      String text, List<ItemTicketsModel> listItemTicketModel) {
    return listItemTicketModel
        .where((item) =>
            compareText(item.title, text) ||
            compareText(item.userName, text) ||
            compareText(item.content, text))
        .toList();
  }

  List<String> _filterTicketHistory(
      String text, List<String> listTicketHistory) {
    return (text != '' && listTicketHistory.length > 0)
        ? listTicketHistory.where((item) => compareText(item, text)).toList()
        : listTicketHistory;
  }

  onTapItemTicketHistory(String text) {
    searchBarController.setQueryText(text);
    searchBarController.state.onUnFocus();
    onQuerySubmitted(text);
  }
}
