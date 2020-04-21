import 'dart:math';

class ItemNotificationModel {
  ItemNotificationModel({this.image, this.type, this.time, this.description});

  final String image;
  final String type;
  final String time;
  final String description;

  static List<ItemNotificationModel> listNotifications(){
    List<ItemNotificationModel> listItemNewNotificationModel =[];
    var rng = new Random();
    var number = 1;
    print('number $number');
    if(number == 0)
      return listItemNewNotificationModel =[];
    return listItemNewNotificationModel = <ItemNotificationModel>[
      new ItemNotificationModel(image: "https://www.teachertube.com/dist/images/Default-Media-Video.png",
          type: "Youtube", time: '15:30 PM 06/04/2020', description: 'acb xyz bbb www zzz kkk'),
      new ItemNotificationModel(image: "https://upload.wikimedia.org/wikipedia/commons/1/16/Facebook-icon-1.png",
          type: "Facebook", time: '4h ago', description: 'New Video By'),
      new ItemNotificationModel(image: "https://www.telegraph.co.uk/content/dam/telegraph-connect/small-business/Twitter-logo.jpg?imwidth=450",
          type: "Twitter", time: '5h ago', description: 'New Video By')
    ];
  }

//  static List<ItemNotificationModel> listItemNewNotificationModel =[];
//  static List<ItemNotificationModel> listItemNewNotificationModel = <ItemNotificationModel>[
//    new ItemNotificationModel(image: "https://www.teachertube.com/dist/images/Default-Media-Video.png",
//        type: "Youtube", time: '3h ago', description: 'New Video By'),
//    new ItemNotificationModel(image: "https://upload.wikimedia.org/wikipedia/commons/1/16/Facebook-icon-1.png",
//        type: "Facebook", time: '4h ago', description: 'New Video By'),
//    new ItemNotificationModel(image: "https://www.telegraph.co.uk/content/dam/telegraph-connect/small-business/Twitter-logo.jpg?imwidth=450",
//        type: "Twitter", time: '5h ago', description: 'New Video By')
//  ];
}
