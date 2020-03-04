class ItemTicketsModel{
  final String userName;
  final String title;
  final String content;
  final String time;
  final String avatarUrl;

  ItemTicketsModel({this.userName, this.title, this.content, this.time,this.avatarUrl});
  static List<ItemTicketsModel> listItemTickets = [
    ItemTicketsModel(
      title: "Hỗ trợ tư vấn thuế",
      content: "Nội dung tư vẫn thuế",
      userName: "Nguyễn Hoàng",
      avatarUrl: "https://vanmaymoingay.com/wp-content/uploads/2019/12/gi%E1%BA%ADt-l%C3%B4ng-m%C3%A0y-ph%E1%BA%A3i-2.jpg",
      time: "9:35"
    ),ItemTicketsModel(
      title: "Hỗ trợ tư vấn bảo hiêm",
      content: "Nội dung tư bảo hiểm",
      userName: "Nguyễn Thùy",
      avatarUrl: "https://vanmaymoingay.com/wp-content/uploads/2019/12/gi%E1%BA%ADt-l%C3%B4ng-m%C3%A0y-ph%E1%BA%A3i-2.jpg",
      time: "9:35"
    ),ItemTicketsModel(
      title: "Phiếu thu chi thuế",
      content: "Nội dung tư vẫn thu chi thuế",
      userName: "Nguyễn Cần",
      avatarUrl: "https://vanmaymoingay.com/wp-content/uploads/2019/12/gi%E1%BA%ADt-l%C3%B4ng-m%C3%A0y-ph%E1%BA%A3i-2.jpg",
      time: "9:35"
    ),ItemTicketsModel(
      title: "Hỗ trợ tư phiếu ghi hàng",
      content: "Nội dung tư vẫn hàng hóa",
      userName: "Nguyễn Nam",
      avatarUrl: "https://vanmaymoingay.com/wp-content/uploads/2019/12/gi%E1%BA%ADt-l%C3%B4ng-m%C3%A0y-ph%E1%BA%A3i-2.jpg",
      time: "9:35"
    ),
  ];
}