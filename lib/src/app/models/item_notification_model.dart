class ItemNotificationModel {
  ItemNotificationModel({this.image, this.type, this.time, this.description});

  final String image;
  final String type;
  final String time;
  final String description;
  //https://www.telegraph.co.uk/content/dam/telegraph-connect/small-business/Twitter-logo.jpg?imwidth=450
  static List<ItemNotificationModel> listItemNewNotificationModel = <ItemNotificationModel>[
    new ItemNotificationModel(image: "https://www.teachertube.com/dist/images/Default-Media-Video.png",
        type: "Youtube", time: '3h ago', description: 'New Video By'),
    new ItemNotificationModel(image: "https://upload.wikimedia.org/wikipedia/commons/1/16/Facebook-icon-1.png",
        type: "Facebook", time: '4h ago', description: 'New Video By'),
    new ItemNotificationModel(image: "https://www.telegraph.co.uk/content/dam/telegraph-connect/small-business/Twitter-logo.jpg?imwidth=450",
        type: "Twitter", time: '5h ago', description: 'New Video By')
  ];
}
