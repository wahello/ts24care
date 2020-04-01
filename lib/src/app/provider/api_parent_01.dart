import 'dart:convert';
import 'dart:typed_data';

import 'package:ts24care/src/app/core/app_setting.dart';
import 'package:ts24care/src/app/models/blog-post.dart';
import 'package:ts24care/src/app/models/customer.dart';
import 'package:ts24care/src/app/models/helpdesk-category.dart';
import 'package:ts24care/src/app/models/helpdesk-stage.dart';
import 'package:ts24care/src/app/models/helpdesk-ticket.dart';
import 'package:ts24care/src/app/models/ir-attachment.dart';
import 'package:ts24care/src/app/models/knowsystem-article.dart';
import 'package:ts24care/src/app/models/knowsystem-section.dart';
import 'package:ts24care/src/app/models/mail-message.dart';
import 'package:ts24care/src/app/models/product-category.dart';
import 'package:ts24care/src/app/models/product-warranty.dart';
import 'package:ts24care/src/app/models/res-partner.dart';
import 'api_master.dart';
import 'package:http/http.dart' as http;

enum TypeImage {
  SMALL,
  MEDIUM,
  ORIGINAL,
}

class Api1 extends ApiMaster {
  Api1();

  ///Kiểm tra thông tin đăng nhập.
  ///Trả về true or false.
  Future<StatusCodeGetToken> checkLogin(
      {String username, String password}) async {
    StatusCodeGetToken result = StatusCodeGetToken.FALSE;
    this.grandType = GrandType.password;
    this.clientId = password_client_id;
    this.clienSecret = password_client_secret;
    this.username = username;
    this.password = password;
    result = await this.authorization(refresh: true);
    return result;
  }

  //Lấy thông tin khách hàng
  /// Lấy thông tin user session.
  ///
  ///  Trả về {
  ///  "uid": 3,
  ///   "name": "Max"
  ///   "partnerId": 2
  /// }
  Future<dynamic> getCustomerInfoAfterLogin() async {
    Future<ResPartner> _getPartner(dynamic uid) async {
      await this.authorization();
      body = new Map();
      body["fields"] = [
        "company_id",
        "company_name",
        "company_type",
        "contact_address",
        "contract_ids",
        "contracts_count",
        "country_id",
        "create_date",
        "create_uid",
        "credit",
        "credit_limit",
        "currency_id",
        "customer",
        "date",
        "debit",
        "debit_limit",
        "display_name",
        "email",
        "email_formatted",
        "employee",
        "id",
        "im_status",
        "is_company",
        "is_published",
        "is_seo_optimized",
        "journal_item_count",
        "lang",
        "mobile",
        "name",
        "parent_id",
        "parent_name",
        "partner_gid",
        "partner_share",
        "phone",
        "state_id",
        "street",
        "street2",
        "supplier",
        "team_id",
        "title",
        "total_invoiced",
        "trust",
        "type",
        "user_id",
        "user_ids",
        "vat"
      ];
      body["domain"] = [
        ['user_ids', '=', uid]
      ];
      var params = convertSerialize(body);
      List<ResPartner> listResult = new List();
      ResPartner resPartner;
      return http
          .get('${this.api}/search_read/res.partner?$params',
              headers: this.headers)
          .then((http.Response response) {
        if (response.statusCode == 200) {
          List list = json.decode(response.body);
          print(list);
          if (list.length > 0)
            listResult = list.map((item) => ResPartner.fromJson(item)).toList();
          resPartner = listResult[0];
        }
        return resPartner;
      }).catchError((error) {
        return resPartner;
      });
    }

    await this.authorization();
    return http
        .get('${this.api}/user', headers: this.headers)
        .then((http.Response response) async {
      if (response.statusCode == 200) {
        this.updateCookie(response);
        var userInfo = json.decode(response.body);
        this.grandType = GrandType.client_credentials;
        this.clientId = client_id;
        this.clienSecret = client_secret;
        var partner = await _getPartner(userInfo["uid"]);
        Customer customer = Customer();
        customer.fromResPartner(partner);
        customer.saveLocal();
        return userInfo;
      } else
        return null;
    }).catchError((error) {
      return null;
    });
  }

  ///Lấy danh sách blog
  Future<List<BlogPost>> getListBlogs({int offset, int limit}) async {
    await this.authorization();
    List<BlogPost> listResult = new List();
    body = new Map();
    body["offset"] = offset.toString();
    body["limit"] = limit.toString();
    body["gmt"] = DateTime.now().timeZoneOffset.inHours.toString();
    return http
        .post('${this.api}/${this.nameCustomApi}/listBlog',
            headers: this.headers, body: body)
        .then((http.Response response) {
      if (response.statusCode == 200) {
        this.updateCookie(response);
        List list = json.decode(response.body);
        if (list.length > 0) {
          listResult = list.map((item) => BlogPost.fromJson(item)).toList();
        }
      }

      return listResult;
    }).catchError((error) {
      return listResult;
    });
  }

  ///Lấy danh sách bản tin
  Future<List<BlogPost>> searchBlogs(
      {String keyword, int offset, int limit}) async {
    await this.authorization();
    List<BlogPost> listResult = new List();
    body = new Map();
    body["offset"] = offset.toString();
    body["limit"] = limit.toString();
    body["gmt"] = DateTime.now().timeZoneOffset.inHours.toString();
    body["keyword"] = keyword;
    return http
        .post('${this.api}/${this.nameCustomApi}/listSearchBlog_KeyWord',
            headers: this.headers, body: body)
        .then((http.Response response) {
      if (response.statusCode == 200) {
        this.updateCookie(response);
        List list = json.decode(response.body);
        if (list.length > 0) {
          listResult = list.map((item) => BlogPost.fromJson(item)).toList();
        }
      }

      return listResult;
    }).catchError((error) {
      return listResult;
    });
  }

  ///Lấy chi tiết bản tin theo id
  Future<BlogPost> getBlogById(int id) async {
    await this.authorization();
    List<BlogPost> listResult = new List();
    BlogPost blogPost;
    body = new Map();
    body["id"] = id.toString();
    body["gmt"] = DateTime.now().timeZoneOffset.inHours.toString();
    return http
        .post('${this.api}/${this.nameCustomApi}/getContentBlog',
            headers: this.headers, body: body)
        .then((http.Response response) {
      if (response.statusCode == 200) {
        List list = json.decode(response.body);
        if (list.length > 0) {
          listResult = list.map((item) => BlogPost.fromJson(item)).toList();
          blogPost = listResult[0];
        }
      }

      return blogPost;
    }).catchError((error) {
      return blogPost;
    });
  }

  ///Lấy danh sách ticket theo status
  ///@param int status
  ///0: Lấy tất cả
  ///1: New
  ///2: In Progress
  ///3: Solved
  ///4: Canceled
  Future<List<HelpdeskTicket>> getListTicketByStatus(
      {int status = 0, int offset, int limit}) async {
    await this.authorization();
    List<HelpdeskTicket> listResult = new List();
    Customer customer = Customer();
    body = new Map();
    body["partner_id"] = customer.id.toString();
    body["stage"] = status.toString();
    body["offset"] = offset.toString();
    body["limit"] = limit.toString();
    body["gmt"] = DateTime.now().timeZoneOffset.inHours.toString();
    return http
        .post('${this.api}/${this.nameCustomApi}/listTicket_Status',
            headers: this.headers, body: body)
        .then((http.Response response) {
      if (response.statusCode == 200) {
        this.updateCookie(response);
        List list = json.decode(response.body);
        if (list.length > 0) {
          listResult =
              list.map((item) => HelpdeskTicket.fromJson(item)).toList();
        }
      }

      return listResult;
    }).catchError((error) {
      return listResult;
    });
  }

  ///Tìm kiếm ticket theo keyword
  Future<List<HelpdeskTicket>> searchTickets(
      {String keyword, int offset, int limit}) async {
    await this.authorization();
    List<HelpdeskTicket> listResult = new List();
    Customer customer = Customer();
    body = new Map();
    body["partner_id"] = customer.id.toString();
    body["keyword"] = keyword;
    body["offset"] = offset.toString();
    body["limit"] = limit.toString();
    body["gmt"] = DateTime.now().timeZoneOffset.inHours.toString();
    return http
        .post('${this.api}/${this.nameCustomApi}/listSearchTicket_Keyword',
            headers: this.headers, body: body)
        .then((http.Response response) {
      if (response.statusCode == 200) {
        List list = json.decode(response.body);
        if (list.length > 0) {
          listResult =
              list.map((item) => HelpdeskTicket.fromJson(item)).toList();
        }
      }

      return listResult;
    }).catchError((error) {
      return listResult;
    });
  }

  ///Lấy danh sách category của ticket
  ///
  Future<List<HelpDeskCategory>> getListCategoryOfTicket() async {
    await this.authorization();
    body = new Map();
    body["fields"] = ["name", "id"];

    var params = convertSerialize(body);
    List<HelpDeskCategory> listResult = new List();
    return http
        .get('${this.api}/search_read/helpdesk.category?$params',
            headers: this.headers)
        .then((http.Response response) {
      if (response.statusCode == 200) {
        this.updateCookie(response);
        List list = json.decode(response.body);
        print(list);
        if (list.length > 0)
          listResult =
              list.map((item) => HelpDeskCategory.fromJson(item)).toList();
      }
      return listResult;
    }).catchError((error) {
      return listResult;
    });
  }

  ///Lấy danh sách status tickets
  ///
  Future<List<HelpDeskStage>> getStatusTicket() async {
    await this.authorization();
    body = new Map();
    body["fields"] = ["name"];

    var params = convertSerialize(body);
    List<HelpDeskStage> listResult = new List();
    return http
        .get('${this.api}/search_read/helpdesk.stage?$params',
            headers: this.headers)
        .then((http.Response response) {
      if (response.statusCode == 200) {
        this.updateCookie(response);
        List list = json.decode(response.body);
        print(list);
        if (list.length > 0)
          listResult =
              list.map((item) => HelpDeskStage.fromJson(item)).toList();
      }
      return listResult;
    }).catchError((error) {
      return listResult;
    });
  }

  ///Lấy chi tiết ticket theo id
  Future<HelpdeskTicket> getTicketById(int id) async {
    await this.authorization();
    List<HelpdeskTicket> listResult = new List();
    HelpdeskTicket helpdeskTicket;
    body = new Map();
    body["id"] = id.toString();
    body["gmt"] = DateTime.now().timeZoneOffset.inHours.toString();
    return http
        .post('${this.api}/${this.nameCustomApi}/getTicket',
            headers: this.headers, body: body)
        .then((http.Response response) {
      if (response.statusCode == 200) {
        this.updateCookie(response);
        List list = json.decode(response.body);
        if (list.length > 0) {
          listResult =
              list.map((item) => HelpdeskTicket.fromJson(item)).toList();
          helpdeskTicket = listResult[0];
        }
      }

      return helpdeskTicket;
    }).catchError((error) {
      return helpdeskTicket;
    });
  }

  ///Lấy danh sách category FAQ
  Future<List<KnowsystemSection>> getCategoryFAQ() async {
    await this.authorization();
    List<KnowsystemSection> listResult = new List();
    body = new Map();
    return http
        .post('${this.api}/${this.nameCustomApi}/listCategoryParentFAQ',
            headers: this.headers, body: body)
        .then((http.Response response) {
      if (response.statusCode == 200) {
        List list = json.decode(response.body);
        if (list.length > 0) {
          listResult =
              list.map((item) => KnowsystemSection.fromJson(item)).toList();
        }
      }

      return listResult;
    }).catchError((error) {
      return listResult;
    });
  }

  ///Lấy danh sách FAQ theo category
  ///@Param int id
  Future<List<KnowsystemArticle>> getListFAQByCategoryId(
      {int categoryId, int offset, int limit}) async {
    await this.authorization();
    List<KnowsystemArticle> listResult = new List();
    body = new Map();
    body["category_id"] = categoryId.toString();
    body["offset"] = offset.toString();
    body["limit"] = limit.toString();
    body["gmt"] = DateTime.now().timeZoneOffset.inHours.toString();
    return http
        .post('${this.api}/${this.nameCustomApi}/listFAQCategory',
            headers: this.headers, body: body)
        .then((http.Response response) {
      if (response.statusCode == 200) {
        List list = json.decode(response.body);
        if (list.length > 0) {
          listResult =
              list.map((item) => KnowsystemArticle.fromJson(item)).toList();
        }
      }

      return listResult;
    }).catchError((error) {
      return listResult;
    });
  }

  ///Tìm kiếm FAQ
  Future<List<KnowsystemArticle>> searchFAQ(
      {String keyword, int offset, int limit}) async {
    await this.authorization();
    List<KnowsystemArticle> listResult = new List();
    body = new Map();
    body["offset"] = offset.toString();
    body["limit"] = limit.toString();
    body["gmt"] = DateTime.now().timeZoneOffset.inHours.toString();
    body["keyword"] = keyword.toLowerCase();
    return http
        .post('${this.api}/${this.nameCustomApi}/listSearchFAQ_Keyword',
            headers: this.headers, body: body)
        .then((http.Response response) {
      if (response.statusCode == 200) {
        this.updateCookie(response);
        List list = json.decode(response.body);
        if (list.length > 0) {
          listResult =
              list.map((item) => KnowsystemArticle.fromJson(item)).toList();
        }
      }

      return listResult;
    }).catchError((error) {
      return listResult;
    });
  }

  ///Lấy chi tiết FAQ
  ///
  Future<KnowsystemArticle> getFAQDetail(int id) async {
    await this.authorization();
    body = new Map();
    body["domain"] = [
      ['id', '=', id],
    ];

    var params = convertSerialize(body);
    List<KnowsystemArticle> listResult = new List();
    KnowsystemArticle knowsystemArticle;
    return http
        .get('${this.api}/search_read/knowsystem.article?$params',
            headers: this.headers)
        .then((http.Response response) {
      if (response.statusCode == 200) {
        List list = json.decode(response.body);
        print(list);
        if (list.length > 0)
          listResult =
              list.map((item) => KnowsystemArticle.fromJson(item)).toList();
        knowsystemArticle = listResult[0];
      }
      return knowsystemArticle;
    }).catchError((error) {
      return knowsystemArticle;
    });
  }

  ///Lấy danh sách các danh mục dịch vụ khách hàng đang sử dụng
  Future<List<ProductCategory>> getCategoryTS24Product() async {
    await this.authorization();
    List<ProductCategory> listResult = new List();
    Customer customer = Customer();
    body = new Map();
    body["partner_id"] = customer.id.toString();
    return http
        .post('${this.api}/${this.nameCustomApi}/listProduct_Category_Active',
            headers: this.headers, body: body)
        .then((http.Response response) {
      if (response.statusCode == 200) {
        List list = json.decode(response.body);
        if (list.length > 0) {
          listResult =
              list.map((item) => ProductCategory.fromJson(item)).toList();
        }
      }

      return listResult;
    }).catchError((error) {
      return listResult;
    });
  }

  ///Lấy danh sách dịch vụ theo danh mục
  Future<List<ProductWarranty>> getProductWarrantyByCategoryId(
      int cateId) async {
    await this.authorization();
    List<ProductWarranty> listResult = new List();
    Customer customer = Customer();
    body = new Map();
    body["partner_id"] = customer.id.toString();
    body["categ_id"] = cateId.toString();
    return http
        .post('${this.api}/${this.nameCustomApi}/listProduct_Warranty',
            headers: this.headers, body: body)
        .then((http.Response response) {
      if (response.statusCode == 200) {
        List list = json.decode(response.body);
        if (list.length > 0) {
          listResult =
              list.map((item) => ProductWarranty.fromJson(item)).toList();
        }
      }

      return listResult;
    }).catchError((error) {
      return listResult;
    });
  }

  ///Hàm tạo ticket
  ///
  ///Success - Trả về new id
  ///
  ///Fail - Trả về null
  Future<dynamic> insertTickets(
      {HelpdeskTicket ticket, List<int> listAttachmentId}) async {
    await this.authorization();
    body = new Map();
    body["values"] = json.encode(ticket.toJson());
    body["listAttachment_id"] = listAttachmentId.toString();
    var result;
    return http
        .post('${this.api}/${this.nameCustomApi}/createTicket',
            headers: this.headers, body: body)
        .then((http.Response response) {
      if (response.statusCode == 200) {
        var list = json.decode(response.body);
        if (list is List) result = list[0];
        //print(list);
      } else {
        result = null;
      }
      return result;
    }).catchError((error) {
      return null;
    });
  }

  ///Lấy attachment theo id
  ///@param int id
  Future<IrAttachment> getAttachmentById(int id) async {
    await this.authorization();
    List<IrAttachment> listResult = new List();
    IrAttachment result;
    body = new Map();
    body["id"] = id.toString();
    return http
        .post('${this.api}/${this.nameCustomApi}/getAttachment',
            headers: this.headers, body: body)
        .then((http.Response response) {
      if (response.statusCode == 200) {
        List list = json.decode(response.body);
        if (list.length > 0) {
          listResult = list.map((item) => IrAttachment.fromJson(item)).toList();
          result = listResult[0];
        }
      }

      return result;
    }).catchError((error) {
      return result;
    });
  }

  ///Download attachment theo id
  ///@param int id
  Future<dynamic> getUrlDownloadAttachment(int id) async {
    await this.authorization();
    body = new Map();
    body["id"] = id.toString();
    return http
        .post('${this.api}/${this.nameCustomApi}/downloadAttachment',
            headers: this.headers, body: body)
        .then((http.Response response) {
      if (response.statusCode == 200) {
        List list = json.decode(response.body);
        return list;
      }

      return null;
    }).catchError((error) {
      return null;
    });
  }

  ///Tạo attachment file
  ///@param
  Future<dynamic> insertAttachMent(
      {IrAttachment irAttachment, Uint8List file}) async {
    await this.authorization();
    body = new Map();
    body["values"] = json.encode(irAttachment.toJson());
    body["contentBase64"] = base64.encode(file);
    return http
        .post('${this.api}/${this.nameCustomApi}/createAttachment',
            headers: this.headers, body: body)
        .then((http.Response response) {
      var result;
      if (response.statusCode == 200) {
        var list = json.decode(response.body);
        if (list is List) result = list[0];
        //print(list);
      } else {
        result = null;
      }
      return result;
    });
  }

  ///Tạo mail message và list attachment
  Future<dynamic> insertMailMessageForTicket(
      {MailMessage mailMessage, List<int> listAttachmentId}) async {
    await this.authorization();
    body = new Map();
    body["values"] = json.encode(mailMessage.toJson());
    body["listAttachment_id"] = listAttachmentId.toString();
    return http
        .post('${this.api}/${this.nameCustomApi}/createMail_Message',
            headers: this.headers, body: body)
        .then((http.Response response) {
      var result;
      if (response.statusCode == 200) {
        var list = json.decode(response.body);
        if (list is List) result = list[0];
        //print(list);
      } else {
        result = null;
      }
      return result;
    });
  }

  ///Update thông tin khách hàng
  ///
  ///Success - Trả về true
  ///
  ///Fail - Trả về false
  Future<bool> updateCustomer(ResPartner partner) async {
    await this.authorization();
    body = new Map();
    body["model"] = "res.partner";
    body["ids"] = json.encode([partner.id]);
    body["values"] = json.encode(partner.toJson());
    return http
        .put('${this.api}/write', headers: this.headers, body: body)
        .then((http.Response response) {
      var result = false;
      if (response.statusCode == 200) {
        print(response.body);
        result = true;
        //print(list);
      } else {
        result = false;
      }
      return result;
    });
  }

  ///Hàm update ticket
  ///
  ///Success - Trả về true
  ///
  ///Fail - Trả về false
  Future<dynamic> updateTickets(HelpdeskTicket ticket) async {
    await this.authorization();
    body = new Map();
    body["id"] = ticket.id.toString();
    body["values"] = json.encode(ticket.toJson());
    return http
        .post('${this.api}/${this.nameCustomApi}/updateTicket',
            headers: this.headers, body: body)
        .then((http.Response response) {
      var result;
      if (response.statusCode == 200) {
        var list = json.decode(response.body);
        if (list is List) result = list[0];
        //print(list);
      } else {
        result = null;
      }
      return result;
    });
  }
}
