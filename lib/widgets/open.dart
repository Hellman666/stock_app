import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:stock_sim/screens/stock.dart';
import 'package:stock_sim/screens/stock_sell.dart';


class OpenStockCard extends StatelessWidget {
  final BuildContext context;
  final String name;
  final price;
  final String symbol;
  final int id;

  OpenStockCard({required this.context, required this.name, required this.price, required this.symbol, required this.id});

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
              splashColor: Colors.blue.withAlpha(30),
              onTap: () {
                print(id);
                Navigator.push(context, PageRouteBuilder(
                    transitionDuration: Duration(seconds: 1),
                    transitionsBuilder: (BuildContext context,
                        Animation<double> animation,
                        Animation<double> secAnimation,
                        Widget child) {

                      animation = CurvedAnimation(parent: animation, curve: Curves.decelerate);

                      return ScaleTransition(
                        alignment: Alignment.bottomCenter,
                        scale: animation,
                        child: child,
                      );
                    },
                    pageBuilder: (BuildContext context,
                        Animation<double> animation,
                        Animation<double> secAnimation,)
                    {
                      return StockSell(stockSymbol: symbol, stockName: name, stockId: id);
                    }
                ),
                );
              },
              child: SizedBox(
                width: width*0.9,
                height: _height*0.15,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: width*0.6,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12.0, 10.0, 0.0, 0.0),
                            child: Text(name, maxLines: 1, style: TextStyle(fontSize: 30.0, overflow: TextOverflow.ellipsis),),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12.0, 10.0, 0.0, 0.0),
                          child: Text(symbol, maxLines: 1, style: TextStyle(fontSize: 28.0, color: Colors.black54, overflow: TextOverflow.ellipsis),),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("$price \$", style: TextStyle(fontSize: 32),),
                        ],
                      ),
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
                    color: price > 100 ? HexColor("#00FF00") : Colors.red,
                    //color: Colors.grey.withOpacity(0.7),
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