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
            name: Icons.search),
        centerTitle: true,
        toolbarHeight: 60,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF185E83),
      ),
      body: Column(
        children: [
          FloatingActionButton(
            onPressed: () {
              String url = appendSearch(parseInput(searchMenu
                  .text)); //edit this so it instead takes the search input from the controller
              fetchFromApi(Uri.parse(url));
            },
          ),
          const SizedBox(height: 100),
          // Padding(
          //   padding: const EdgeInsets.all(20.0),
          //     child: ListView.builder(
          //         shrinkWrap: true,
          //         scrollDirection: Axis.vertical,
          //         itemCount: Product.currentProductList.length,
          //         itemBuilder: (context, i) {
          //           final product = Product.currentProductList[i];
          //           return Text("Link: ${product.link}");
          //         }),
          //   ),
          Expanded(
            child: ListView.builder(
                itemCount: Product.currentProductList.length,
                itemBuilder: (context, i) {
                  final product = Product.currentProductList[i];
                  return Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    child: ListTile(
                        subtitle: RichText(
                      text: TextSpan(
                          text: "Link to Retailer Website",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              await launchUrl(Uri.parse(product.link));
                            }),
                    )),
                  );
                }),
          ),
        ],
      ),
    );
  }

  List<String> parseInput(String input) {
    return input.split(" ");
  }

  //Append Search is a method that contains the API url with the key. This appends
  String appendSearch(List<String> searchInput) {
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

  void fetchFromApi(Uri url) async {
    var response = await http.get(url);
    String data = response.body;
    MainMenu.json.addAll(jsonDecode(data));
    setState(() {
      Product.getAmazonProductsList(MainMenu.json);
    });
  }
}
