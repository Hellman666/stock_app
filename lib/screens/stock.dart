import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_sim/models/sqlite_model.dart';
import 'package:stock_sim/screens/portfolio.dart';
import 'package:stock_sim/services/sqlite_db.dart';
import 'package:stock_sim/widgets/about_stock.dart';
import 'package:stock_sim/widgets/buttons/buy_action_button.dart';
import 'package:stock_sim/widgets/buttons/sell_action_button.dart';
import 'package:stock_sim/widgets/buttons/stock_info.dart';
import 'package:stock_sim/widgets/chart.dart';

class Stock extends StatefulWidget {
  final String stockSymbol;
  final String stockName;
  final int? stockId;

  const Stock({
    Key? key,
    required this.stockSymbol,
    required this.stockName,
    this.stockId
  }) : super(key: key);

  @override
  _StockState createState() => _StockState();
}

class _StockState extends State<Stock> {

  //bool isFavourite = false;

  get height => MediaQuery.of(context).size.height;
  get width => MediaQuery.of(context).size.width;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBody: true,
      //extendBodyBehindAppBar: true,
      appBar: //MyAppBar();
      PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50.0),
                  bottomRight: Radius.circular(0.0))
          ),
          actions: <Widget>[
            IconButton(

                icon: Icon(/*isFavourite ? Icons.star : */Icons.star_border_outlined, color: Colors.white, size: 34.0),
                onPressed: () {
                  /*setState(() {
                    isFavourite ? Icons.star : Icons.star_border_outlined;
                  });*/
                  print('zmáčknuto');
                  /*if(isFavourite == false){*/
                  DatabaseHelper.insertFavourite(widget.stockSymbol, widget.stockName,);
                  //isFavourite = true;
                  addToFavourite(widget.stockSymbol, widget.stockName);
                  icon: const Icon(
                    Icons.star,
                    color: Colors.white,
                    size: 34.0,
                  );
                  print(widget.stockId);
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Favourite'),
                        content: const Text('You add this stock to favourite'),
                        actions: [
                          TextButton(
                            onPressed: (){
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Portfolio(),
                                ),
                                    (Route<dynamic> route) => false,
                              );
                            },
                            child: const Text('OK'),
                          )
                        ],
                      )
                    );
                  }
                  /*else{
                    isFavourite = false;
                    removeFromFavourite();
                    icon: const Icon(
                      Icons.star_border_outlined,
                      color: Colors.white,
                      size: 34.0,
                    );
                    DatabaseHelper.removeFavourite(widget.stockId);
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Not favourite'),
                          content: const Text('You remove this stock to favourite'),
                          actions: [
                            TextButton(
                              onPressed: (){
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Portfolio(),
                                  ),
                                      (Route<dynamic> route) => false,
                                );
                              },
                              child: const Text('OK'),
                            )
                          ],
                        )
                    );
                  }
                }*/
            )
          ],
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50.0),
                    bottomRight: Radius.circular(0.0)),
                gradient: LinearGradient(
                  colors: [
                    Colors.blue,
                    Colors.lightBlueAccent,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
            ),
          ),
          title: Text(widget.stockSymbol, style: const TextStyle(
            letterSpacing: 2.0,
            fontSize: 32,
          )),
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                width: width*1,
                height: height*0.4,
                child: Chart(title: widget.stockSymbol,),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BuyActionButton(
                      context: context,
                      name: "Buy",
                      color: "#32CD32",
                      icon: Icons.shopping_cart_outlined,
                      Print: "Buy",
                      symbol: widget.stockSymbol,
                      buyName: widget.stockName,
                    ),
                    SellActionButton(
                      context: context,
                      name: "Sell",
                      color: "FF0000",
                      icon: Icons.clear_rounded,
                      Print: "Sell",
                      id: widget.stockId,
                    ),
                  ],
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    StockInfo(title: widget.stockSymbol,)
                  ],
                ),
              ),
              /*Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 8.0, 0.0, 8.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('About Stock', style: Theme.of(context).textTheme.headline4,)
                ),
              ),
              AboutStock(),*/
            ],
          ),
        ),
      ),
    );
  }

addToFavourite(String symbol, String stockName) async {
    print ('add to favourite ' + widget.stockSymbol);
    String FavSymbol = widget.stockSymbol;
    //final symbol = Symbol(widget.stockSymbol);

  }

  void removeFromFavourite() {
    print ("remove from favourite " + widget.stockSymbol);
  }
}


