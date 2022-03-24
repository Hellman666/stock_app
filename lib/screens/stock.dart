import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_sim/widgets/about_stock.dart';
import 'package:stock_sim/widgets/buttons/action_button.dart';
import 'package:stock_sim/widgets/buttons/stock_info.dart';
import 'package:stock_sim/widgets/chart.dart';

class Stock extends StatefulWidget {
  final String stockSymbol;

  Stock({
    required this.stockSymbol
  });

  @override
  _StockState createState() => _StockState();
}

late final int price;

class _StockState extends State<Stock> {

  bool isFavourite = false;

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
                icon: const Icon(
                  Icons.star_border_outlined,
                  color: Colors.white,
                  size: 34.0,
                ),
                onPressed: () {
                  print('zmáčknuto');
                  if(isFavourite == false){
                    isFavourite = true;
                    addToFavourite();
                  }
                  else{
                    isFavourite = false;
                    removeFromFavourite();
                  }
                }
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
                    ActionButton(
                      context: context,
                      name: "Buy",
                      color: "#32CD32",
                      icon: Icons.shopping_cart_outlined,
                      Print: "Buy",
                    ),
                    ActionButton(
                      context: context,
                      name: "Sell",
                      color: "FF0000",
                      icon: Icons.clear_rounded,
                      Print: "Sell",
                    ),
                  ],
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    StockInfo()
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 8.0, 0.0, 8.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('About Stock', style: Theme.of(context).textTheme.headline4,)
                ),
              ),
              AboutStock(),
            ],
          ),
        ),
      ),
    );
  }

  void addToFavourite() {
    print ('add to favourite' + widget.stockSymbol);
  }

  void removeFromFavourite() {
    print ("remove from favourite" + widget.stockSymbol);
  }
}


