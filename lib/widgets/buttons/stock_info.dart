import 'package:flutter/material.dart';

double price = 128;
int percent = 12;

class StockInfo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {



    final _height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: width*0.4,
            height: _height*0.1,
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
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 0.0),
                    child: new Align(alignment: Alignment.topLeft,child: Text('Price', style: TextStyle(fontSize: 22, color: Colors.grey),)),
                  ),
                  Text("\$ " + "$price", style: TextStyle(fontSize: 32),),
                ],
              ),
            ),
          ),
          SizedBox(
            width: width*0.06,
          ),
          Container(
              width: width*0.4,
              height: _height*0.1,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    //Opacity(opacity: null),
                    BoxShadow(
                        color: Colors.blue,
                        //color: price > 100 ? HexColor("#00FF00") : Colors.red,
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: const Offset(4, 5)
                    )
                  ]
              ),
              child: FittedBox(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 0.0),
                      child: new Align(alignment: Alignment.topLeft,child: Text('Gain/Loss', style: TextStyle(fontSize: 22, color: Colors.grey),)),
                    ),
                    RichText(
                      text: TextSpan(
                          children: [
                            WidgetSpan(
                                child: Icon(Icons.arrow_drop_up, color: Colors.black, size: 34,)
                            ),
                            TextSpan(text: "$percent " + "%", style: TextStyle(color: Colors.black, fontSize: 32)),
                          ]
                      ),
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