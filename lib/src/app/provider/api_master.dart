import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:odoo_api/odoo_api.dart';
import 'package:odoo_api/odoo_api_connector.dart';
import 'package:odoo_api/odoo_user_response.dart';
import 'package:ts24care/src/app/core/app_setting.dart';

// 1.	Hàm lấy danh sách bản tin phân trang.

// 	http://192.168.11.20:8069/api/ts24care/listBlog

// 	def listBlog(self,offset=0,limit=None,gmt=7, **kw)

// 2.	Hàm  lấy danh sách bản tin trên banner.

// 	http://192.168.11.20:8069/api/ts24care/listBlog_Top

// 	def listBlog_Top(self,offset=0, limit=None,gmt=7,order=None, **kw)

// 3.	Hàm  Tìm kiếm bản tin theo key word.

// 	http://192.168.11.20:8069/api/ts24care/listSearchBlog_KeyWord

// 	def listSearchBlog_KeyWord(self,keywork=None,offset=0, limit=None,gmt=7,order=None, **kw)

// 3.1. Hàm lấy chi tiết nội dung bản tin bằng id

// 	http://192.168.11.20:8069/api/ts24care/getContentBlog

// 	def getContentBlog(self,id=0,offset=0, limit=None,gmt=7,order=None, **kw)

// 4.	Hàm  Lấy danh sách ticket theo status.

// 	http://192.168.11.20:8069/api/ts24care/listTicket_Status
// 	def listTicket_Status(self,partner_id='0',stage='0', offset=0, limit=None, gmt=7, order='create_date DESC', **kw)

//  4.1.	Hàm  Lấy chi tiet ticket theo id.

//  http://192.168.11.20:8069/api/ts24care/getTicket

//  def getTicket(self, id=0, offset=0, limit=None, gmt=7, order=None, **kw)

// 5.	Hàm  Tìm kiếm ticket theo keyword.

// 	http://192.168.11.20:8069/api/ts24care/listSearchTicket_Keyword

// 	def listSearchTicket_Keyword(self, keyword=None,partner_id='0', stage=0, offset=0, limit=None, gmt=7, order=None, **kw)

// 6.	Hàm  Tạo ticket.

// 	http://192.168.11.20:8069/api/ts24care/createTicket

// 	def createTicket(self, values=None, context=None, **kw)

// 					{ 'message_main_attachment_id':1, 'subject': 'ticketsubject', 'description': 'ticket description', 'partner_id': 3, 'contact_name': 'ticket contact_name', 'email': 'ticketemail', 'user_id': 2, 'team_id': 2, 'date_deadline': '2020-03-11 17:38:21', 'date_closed': '2020-03-11 17:38:21', 'stage_id': 1, 'color':'', 'active':1, 'category_id':1, 'topic_id':1, 'resolve':0, 'cancel':0 }

// 6.1 Hàm  Tạo Attachment

// 	http://192.168.11.20:8069/api/ts24care/createAttachment

// 	def createAttachment(self, values=None, context=None, **kw)

// 	values : {'id':1,'name':'le lam le 1','res_model': 'helpdesk.ticket',  'res_id': 1,
//                      'datas_fname': 'lam1.jpg',
//                      'name': 'lam1.jpg'}

// 6.2 Hàm tạo upload file attachment

// 	http://192.168.11.20:8069/api/ts24care/uploadAttachmentFile

// 	def uploadAttachmentFile(self, model, id, field=None, context=None, **kw)

//     ufile : chon file

// 7.	Hàm  Cập nhật ticket.

// 	http://192.168.11.20:8069/api/ts24care/updateTicket

// 	def updateTicket(self, id='0', offset=0, limit=None, gmt=7,
// 						 order=None, values={}, **kw)

// 						{

// 						 'name': 'lengoclam',
// 						   'email': 'mail@lam',
// 						 'category_id': '1',
// 						  'subject': 'subject lam'
// 						}

// 8.	Hàm  Lấy danh sách các dịch vụ khách hàng đang sử dụng.

// http://192.168.11.20:8069/api/ts24care/listProduct_Category_Active

// def listProduct_Category_Active(self, partner_id='0', offset=0, limit=None, gmt=7, order=None, **kw)

// 9.	Hàm lấy danh sách FAQ theo category.

// http://192.168.11.20:8069/api/ts24care/listFAQCategory

// def listFAQCategory(self, domain=None, category_id='0', offset=0, limit=None, gmt=7, order=None, **kw)

// 10.	Hàm tìm kiếm FAQ.

// http://192.168.11.20:8069/api/ts24care/listSearchFAQ_Keyword

// def listSearchFAQ_Keyword(self, keyword=None, stage=0, offset=0, limit=None, gmt=7, order=None, **kw)

// 11.	Hàn lấy danh sách category FAQ

// http://192.168.11.20:8069/api/ts24care/listCategoryParentFAQ

// def listCategoryParentFAQ(self, domain=None, offset=0, limit=None, gmt=7, order=None, **kw)

// 12.	Hàm đăng ký dịch vụ cho khách hàng.

// 13. tao mail message va attachment

// http://192.168.11.20:8069/api/ts24care/createMail_Message_Attachment_Rel

// def createMail_Message_Attachment_Rel(self, Mailvalues=None, AttachmentValues=None, context=None, **kw)

// Mailvalues = {
// 'id':1,
// 'subject':'lam test',
// 'date':'2020-03-18 09:39:09',
// 'body':'<p>HR Department created</p>',
// 'parent_id':2,
// 'model':'mail.channel',
// 'res_id':1,
// 'record_name':'sale',
// 'message_type':'email',
// 'subtype_id':1,
// 'mail_activity_type_id':1,
// 'email_from':'',
// 'author_id':2,
// 'no_auto_thread':1,
// 'message_id':2,
// 'reply_to':'abc',

// 'moderation_status':'',
// 'moderator_id':1,
// 'layout':'',
// 'add_sign':1,
// 'create_uid':2,
// 'create_date':'2020-03-18 09:39:09',
// 'write_uid':2,
// 'write_date':'2020-03-18 09:39:09'
// }

// AttachmentValues = {'id':1,'name':'le lam le 1','res_model': 'helpdesk.ticket',  'res_id': 1,
//                      'datas_fname': 'lam1.jpg',
//                      'name': 'lam1.jpg'}

// 14. tao mail_message va list attachment

// http://192.168.11.20:8069/api/ts24care/createMail_Message

//  def createMail_Message(self, values=None, listAttachment_id=None, context=None, **kw)

//  values : { 'id':1, 'subject':'lam test', 'date':'2020-03-18 09:39:09', 'body':'<p>HR Department created</p>', 'parent_id':2, 'model':'mail.channel', 'res_id':1, 'record_name':'sale', 'message_type':'email', 'subtype_id':1, 'mail_activity_type_id':1, 'email_from':'', 'author_id':2, 'no_auto_thread':1, 'message_id':2, 'reply_to':'abc',  'moderation_status':'', 'moderator_id':1, 'layout':'', 'add_sign':1, 'create_uid':2, 'create_date':'2020-03-18 09:39:09', 'write_uid':2, 'write_date':'2020-03-18 09:39:09' }

//  listAttachment_id:[{'id':1},{'id':2},{'id':3}]

enum GrandType { password, client_credentials }

enum StatusCodeGetToken {
  invalid_client,
  timeout,
  invalid_domain,
  TRUE,
  FALSE,
}

//document api https://www.odoo.com/apps/modules/12.0/muk_rest/
class ApiMaster {
  String aliasName = "ApiMaster";
  String api = "$domainApi/api";
  String nameCustomApi = "ts24care";
  String clientId = client_id;
  String clienSecret = client_secret;
  String username;
  String password;
  String sessionId;
  GrandType grandType = GrandType.client_credentials;
  GrandType grandTypeTemp = GrandType.client_credentials;
  Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
  };
  Map<String, dynamic> body;
  String _accessToken = "";
  get accessToken => _accessToken;
  dynamic expiresIn;

  ApiMaster();

  ApiMaster.fromJson(Map<String, dynamic> json) {
    api = json['api'];
    clientId = json['clientId'];
    clienSecret = json['clienSecret'];
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['api'] = this.api;
    data['clientId'] = this.clientId;
    data['clienSecret'] = this.clienSecret;
    data['username'] = this.username;
    data['password'] = this.password;
    return data;
  }

  String convertSerialize(Map<String, dynamic> obj) {
    var str = "";
    obj.forEach((key, value) {
      if (str != "") {
        str += "&";
      }
      if (value is List) {
        value.asMap().forEach((index, element) {
          if (element is String)
            element = "'$element'";
          else if (element is List) {
            element.asMap().forEach((indexChild, elementChild) {
              if (elementChild is String)
                elementChild = "'$elementChild'";
              else if (elementChild is bool) {
                switch (elementChild) {
                  case false:
                    elementChild = 'False';
                    break;
                  case true:
                    elementChild = 'True';
                    break;
                  default:
                }
              }
              element[indexChild] = elementChild;
            });
          }
          value[index] = element;
        });
      }
      str += key + "=" + Uri.encodeComponent(value.toString());
    });
    return str;
  }

  Future<StatusCodeGetToken> getToken() async {
    body = new Map();
    switch (grandType) {
      case GrandType.password:
        body["grant_type"] = "password";
        body["username"] = username;
        body["password"] = password;
        break;
      case GrandType.client_credentials:
        body["grant_type"] = "client_credentials";
        break;
      default:
    }
    body["scope"] = "all";
    body["client_id"] = clientId;
    body["client_secret"] = clienSecret;
    print('$api/authentication/oauth2/token');
    return http
        .post('$api/authentication/oauth2/token', body: body)
        .then((http.Response response) {
      switch (response.statusCode) {
        case 200:
          print(response.body);
          var result = jsonDecode(response.body);
          _accessToken = result["access_token"];
          if (grandType == GrandType.client_credentials)
            expiresIn =
                DateTime.now().add(Duration(seconds: result["expires_in"]));
          headers[HttpHeaders.authorizationHeader] = "Bearer $_accessToken";
          print('headers: $headers');
          return StatusCodeGetToken.TRUE;
          break;
        case 401:
          return StatusCodeGetToken.invalid_client;
          break;
        default:
          return StatusCodeGetToken.FALSE;
      }
    }).catchError((error) {
      print(error);
      return StatusCodeGetToken.invalid_domain;
    }).timeout(Duration(seconds: 10), onTimeout: () {
      return StatusCodeGetToken.invalid_domain;
    });
  }

  Future<StatusCodeGetToken> authorization({refresh: false}) async {
    StatusCodeGetToken result = StatusCodeGetToken.TRUE;
    if (refresh) {
      result = await getToken();
    } else {
      //kiểm tra nếu grandType thay đổi
      if (grandType == grandTypeTemp) {
        //kiểm tra nếu token tồn tại
        if (expiresIn != null) {
          DateTime currentTime = DateTime.now();
          var diffTime = expiresIn.difference(currentTime).inSeconds;
          print(diffTime);
          //lấy lại token.
          if (diffTime <= 0) result = await getToken();
        } else
          result = await getToken();
      } else {
        grandTypeTemp = grandType;
        result = await getToken();
      }
    }
    return result;
  }

  /// Lấy thông tin user session.
  ///
  ///  Trả về {
  ///  "uid": 3,
  ///   "name": "Max"
  ///   "partnerId": 2
  /// }
  Future<dynamic> getUser() async {
    Future<dynamic> _getPartnerId(dynamic uid) {
      body = new Map();
      body["fields"] = ['id'];
      body["domain"] = [
        ['user_ids', '=', uid]
      ];
      var params = convertSerialize(body);
      return http
          .get('${this.api}/search_read/res.partner?$params',
              headers: this.headers)
          .then((http.Response response) {
        if (response.statusCode == 200) {
          var list = json.decode(response.body);
          if (list is List) if (list.length > 0) return list[0]["id"];
          return null;
        } else
          return 0;
      }).catchError((error) {
        return 0;
      });
    }

    await this.authorization();
    return http
        .get('${this.api}/user', headers: this.headers)
        .then((http.Response response) async {
      if (response.statusCode == 200) {
        var userInfo = json.decode(response.body);
        var partnerID = await _getPartnerId(userInfo["uid"]);
        userInfo["partnerID"] = partnerID;
        this.grandType = GrandType.client_credentials;
        this.clientId = client_id;
        this.clienSecret = client_secret;
        return userInfo;
      } else
        return null;
    }).catchError((error) {
      return null;
    });
  }

  /// Lấy thông tin user info.
  ///
  ///  Trả về {
  ///   "address": {
  ///     "country": "United States",
  ///     "formatted": "YourCompany\\n215 Vine St\\n\\nScranton PA 18503\\nUnited States",
  ///     "postal_code": "18503",
  ///     "region": "Pennsylvania",
  ///     "street_address": "215 Vine St"
  ///   },
  ///   "email": "admin@yourcompany.example.com",
  ///   "locale": "en_US",
  ///   "name": "Mitchell Admin",
  ///   "phone_number": "+1 555-555-5555",
  ///   "picture": "data:image/jpg;base64,/9j/4AA...",
  ///   "sub": 3,
  ///   "updated_at": "2018-12-13",
  ///   "username": "admin",
  ///   "website": "https://www.mukit.at",
  ///   "zoneinfo": "Europe/Brussels"
  /// }
  Future<dynamic> getUserInfo() async {
    await this.authorization();
    return http
        .get('${this.api}/userinfo', headers: this.headers)
        .then((http.Response response) {
      if (response.statusCode == 200) {
        var userInfo = json.decode(response.body);
        this.grandType = GrandType.client_credentials;
        this.clientId = client_id;
        this.clienSecret = client_secret;
        return userInfo;
      } else
        return null;
    }).catchError((error) {
      return null;
    });
  }

  Future getOdoo() async {
    var client = new OdooClient(domainApi);
    // Synchronize way
    final version = await client.connect();
    print(version);
    client.getDatabases().then((List databases) {
      // deal with database list
      client.authenticate("bus2school", "B@S#2019", databases[0])
          //.authenticate("luanvm@ts24.vn", "123456", databases[0])
          .then((AuthenticateCallback auth) {
        if (auth.isSuccess) {
          final user = auth.getUser();
          print("Hello ${user.name}");

          final domain = [
            '|',
            ['id', '=', 48],
            ['parent_id', '=', 48]
          ];
          final fields = ["id", "name", "email"];
          client
              .searchRead("res.partner", domain, [],
                  limit: 10, offset: 0, order: "date")
              .then((OdooResponse result) {
            if (!result.hasError()) {
              final data = result.getResult();
              final records = data['records'];
              print(records);
            } else {
              print(result.getError().toString());
            }
          });
        } else {
          // login fail
        }
      });
    });
  }

  Future<OdooClient> authorizationOdoo() async {
    var client = new OdooClient(domainApi);
    // Synchronize way
    final version = await client.connect();
    print(version);
    return client.getDatabases().then((List databases) {
      // deal with database list
      return client
          .authenticate(admin_id, admin_password, databases[0])
          .then((AuthenticateCallback auth) {
        print(auth.getSessionId());
        return client;
      });
    });
  }

  Future<void> demoOdoo() async {
    var client = await this.authorizationOdoo();
    body = new Map();
    body["vehicle_id"] = 3;
    body["driver_id"] = 15;
    body["date"] = "2019-11-06";

    client.callController("/handle_picking_info_request", body).then((onValue) {
      var result = onValue.getResult();
      print(result);
    });
  }

  //Get session ID
  void updateCookie(http.Response response) {
    String rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      sessionId = (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
  }

  //Lấy avatar khách hàng
  getImageByIdPartner(String id) {
    return "$domainApi/web/image?model=res.partner&field=image&id=$id&$sessionId";
  }

  //Lấy avatar nhân viên
  getImageByIdUser(String id) {
    return "$domainApi/web/image?model=res.user&field=image&id=$id&$sessionId";
  }
}
