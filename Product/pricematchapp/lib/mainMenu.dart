import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'constants.dart' as constants;
import 'package:http/http.dart' as http;

class MainMenu extends StatelessWidget {
  MainMenu({super.key});

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
      body: Container(
        child: FloatingActionButton(
          onPressed: () {
            appendSearch(parseInput("birthday hat"));
          },
        ),
      ),
    );
  }

  List<String> parseInput(String input) {
    return input.split(" ");
  }

  //type=search&amazon_domain=amazon.com
  //&search_term=memory+cards&sort_by=price_high_to_low

  String appendSearch(List<String> searchInput) {
    String appendedURL = constants.UserStack.productAPI;
    for (int i = 0; i < searchInput.length; i++) {
      appendedURL = "$appendedURL&${searchInput[i]}";
    }
    print(appendedURL);
    return appendedURL;
  }

  Future fetchFromAmazon(url) async {
    final dynamic searchResults = http.get(url);
  }
}
