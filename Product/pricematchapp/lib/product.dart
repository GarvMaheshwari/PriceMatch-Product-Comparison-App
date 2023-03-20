class Product {
  late String brand;
  late String link;
  late String rawPrice;
  late String image;
  late String searchResult;

  static List<Product> currentProductList = [];

  Product(this.brand, this.link, this.rawPrice, this.image);

  Product.priceRaw(String rawPrice) {
    rawPrice = rawPrice;
  }

  //Apporpiate getters and setters
  String getBrand() {
    return brand;
  }

  String getLink() {
    return link;
  }

  String getPrice() {
    return rawPrice;
  }

  String getImage() {
    return image;
  }

  // factory Product.fromAmazonJson(Map<String, dynamic> json) {
  //   return Product.container1("Amazon", json['search_results']);
  // }

  // factory Product.retrieveActualPrice(Map<String, dynamic> json) {
  //   return Product.priceRaw(json['price']);
  // }

//This method gets
  static getAmazonProductsList(Map<String, dynamic> json) async {
    Product temp;
    //Forloop which traverses through the JSON object search_results
    List searchResult = json['search_results'];
    currentProductList.clear();

    //populates a list with all the products retrieved from the search
    for (int i = 0; i < searchResult.length; i++) {
      temp = Product(
        "Amazon",
        getLinkFromMap(searchResult[i]),
        getPriceFromMap(searchResult[i]),
        getImageFromMap(searchResult[i]),
      );
      // Prevents irrelevant results from being displayed
      if (double.parse(temp.rawPrice) > 4.00) {
        currentProductList.add(temp);
      }
    }
    productsOrderTraversal(currentProductList.length, currentProductList);
  }

  static getWalmartProductsList(Map<String, dynamic> json) async {
    Product temp;
    List searchWalmartResult = json['search_results'];
    for (int i = 0; i < searchWalmartResult.length; i++) {
      //creates a temporary product which is added to the currentProductList.
      temp = Product(
        "Walmart",
        getLinkFromMap(searchWalmartResult[i]['product']),
        getWalmartPriceFromMap(searchWalmartResult[i]['offers']),
        getWalmartImageFromMap(searchWalmartResult[i]['product']),
      );
      // Prevents irrelevant results from being displayed
      if (double.parse(temp.rawPrice) > 4.00) {
        currentProductList.add(temp);
      }
    }
    //calls the bubble sort method to rearrange Products to be in price
    //ascending order
    productsOrderTraversal(currentProductList.length, currentProductList);
    printProductList();
  }

//gets the product listing's price from the json retrieved from the API.
  static String getPriceFromMap(Map<String, dynamic> json) {
    if (json.containsKey("price")) {
      Map<String, dynamic> temp = json["price"];
      String str = temp["raw"];
      return str.replaceAll(RegExp("[A-Za-z\$]"), "");
    }
    return "0.01";
  }

//Gets the link to the product listing
  static String getLinkFromMap(Map<String, dynamic> json) {
    return json["link"];
  }

  static String getImageFromMap(Map<String, dynamic> json) {
    return json["image"];
  }

  static String getWalmartImageFromMap(Map<String, dynamic> json) {
    return json["main_image"];
  }

  static String getWalmartPriceFromMap(Map<String, dynamic> json) {
    Map<String, dynamic> temp = json['primary'];
    if (temp.containsKey("price")) {
      return temp['price'].toString();
    }
    return "0.01";
  }

//Bubble sort recursive method
//This method was inspired by the presentation on recursion and also GeeksForGeeks'
// iterative bubble sort method
  static void productsOrderTraversal(int n, List<Product> list) {
    //base case
    if (n == 1) {
      return;
    }
    int count = 0;
    for (int i = 0; i < n - 1; i++) {
      if (double.parse(list[i].rawPrice) > double.parse(list[i + 1].rawPrice)) {
        //when the product at index position i is greater than the next position's price,
        //the two products swap indices.
        Product temp = list[i];
        list[i] = list[i + 1];
        list[i + 1] = temp;
        count = count + 1;
      }
    }
    if (count == 0) {
      return;
    }
    //recursive call
    productsOrderTraversal(n, list);
  }

//Prints the product list - Primarily used for testing purposes
  static printProductList() {
    for (int i = 0; i < currentProductList.length; i++) {
      print(
          "Link: ${currentProductList[i].getLink()} Price: ${currentProductList[i].getPrice()} Company: ${currentProductList[i].getBrand()}\n");
    }
    print(currentProductList.length);
  }
}
