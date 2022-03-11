import 'package:flutter/material.dart';
import 'package:payment_project/models/model.dart';
import 'package:payment_project/services/log_service.dart';
import 'package:payment_project/services/services.dart';

import 'card_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String id = "home_page";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController number = TextEditingController();
  TextEditingController data = TextEditingController();
  TextEditingController cvv = TextEditingController();

  void addCard() async {
    CardModel card = CardModel(
      cardNumber: number.text.toString(),
      data: data.text.toString(),
      cvv: cvv.text.toString(),
    );

    await Network.POST(Network.API_CREATE, Network.paramsCreate(card)).then((value) {
      Log.e(value.toString());
    });

    Navigator.pushReplacementNamed(context, CardListPage.id);
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
              Text(
                "Add your card",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 25),
              Text(
                "Fill in the fields below or use camera phone",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(height: 25),
              Text(
                "Your card number",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(height: 15),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6)),
                height: 55,
                width: double.infinity,
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 10),
                      Icon(Icons.account_balance_wallet_rounded,color: Colors.indigo,),
                      SizedBox(width: 10),
                      Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: TextField(
                          controller: number,
                          decoration: InputDecoration(
                              hintText: "0000     0000     0000     0000",
                              border: InputBorder.none),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Expiry date",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        color: Colors.white,
                        height: 55,
                        width: 150,
                        child: Center(
                          child: TextField(
                            controller: data,
                            decoration: InputDecoration(
                                hintText: "      30            12",
                                border: InputBorder.none),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(width: 70),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "CVV2",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        color: Colors.white,
                        height: 55,
                        width: 150,
                        child: Center(
                          child: TextField(
                            controller: cvv,
                            decoration: InputDecoration(
                                hintText: "              458",
                                border: InputBorder.none),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.3),
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6)),
                height: 55,
                width: double.infinity,
                child: MaterialButton(
                  onPressed: () => addCard(),
                  child: Text("Add Card",style: TextStyle(
                    color: Colors.indigo,fontSize: 20,fontWeight: FontWeight.bold
                  ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
