import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ts24care/src/app/core/app_setting.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/helper/utils.dart';
import 'package:ts24care/src/app/models/customer.dart';
import 'package:ts24care/src/app/models/helpdesk-category.dart';
import 'package:ts24care/src/app/models/helpdesk-ticket.dart';
import 'package:ts24care/src/app/models/ir-attachment.dart';
import 'package:ts24care/src/app/models/item_attachment_model.dart';
import 'package:ts24care/src/app/models/item_custom_popup_menu.dart';
import 'package:ts24care/src/app/models/mail-message.dart';
import 'package:ts24care/src/app/widgets/ts24CameraWidget/ts24_camera_widget.dart';
import 'package:ts24care/src/app/widgets/ts24_utils_widget.dart';

class TicketDetailViewModel extends ViewModelBase {
  Customer customer = Customer();
  MenuStatusState statusState;
  CustomPopupMenu customPopupMenu;
  HelpdeskTicket helpdeskTicket;
  List<MailMessage> listMailMessage = List();
  List<IrAttachment> listAttachContent = List();
  bool isLoadingListAttachContent = false;
  List<HelpDeskCategory> listHelpDeskCategory = List();
  HelpDeskCategory helpDeskCategory;
  TextEditingController descriptionEditingController = TextEditingController();
  List<ItemAddAttachmentModel> listAddAttachmentModel = List();
  bool ticketChanged = false;
  Color statusTicketColor;
  TicketDetailViewModel() {
    loading = true;
    statusState = MenuStatusState.NEW;
    descriptionEditingController.addListener(() {
      this.updateState();
    });
  }
  onSelected(MenuStatusState status) {
    switch (status) {
      case MenuStatusState.SOLVED:
      case MenuStatusState.IN_PROGRESS:
      case MenuStatusState.CANCEL:
      case MenuStatusState.NEW:
      case MenuStatusState.CANCEL:
      case MenuStatusState.ALL:
        statusState = status;
        break;
    }
    this.updateState();
  }

  onLoadHelpDeskCategory(int id) async {
    var _listHelpDeskCategory = await api.getListCategoryOfTicket();
    if (_listHelpDeskCategory.length > 0) {
      listHelpDeskCategory = _listHelpDeskCategory;
//      getHelpDeskCategory(id);
    }
  }

//  getHelpDeskCategory(int id) {
//    var list = listHelpDeskCategory.where((category) => category.id == id);
//    if (list.length > 0) {
//      List<HelpDeskCategory> listHelpDeskCategory = list;
//      helpDeskCategory = listHelpDeskCategory[0];
//    }
//    this.updateState();
//  }

  onLoad(int id) async {
    loading = true;
    this.updateState();
    var ticket = await api.getTicketById(id);
    helpdeskTicket = ticket;
    if (helpdeskTicket.categoryId is List) {
      statusTicketColor = (ticket.categoryId.length > 2 &&
          !(ticket.categoryId[2] is bool))
          ? parseStringToColor(
          ticket.categoryId[2].toString())
          : (ticket.categoryId.length > 2 &&
          ticket.categoryId[2] is bool)
          ? Colors.grey
          : ticket.categoryId.length > 0
          ? getColorCategory(
          ticket.categoryId[1])
          : Colors.grey;
      helpDeskCategory = HelpDeskCategory(
          id: helpdeskTicket.categoryId[0], name: helpdeskTicket.categoryId[1]);
    } else statusTicketColor = Colors.grey;
    customPopupMenu = CustomPopupMenu.getTicket(helpdeskTicket.stageId[0]);
//    isLoadingListAttachContent = true;
//    this.updateState();
    listAttachContent = helpdeskTicket.attachmentIds
        .map((item) => IrAttachment.fromJson(item))
        .toList();
//    if (_listAttachment.length > 0) {
//      listAttachContent.clear();
//      int count = 0;
//      for (int i = 0; i < _listAttachment.length; i++) {
//            api.getAttachmentById(_listAttachment[i].id).then((irAttachment){
//              count ++;
//                if (irAttachment != null) listAttachContent.add(irAttachment);
//                if(count == _listAttachment.length) {
//                  isLoadingListAttachContent = false;
//                  this.updateState();
//                }
//              });
//      }
//    }
    listMailMessage = helpdeskTicket.messageIds
        .map((item) => MailMessage.fromJson(item))
        .toList();
//    helpDeskCategory =
    loading = false;
    this.updateState();
  }

  attachmentUploading() {
    listAddAttachmentModel.add(ItemAddAttachmentModel(
      id: -1,
      extension: "temp",
      fileName: "empty",
      localDirectory: "empty",
      data: null,
    ));
  }

  attachmentUploaded() {
    listAddAttachmentModel.removeLast();
  }

  Future<int> onAddAttachmentToSever(Uint8List image, String fileName) async {
    attachmentUploading();
    this.updateState();
    int id = await api.insertAttachMent(
        irAttachment: IrAttachment(name: fileName), file: image);
    attachmentUploaded();
    return id;
  }

  onSelectedAttachment(MenuAttachmentState attachmentState) {
    switch (attachmentState) {
      case MenuAttachmentState.IMAGE:
        onPickerImage();
        break;
      case MenuAttachmentState.FILE:
        onPickerFile();
        break;
    }
  }

  onSelectedCamera() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TS24CameraWidget()),
    ).then((directory) {
      if (directory != null) {
        readFileByte(directory).then((image) {
          if (image != null) {
            String _fileName = getFileNameFromPath(directory);
            String _extension = getExtensionFromPath(directory);
            onAddAttachmentToSever(image, _fileName).then((id) {
              listAddAttachmentModel.add(ItemAddAttachmentModel(
                  id: id,
                  localDirectory: directory,
                  fileName: _fileName,
                  extension: _extension,
                  data: image));
              print("ID of attachment :" + id.toString());
              this.updateState();
            });
          }
          print("PATH image:" + directory);
        });
      }
    });
  }

  onPickerImage() async {
    try {
      var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
      if (imageFile.path != null) {
        readFileByte(imageFile.path).then((image) {
          if (image != null) {
            String _fileName = getFileNameFromPath(imageFile.path);
            String _extension = getExtensionFromPath(imageFile.path);
            onAddAttachmentToSever(image, _fileName).then((id) {
              listAddAttachmentModel.add(ItemAddAttachmentModel(
                  id: id,
                  localDirectory: imageFile.path,
                  fileName: _fileName,
                  extension: _extension,
                  data: image));
              this.updateState();
            });
          }
        });
      }
    } catch (e) {
      print(e);
    }
  }

  onPickerFile() async {
    try {
      var path = await FilePicker.getFilePath(type: FileType.any);
      if (path != null) {
        String _extension = getExtensionFromPath(path);
        String _fileName = getFileNameFromPath(path);
        switch (_extension) {
          case "jpg":
          case "jpeg":
          case "png":
          case "gif":
          case "bmp":
            readFileByte(path).then((image) {
              if (image != null) {
                onAddAttachmentToSever(image, _fileName).then((id) {
                  listAddAttachmentModel.add(ItemAddAttachmentModel(
                      id: id,
                      localDirectory: path,
                      fileName: _fileName,
                      extension: _extension,
                      data: image));
                  this.updateState();
                });
              }
            });
            break;
          default:
            readFileByte(path).then((data) {
              if (data != null) {
                onAddAttachmentToSever(data, _fileName).then((id) {
                  listAddAttachmentModel.add(ItemAddAttachmentModel(
                      id: id,
                      localDirectory: path,
                      fileName: _fileName,
                      extension: _extension,
                      data: data));
                  this.updateState();
                });
              }
            });
            break;
        }
      }
    } catch (e) {
      print(e);
    }
  }

//  onSelectedTicketStatus(CustomPopupMenu customPopupMenu) {
//    switch (customPopupMenu.state) {
//      case MenuStatusState.SOLVED:
//      case MenuStatusState.IN_PROGRESS:
//      case MenuStatusState.CANCEL:
//      case MenuStatusState.NEW:
//      case MenuStatusState.CANCEL:
//      case MenuStatusState.ALL:
//        statusState = customPopupMenu.state;
//        helpdeskTicket.stageId = [
//          customPopupMenu.id,
//          getNameTicketStatus(customPopupMenu.id)
//        ];
////        api.updateTickets(helpdeskTicket).then((result){
////          if(result){
////            print("thanh cong");
////          }else print("that bai");
////        });
//        break;
//    }
//    this.updateState();
//  }

  onSend() async {
    String _description = parse(descriptionEditingController.text).outerHtml;
    List<int> _listAttachment =
        listAddAttachmentModel.map((model) => model.id).toList();
    MailMessage _mailMessage = MailMessage(
      subject: "",
      resId: helpdeskTicket.id,
      emailFrom: customer.email.toString(),
      authorId: customer.id,
      model: 'helpdesk.ticket',
      body: _description,
//      attachmentIds: listAddAttachmentModel.map((model) => model.id).toList(),
    );
    var result = await api.insertMailMessageForTicket(
        mailMessage: _mailMessage, listAttachmentId: _listAttachment);
    if (result != null) {
      HelpdeskTicket updateHeldesk = HelpdeskTicket();
      updateHeldesk.id = this.helpdeskTicket.id;
      updateHeldesk.stageId = 1;
      bool updateTicketResult = await api.updateTickets(updateHeldesk);
      if (updateTicketResult) {
//      _mailMessage.attachmentIds =
//          listAddAttachmentModel.map((model) => model.id).toList();
//      listMailMessage.add(_mailMessage);
        descriptionEditingController.text = '';
        FocusScope.of(context).unfocus();
        listAddAttachmentModel.clear();
        onLoad(helpdeskTicket.id);
        ticketChanged = true;
//      this.updateState();
//      onLoad(helpdeskTicket.id);
//      LoadingDialog.showMsgDialog(context, "Gửi message Thành Công.");
        print("Thanh cong");
      }
    } else {
      LoadingDialog.showMsgDialog(context, "Thất bại.");
      print("That bai");
    }
    this.updateState();
  }
}
