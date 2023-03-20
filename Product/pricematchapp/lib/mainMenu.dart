import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'constants.dart' as constants;
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'product.dart';
import 'package:url_launcher/url_launcher.dart';

class MainMenu extends StatefulWidget {
  MainMenu({super.key});

  static Map<String, dynamic> json = {};
  static Map<String, dynamic> json2 = {};
  static bool _isLoadingData = false;

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  TextEditingController searchMenu = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: constants.customTextFormField(
          controller: searchMenu,
          hintText: "Search for Item",
          errorMessage: "",
        ),
        leading: IconButton(
          icon: const Icon(CupertinoIcons.search),
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          onPressed: () {
            String url = appendAmazonSearch(parseInput(searchMenu.text));
            String url2 = appendWalmartSearch(parseInput(searchMenu.text));
            //edit this so it instead takes the search input from the controller
            Product.currentProductList.clear();

            fetchFromAmazonApi(Uri.parse(url));
            fetchFromWalmartApi(Uri.parse(url2));
          },
        ),
        centerTitle: true,
        toolbarHeight: 60,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF185E83),
      ),
      body: MainMenu._isLoadingData
          ? const Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    alignment: Alignment.center,
                    child: ListView.builder(
                        itemCount: Product.currentProductList.length,
                        itemBuilder: (context, i) {
                          final product = Product.currentProductList[i];
                          return Row(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(200, 20, 20, 20),
                                child: Card(
                                  child: Image.network(
                                    product.image,
                                    height: 200,
                                    width: 200,
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                width: 700,
                                height: 200,
                                margin:
                                    const EdgeInsets.fromLTRB(20, 20, 200, 20),
                                alignment: Alignment.centerRight,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromARGB(158, 7, 135, 255),
                                ),
                                child: Column(
                                  children: [
                                    const Align(alignment: Alignment.center),
                                    const SizedBox(height: 30),
                                    Text(
                                      product.brand,
                                      style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 255, 159, 42),
                                          fontSize: 50,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "\$${product.rawPrice}",
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 10),
                                    RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 18, 47, 9),
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                          text: "Visit Retail Website",
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () async {
                                              await launchUrl(
                                                  Uri.parse(product.link));
                                            }),
                                    ),
                                  ],
                                ),
                              )),
                            ],
                          );
                        }),
                  ),
                ),
              ],
            ),
    );
  }

  List<String> parseInput(String input) {
    return input.split(" ");
  }

  //Append Search is a method that contains the API url with the key. This appends
  String appendAmazonSearch(List<String> searchInput) {
    String appendedURL = constants.UserStack.AmazonProductAPI + "&search_term=";
    appendedURL = "$appendedURL${searchInput[0]}";

    if (searchInput.length > 1) {
      for (int i = 1; i < searchInput.length; i++) {
        appendedURL = "$appendedURL+${searchInput[i]}";
      }
    }
    appendedURL = "$appendedURL&sort_by=price_low_to_high";
    print(appendedURL); // remove this
    return appendedURL;
  }

  // https://api.bluecartapi.com/request?api_key=FE30BB06594B41229F17F6C50CA80208&search_term=graphics+card
  // &type=search&sort_by=price_low_to_high&output=json

  String appendWalmartSearch(List<String> searchInput) {
    String appendedURL = constants.UserStack.WalmartProductAPI;
    appendedURL = "$appendedURL${searchInput[0]}";

    if (searchInput.length > 1) {
      for (int i = 1; i < searchInput.length; i++) {
        appendedURL = "$appendedURL+${searchInput[i]}";
      }
    }
    appendedURL =
        "$appendedURL&type=search&sort_by=price_low_to_high&output=json";
    print("$appendedURL"); // remove this
    return appendedURL;
  }

  void fetchFromAmazonApi(Uri url) async {
    setState(() {
      MainMenu._isLoadingData = true;
    });
    var response = await http.get(url);
    String data = response.body;
    MainMenu.json.addAll(jsonDecode(data));
    setState(() {
      Product.getAmazonProductsList(MainMenu.json);
    });
  }

  void fetchFromWalmartApi(Uri url) async {
    setState(() {
      MainMenu._isLoadingData = true;
    });
    var response = await http.get(url);
    String data = response.body;
    MainMenu.json2.addAll(jsonDecode(data));
    setState(() {
      Product.getWalmartProductsList(MainMenu.json2);
      MainMenu._isLoadingData = false;
    });
  }
}
