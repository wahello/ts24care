class ProductCategory {
  dynamic sLastUpdate;
  List<dynamic> childId;
  dynamic completeName;
  dynamic createDate;
  List<dynamic> createUid;
  dynamic displayName;
  dynamic id;
  dynamic name;
  dynamic parentId;
  dynamic parentPath;
  dynamic productCount;
  List<dynamic> propertyAccountExpenseCategId;
  List<dynamic> propertyAccountIncomeCategId;
  dynamic propertyCostMethod;
  dynamic propertyStockAccountInputCategId;
  dynamic propertyStockAccountOutputCategId;
  List<dynamic> propertyStockJournal;
  dynamic propertyStockValuationAccountId;
  dynamic propertyValuation;
  dynamic removalStrategyId;
  List<dynamic> routeIds;
  List<dynamic> totalRouteIds;
  dynamic writeDate;
  List<dynamic> writeUid;

  ProductCategory(
      {this.sLastUpdate,
      this.childId,
      this.completeName,
      this.createDate,
      this.createUid,
      this.displayName,
      this.id,
      this.name,
      this.parentId,
      this.parentPath,
      this.productCount,
      this.propertyAccountExpenseCategId,
      this.propertyAccountIncomeCategId,
      this.propertyCostMethod,
      this.propertyStockAccountInputCategId,
      this.propertyStockAccountOutputCategId,
      this.propertyStockJournal,
      this.propertyStockValuationAccountId,
      this.propertyValuation,
      this.removalStrategyId,
      this.routeIds,
      this.totalRouteIds,
      this.writeDate,
      this.writeUid});

  ProductCategory.fromJson(Map<String, dynamic> json) {
    sLastUpdate = json['__last_update'];
    childId = json['child_id'];
    completeName = json['complete_name'];
    createDate = json['create_date'];
    createUid = json['create_uid'];
    displayName = json['display_name'];
    id = json['id'];
    name = json['name'];
    parentId = json['parent_id'];
    parentPath = json['parent_path'];
    productCount = json['product_count'];
    propertyAccountExpenseCategId = json['property_account_expense_categ_id'];
    propertyAccountIncomeCategId = json['property_account_income_categ_id'];
    propertyCostMethod = json['property_cost_method'];
    propertyStockAccountInputCategId =
        json['property_stock_account_input_categ_id'];
    propertyStockAccountOutputCategId =
        json['property_stock_account_output_categ_id'];
    propertyStockJournal = json['property_stock_journal'];
    propertyStockValuationAccountId =
        json['property_stock_valuation_account_id'];
    propertyValuation = json['property_valuation'];
    removalStrategyId = json['removal_strategy_id'];
    routeIds = json['route_ids'];
    totalRouteIds = json['total_route_ids'];
    writeDate = json['write_date'];
    writeUid = json['write_uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sLastUpdate != null) data['__last_update'] = this.sLastUpdate;
    if (this.childId != null) data['child_id'] = this.childId;
    if (this.completeName != null) data['complete_name'] = this.completeName;
    if (this.createDate != null) data['create_date'] = this.createDate;
    if (this.createUid != null) data['create_uid'] = this.createUid;
    if (this.displayName != null) data['display_name'] = this.displayName;
    if (this.id != null) data['id'] = this.id;
    if (this.name != null) data['name'] = this.name;
    if (this.parentId != null) data['parent_id'] = this.parentId;
    if (this.parentPath != null) data['parent_path'] = this.parentPath;
    if (this.productCount != null) data['product_count'] = this.productCount;
    if (this.propertyAccountExpenseCategId != null)
      data['property_account_expense_categ_id'] =
          this.propertyAccountExpenseCategId;
    if (this.propertyAccountIncomeCategId != null)
      data['property_account_income_categ_id'] =
          this.propertyAccountIncomeCategId;
    if (this.propertyCostMethod != null)
      data['property_cost_method'] = this.propertyCostMethod;
    if (this.propertyStockAccountInputCategId != null)
      data['property_stock_account_input_categ_id'] =
          this.propertyStockAccountInputCategId;
    if (this.propertyStockAccountOutputCategId != null)
      data['property_stock_account_output_categ_id'] =
          this.propertyStockAccountOutputCategId;
    if (this.propertyStockJournal != null)
      data['property_stock_journal'] = this.propertyStockJournal;
    if (this.propertyStockValuationAccountId != null)
      data['property_stock_valuation_account_id'] =
          this.propertyStockValuationAccountId;
    if (this.propertyValuation != null)
      data['property_valuation'] = this.propertyValuation;
    if (this.removalStrategyId != null)
      data['removal_strategy_id'] = this.removalStrategyId;
    if (this.routeIds != null) data['route_ids'] = this.routeIds;
    if (this.totalRouteIds != null)
      data['total_route_ids'] = this.totalRouteIds;
    if (this.writeDate != null) data['write_date'] = this.writeDate;
    if (this.writeUid != null) data['write_uid'] = this.writeUid;
    return data;
  }
}
