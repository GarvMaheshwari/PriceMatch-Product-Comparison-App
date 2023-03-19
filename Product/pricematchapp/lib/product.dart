class Product {
  late String brand;
  late String link;
  late String rawPrice;
  late String priceContainer;
  late String searchResult;

  static List<Product> currentProductList = [];

  Product(this.brand, this.link, this.rawPrice);

  Product.priceRaw(String rawPrice) {
    rawPrice = rawPrice;
  }
  String getBrand() {
    return brand;
  }

  String getLink() {
    return link;
  }

  String getPrice() {
    return rawPrice;
  }

  // factory Product.fromAmazonJson(Map<String, dynamic> json) {
  //   return Product.container1("Amazon", json['search_results']);
  // }

  // factory Product.retrieveActualPrice(Map<String, dynamic> json) {
  //   return Product.priceRaw(json['price']);
  // }

//
  static getAmazonProductsList(Map<String, dynamic> json) {
    Product temp;
    //Forlopp which traverses through the
    List searchResult = json['search_results'];
    currentProductList.clear();
    for (int i = 0; i < searchResult.length; i++) {
      temp = Product("Amazon", getLinkFromMap(searchResult[i]),
          getPriceFromMap(searchResult[i]));
      currentProductList.add(temp);
    }
    printProductList();
  }

  static String getPriceFromMap(Map<String, dynamic> json) {
    if (json.containsKey("price")) {
      Map<String, dynamic> temp = json["price"];
      return temp["raw"];
    }
    return "null";
  }

  static String getLinkFromMap(Map<String, dynamic> json) {
    return json["link"];
  }

  static printProductList() {
    for (int i = 0; i < currentProductList.length; i++) {
      print(
          "Link: ${currentProductList[i].getLink()} Price: ${currentProductList[i].getPrice()}");
    }
    print(currentProductList.length);
  }
}
