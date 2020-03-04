import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:async/async.dart';
import 'package:ts24care/src/app/models/message.dart';
import 'package:ts24care/src/app/services/common-service.dart';
import 'package:ts24care/src/app/services/encrypt-service.dart';

class CloudFiresStoreService {
  //final Geoflutterfire _geo = Geoflutterfire();
  final CollectionChat chat = CollectionChat();
  static final CloudFiresStoreService _singleton =
      new CloudFiresStoreService._internal();

  factory CloudFiresStoreService() {
    return _singleton;
  }
  CloudFiresStoreService._internal();
}

class InterfaceFireStore {
  final Firestore _firestore = Firestore.instance;
  DocumentReference _docRef;
  final String fieldPathDocumentId = '__name__';
  final String split = "-";
}

class CollectionChat extends InterfaceFireStore {
  final _collectionName = "chat";

  Future sendMessage(
      {String strId,
      String strPeerId,
      String strPeerName,
      String content}) async {
    var id = EncrypteService.encryptHash(strId),
        peerId = EncrypteService.encryptHash(strPeerId),
        groupChatId = "";
    if (id.hashCode <= peerId.hashCode) {
      groupChatId = '$id$split$peerId';
    } else {
      groupChatId = '$peerId$split$id';
    }
    Messages message = Messages();
    message.senderId = strId;
    message.receiverId = strPeerId;
    message.content = content;
    message.timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    message.type = 0;
    message.receiverName = strPeerName;
    var _jsonMessKey = Map<String, dynamic>.from(message.toJson());
    _jsonMessKey["keyword"] =
        Common.createKeyWordForChat(groupChatId, split: split);
    _firestore
        .collection(_collectionName)
        .document(groupChatId)
        .setData(_jsonMessKey);
    var documentReference = _firestore
        .collection(_collectionName)
        .document(groupChatId)
        .collection(String.fromCharCodes(groupChatId.runes.toList().reversed))
        .document();
    // api.postNotificationSendMessage(message);
    return await _firestore.runTransaction((transaction) async {
      await transaction.set(
        documentReference,
        message.toJson(),
      );
    });
  }

  ///listen List Message by User Id
  Future<Stream<QuerySnapshot>> listenListMessageByUserId(String strId) async {
    final id = EncrypteService.encryptHash(strId);
    return _firestore
        .collection(_collectionName)
        .where("keyword", arrayContains: id)
        .snapshots();
    // var id = EncrypteService.encrypt(strId).base64,
    //     peerId = EncrypteService.encrypt("User03").base64,
    //     groupChatId = "";
    // if (id.hashCode <= peerId.hashCode) {
    //   groupChatId = '$id-$peerId';
    // } else {
    //   groupChatId = '$peerId-$id';
    // }
    // return _firestore
    //     .collection('chat')
    //     .document(groupChatId)
    //     .collection(String.fromCharCodes(groupChatId.runes.toList().reversed))
    //     .snapshots();
  }

  ///listen List Message by id and peerID
  Future<Stream<QuerySnapshot>> listenListMessageByIdAndPeerId(
      String strId, String strPeerId) async {
    var id = EncrypteService.encryptHash(strId),
        peerId = EncrypteService.encryptHash(strPeerId),
        groupChatId = "";
    if (id.hashCode <= peerId.hashCode) {
      groupChatId = '$id$split$peerId';
    } else {
      groupChatId = '$peerId$split$id';
    }
    return _firestore
        .collection(_collectionName)
        .document(groupChatId)
        .collection(String.fromCharCodes(groupChatId.runes.toList().reversed))
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
