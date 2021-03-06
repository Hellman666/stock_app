import 'package:flutter/material.dart';
import 'package:stock_sim/services/alphavantage_repo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:stock_sim/widgets/stock_card.dart';

class StockInfo extends StatefulWidget {
  const StockInfo({Key? key, required this.title}) : super(key: key);

  final String  title;

  @override
  State<StockInfo> createState() => _StockInfoState();
}

class _StockInfoState extends State<StockInfo> {
  late Future<List> futureData;


  late double price = double.parse(APIManager.price);
  late String percent = APIManager.percent;

  @override
  void initState(){
    super.initState();

    futureData = APIManager.getStock(widget.title);
    //title = StockCard.title;
    //APIManager.getStock(title);
  }

  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: width * 0.4,
            height: _height * 0.1,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: const [
                  //Opacity(opacity: null),
                  BoxShadow(
                      color: Colors.blue,
                      //color: price > 100 ? HexColor("#00FF00") : Colors.red,
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: Offset(4, 5)
                  )
                ]
            ),
            child: FittedBox(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 0.0),
                    child: Align(alignment: Alignment.topLeft,
                        child: Text('Price',
                          style: TextStyle(fontSize: 22, color: Colors.grey),)
                    ),
                  ),
                  FutureBuilder<List>(
                    future: futureData,
                    builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                      if (snapshot.hasData) {
                          return Text('\$ ${APIManager.price}', style: TextStyle(fontSize: 32));
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return CircularProgressIndicator();
                    },
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: width * 0.06,
          ),
          Container(
              width: width * 0.4,
              height: _height * 0.1,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.blue,
                        //color: price > 100 ? HexColor("#00FF00") : Colors.red,
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: Offset(4, 5)
                    )
                  ]
              ),
              child: FittedBox(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 0.0),
                      child: Align(alignment: Alignment.topLeft,
                          child: Text('Gain/Loss',
                            style: TextStyle(fontSize: 22, color: Colors.grey),)
                      ),
                    ),
                    FutureBuilder<List>(
                      future: futureData,
                      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                        if (snapshot.hasData) {
                          return Text('\$ ${APIManager.percent}', style: TextStyle(fontSize: 32));
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        return CircularProgressIndicator();
                      },
                    ),
                  ],
                ),
              )
          ),
        ],
      ),
    );
  }
}
/*
Future<List> getStock(String symbol) async {

  var client = http.Client();
  try {
    var response = await client.get(Uri.parse(
        'https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=$symbol&apikey=$apikey'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      var data = json.decode(jsonString);
      price = data["Global Quote"]["05. price"];
      print(price);
      percent = data["Global Quote"]["10. change percent"];
      print(percent);
      return data;
      //return data;
    }
  }
  catch(e) {
    print('error $e');
    return [];
  }
  return [];
}*/


