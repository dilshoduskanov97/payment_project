import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:payment_project/models/model.dart';
import 'package:payment_project/services/services.dart';

import 'home_page.dart';

class CardListPage extends StatefulWidget {
  const CardListPage({Key? key}) : super(key: key);
  static const String id = "card_list_page";

  @override
  State<CardListPage> createState() => _CardListPageState();
}

class _CardListPageState extends State<CardListPage> {
  Stream<List<CardModel>> getData() {
    return Stream.periodic(const Duration(seconds: 1))
        .asyncMap((event) => getNetworkData());
  }

  Future<List<CardModel>> getNetworkData() async {
    String? string = await Network.GET(Network.API_LIST, Network.paramsEmpty());
    List<CardModel> cards = List.from(jsonDecode(string!))
        .map((e) => CardModel.fromJson(e))
        .toList();
    return cards;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 25),
              Row(
                children: [
                  Text(
                    "Good Morning,\nDilshod",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white),
                  ),
                  SizedBox(width: 90),
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image(
                      image: AssetImage(
                        "assets/images/im_user.png",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              StreamBuilder(
                  stream: getData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<CardModel> cards = snapshot.data as List<CardModel>;
                      List<Widget> list = [];
                      int index = 0;
                      for (var card in cards) {
                        index++;
                        list.addAll([
                          itemBuildCard(
                            context,
                            card,
                          ),
                          const SizedBox(height: 20),
                        ]);
                      }
                      return Column(children: list);
                    } else {
                      return SizedBox.shrink();
                    }
                  }),
              SizedBox(height: 100),
              Container(
                color: Colors.indigo,
                height: 250,
                child: Center(
                  child: Column(
                    children: [
                      MaterialButton(
                        child: Column(
                          children: [
                            Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 50,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Add new card",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                        color: Colors.indigo,
                        minWidth: MediaQuery.of(context).size.width,
                        height: 250,
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed(HomePage.id);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container itemBuildCard(BuildContext context, CardModel card) {
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.blueGrey,
      height: 250,
      width: MediaQuery.of(context).size.width * 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.apps_outlined,
                size: 60,
                color: Colors.lightBlueAccent,
              ),
              Text(
                "VISA",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              )
            ],
          ),
          SizedBox(height: 25),
          Text(
            card.cardNumber ?? "",
            style: TextStyle(
                color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 40),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "CARD HOLDER",
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                  SizedBox(height: 7),
                  Text(
                    card.name ?? "",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ],
              ),
              SizedBox(width: 150),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "EXPIRES",
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                  SizedBox(height: 7),
                  Text(
                    card.data ?? "",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
