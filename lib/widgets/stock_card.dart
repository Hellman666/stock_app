import 'package:flutter/material.dart';
import 'package:stock_sim/screens/stock.dart';

class StockCard extends StatelessWidget {
  final BuildContext context;
  final String title;
  final String name;
  //final String price;

  StockCard({required this.context, required this.title, required this.name/*required this.price*/});

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
                  MaterialPageRoute(builder: (context) => Stock(stockSymbol: title, stockName: name,)),
                );
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
                        SizedBox(
                          width: width*0.8,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12.0, 2.0, 0.0, 0.0),
                            child: Text(name, maxLines: 1, style: TextStyle(fontSize: 28.0, color: Colors.black54, overflow: TextOverflow.ellipsis),),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              boxShadow: const [
                BoxShadow(
                    color: Colors.blue,
                    //color: Colors.blue,
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: Offset(4, 5)
                ),
              ]
          ),
        ),
      ),
    );
  }
}