class ProductModel {
  String? sId;
  String? productName;
  String? productCode;
  String? img;
  String? unitPrice;
  String? qty;
  String? totalPrice;
  String? createdDate;

  ProductModel(
      {this.sId,
      this.productName,
      this.productCode,
      this.img,
      this.unitPrice,
      this.qty,
      this.totalPrice,
      this.createdDate});

  ProductModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productName = json['ProductName'];
    productCode = json['ProductCode'];
    img = json['Img'];
    unitPrice = json['UnitPrice'];
    qty = json['Qty'];
    totalPrice = json['TotalPrice'];
    createdDate = json['CreatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['ProductName'] = productName;
    data['ProductCode'] = productCode;
    data['Img'] = img;
    data['UnitPrice'] = unitPrice;
    data['Qty'] = qty;
    data['TotalPrice'] = totalPrice;
    data['CreatedDate'] = createdDate;
    return data;
  }
}
