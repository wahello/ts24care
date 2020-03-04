class ItemApplicationModel{
  final String imageLogo;
  final String name;
  final String description;

  ItemApplicationModel({this.imageLogo, this.name,this.description});
  static List<ItemApplicationModel> listApplication = [
    ItemApplicationModel(
      name: "TAX online",
      imageLogo: "https://web.ts24.com.vn/web/image/megamenu.links/4/image?unique=13d2733",
      description: "Dịch vụ thuế điện tử"
    ),
    ItemApplicationModel(
      name: "Sale24",
      imageLogo: "https://web.ts24.com.vn/web/image/megamenu.links/18/image?unique=01deb10",
      description: "Quản trị bán hàng, mua hàng, hóa đơn điện tử, kế toán"
    ),
    ItemApplicationModel(
      name: "SM 24",
      imageLogo: "https://web.ts24.com.vn/web/image/megamenu.links/11/image?unique=fc37f6c",
      description: "Thông báo, đăng ký khuyến mãi"
    ),
    ItemApplicationModel(
      name: "HR 24",
      imageLogo: "https://web.ts24.com.vn/web/image/megamenu.links/19/image?unique=02ed51d",
      description: "Quản lý hành chính, nhân sự"
    ),
    ItemApplicationModel(
      name: "iXHD",
      imageLogo: "https://web.ts24.com.vn/web/image/megamenu.links/17/image?unique=5f41f84",
      description: "Quản lý xuất hóa đơn điện tử"
    ),
    ItemApplicationModel(
      name: "iKeToan",
      imageLogo: "https://web.ts24.com.vn/web/image/megamenu.links/16/image?unique=0f6f528",
      description: "Quản lý kế toán cho doanh nghiệp"
    ),
  ];
  static List<ItemApplicationModel> listApplicationActive = [
    ItemApplicationModel(
      name: "SM 24",
      imageLogo: "https://web.ts24.com.vn/web/image/megamenu.links/11/image?unique=fc37f6c",
      description: "Thông báo, đăng ký khuyến mãi"
    ),
    ItemApplicationModel(
      name: "HR 24",
      imageLogo: "https://web.ts24.com.vn/web/image/megamenu.links/19/image?unique=02ed51d",
      description: "Quản lý hành chính, nhân sự"
    ),
    ItemApplicationModel(
      name: "iKeToan",
      imageLogo: "https://web.ts24.com.vn/web/image/megamenu.links/16/image?unique=0f6f528",
      description: "Quản lý kế toán cho doanh nghiệp"
    ),
  ];
}