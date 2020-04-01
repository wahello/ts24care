import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ts24care/src/app/core/app_setting.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/helper/utils.dart';
import 'package:ts24care/src/app/helper/validator-helper.dart';
import 'package:ts24care/src/app/models/customer.dart';
import 'package:ts24care/src/app/models/helpdesk-category.dart';
import 'package:ts24care/src/app/models/helpdesk-ticket.dart';
import 'package:ts24care/src/app/models/ir-attachment.dart';
import 'package:ts24care/src/app/models/item_attachment_model.dart';
import 'package:ts24care/src/app/models/item_custom_popup_menu.dart';
import 'package:ts24care/src/app/widgets/ts24CameraWidget/ts24_camera_widget.dart';
import 'package:ts24care/src/app/widgets/ts24_utils_widget.dart';

class TicketNewPageViewModel extends ViewModelBase {
  Customer customer = Customer();
  MenuStatusState statusState;
  CustomPopupMenu customPopupMenu;
  List<ItemAddAttachmentModel> listAttachmentModel = List();
  List<HelpDeskCategory> listHelpDeskCategory = List();
  HelpDeskCategory helpDeskCategory;
  TextEditingController subjectTextEditingController = TextEditingController();
  TextEditingController descriptionEditingController = TextEditingController();
  List<String> listImage = List();
  String errorSubject;
  TicketNewPageViewModel() {
    customPopupMenu = CustomPopupMenu.listTicketStatus[0];
    statusState = MenuStatusState.NEW;
    subjectTextEditingController.addListener(() => {isValidSubject()});
    listHelpDeskCategory
        .add(HelpDeskCategory(id: -1, name: "Không chọn dịch vụ"));
    onLoad();
  }
  onLoad() async {
    listHelpDeskCategory.removeRange(1, listHelpDeskCategory.length);
    var _listHelpDeskCategory = await api.getListCategoryOfTicket();
    if (_listHelpDeskCategory != null) {
      listHelpDeskCategory.addAll(_listHelpDeskCategory);
      helpDeskCategory = listHelpDeskCategory[0];
      this.updateState();
    }
  }

  onTapBack() {
    Navigator.pop(context);
  }

  bool isValidSubject() {
    errorSubject = null;
    var result = Validator.validateName(subjectTextEditingController.text);
    if (result != null) {
      errorSubject = result;
      this.updateState();
      return false;
    } else
      this.updateState();
    return true;
  }

  Future<int> onAddAttachmentToSever(Uint8List image, String fileName) async {
    attachmentUploading();
    this.updateState();
    int id = await api.insertAttachMent(
        irAttachment: IrAttachment(name: fileName), file: image);
    attachmentUploaded();
    return id;
  }

  attachmentUploading() {
    listAttachmentModel.add(ItemAddAttachmentModel(
      id: -1,
      extension: "temp",
      fileName: "empty",
      localDirectory: "empty",
      data: null,
    ));
  }

  attachmentUploaded() {
    listAttachmentModel.removeLast();
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
              listAttachmentModel.add(ItemAddAttachmentModel(
                  id: id,
                  localDirectory: directory,
                  fileName: _fileName,
                  extension: _extension,
                  data: image));
              print(id);
              this.updateState();
            });
          }
        });
        print(directory);
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
              listAttachmentModel.add(ItemAddAttachmentModel(
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
                  listAttachmentModel.add(ItemAddAttachmentModel(
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
                  listAttachmentModel.add(ItemAddAttachmentModel(
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

  onSelectedTicketStatus(MenuStatusState status) {
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

  onSelectedHelpDeskCategory(HelpDeskCategory helpDeskCategory) {
    this.helpDeskCategory = helpDeskCategory;
    this.updateState();
  }

  onSend() async {
    if (isValidSubject()) {
      String _description = parse(descriptionEditingController.text).outerHtml;
      HelpdeskTicket _helpDeskTicket;
      if (helpDeskCategory.id == -1) {
        _helpDeskTicket = HelpdeskTicket(
            contactName: customer.name,
            description: _description,
            email: customer.email.toString(),
            subject: subjectTextEditingController.text,
            partnerId: customer.id,
            stageId: statusState.index + 1,
            createUid: customer.id,
            writeUid: customer.id);
      } else
        _helpDeskTicket = HelpdeskTicket(
            contactName: customer.name,
            description: _description,
            email: customer.email.toString(),
            subject: subjectTextEditingController.text,
            partnerId: customer.id,
            stageId: statusState.index + 1,
            createUid: customer.id,
            writeUid: customer.id,
            categoryId: helpDeskCategory.id);
      List<int> _listAttachment =
          listAttachmentModel.map((model) => model.id).toList();
      var result = await api.insertTickets(
          ticket: _helpDeskTicket, listAttachmentId: _listAttachment);
      if (result != null) {
        Navigator.pop(context, true);
        ToastController.show(
            context: context,
            message: "Tạo phiếu yêu cầu thành công.",
            duration: Duration(seconds: 2));
        print("Thanh cong");
      } else {
        LoadingDialog.showMsgDialog(
            context, "Tạo phiếu yêu cầu thất bại, vui lòng thử lại.");
        print("That bai");
      }
    }
  }
}
