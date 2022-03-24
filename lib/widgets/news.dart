import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:stock_sim/screens/stock.dart';


class StockCard extends StatelessWidget {
  final BuildContext context;
  final String title;
  final String name;
  final double price;

  StockCard({required this.context, required this.title, required this.name, required this.price});

  get _height => MediaQuery.of(context).size.height;
  get width => MediaQuery.of(context).size.width;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(
        child: Container(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: InkWell(
              splashColor: Colors.lightBlueAccent,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Stock(stockSymbol: 'TSLA')),
                );
                //print('Card tapped.');
              },
              child: SizedBox(
                width: width*0.8,
                height: _height*0.15,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12.0, 10.0, 0.0, 0.0),
                          child: Text(title, style: TextStyle(fontSize: 38.0),),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12.0, 2.0, 0.0, 0.0),
                          child: Text(name, style: TextStyle(fontSize: 28.0, color: Colors.black54),),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Text("\$" + "$price", style: TextStyle(fontSize: 32),),
                    )
                  ],
                ),
              ),
            ),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              boxShadow: [
                BoxShadow(
                    color: price > 150 ? HexColor("#00FF00") : Colors.red,
                    //color: Colors.blue,
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(4, 5)
                ),
              ]
          ),
        ),
      ),
    );
  }
}