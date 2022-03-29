

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stock_sim/models/sqlite_model.dart';

import 'package:stock_sim/screens/orders.dart';
import 'package:stock_sim/screens/setting.dart';
import 'package:stock_sim/screens/stock.dart';
import 'package:stock_sim/screens/stocks.dart';
import 'package:stock_sim/services/alphavantage_repo.dart';
import 'package:stock_sim/services/sqlite_db.dart';
import 'package:stock_sim/services/sqlite_db.dart';
import 'package:stock_sim/widgets/stock_card_pf.dart';

class Portfolio extends StatefulWidget {
  const Portfolio({Key? key}) : super(key: key);


  @override

  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return RotationTransition(
        turns: animation,
        child: ScaleTransition(
          scale: animation,
          child: FadeTransition(
            opacity: animation,
            child: Stocks(),
          ),
        ));
  }

  _PortfolioState createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  int _selectedIndex = 1;

  late APIManager _stockManager;
  late DatabaseHelper helper;

  @override
  void initState() {
    print('otevřeno');
    DatabaseHelper.getBalance().then((value) {
      User _userRow = User.fromMap(value[0]);
      setState(() {
        _balance = _userRow.balance;
      });
    });
    DatabaseHelper.getProfit().then((value){
      User _userRow = User.fromMap(value[0]);
      setState(() {
        _profit = _userRow.profit;
      });
    });

    /*DatabaseHelper.getFavourite().then((value) {
      Favourite _favourite = Favourite.fromMap(value[0]);
      setState(() {
        _favouriteSymbol = _favourite.symbol;
        //_favouriteName = _favourite.name;
      });
    });*/
    //_balance = storage.balance.toString();

    //_currentUser = widget.user;


    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      //print(_selectedIndex);
      _selectedIndex = index;
      print(index);
      switch(index){
        case 0:
          Navigator.pushReplacement(context, PageRouteBuilder(
              transitionDuration: Duration(seconds: 1),
              transitionsBuilder: (BuildContext context,
                  Animation<double> animation,
                  Animation<double> secAnimation,
                  Widget child) {

                animation = CurvedAnimation(parent: animation, curve: Curves.decelerate);

                return ScaleTransition(
                  alignment: Alignment.bottomLeft,
                  scale: animation,
                  child: child,
                );
              },
              pageBuilder: (BuildContext context,
                  Animation<double> animation,
                  Animation<double> secAnimation,)
              {
                return Stocks();
              }
            ),
          );
          break;
        case 1:
          Navigator.pushReplacement(context, PageRouteBuilder(
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
                return const Portfolio(/*user: _currentUser*/);
              }
          ),
          );
          break;
        case 2:
          Navigator.pushReplacement(context, PageRouteBuilder(
              transitionDuration: Duration(seconds: 1),
              transitionsBuilder: (BuildContext context,
                  Animation<double> animation,
                  Animation<double> secAnimation,
                  Widget child) {

                animation = CurvedAnimation(parent: animation, curve: Curves.decelerate);

                return ScaleTransition(
                  alignment: Alignment.bottomRight,
                  scale: animation,
                  child: child,
                );
              },
              pageBuilder: (BuildContext context,
                  Animation<double> animation,
                  Animation<double> secAnimation,)
              {
                return Orders();
              }
          ),
          );
          break;
      }
    });
  }



  //int _balance = Map<String, Object?> mapRead = records.;
  int? _balance;
  int? _profit;
  late String _favouriteSymbol;
  //late String _favouriteSymbol;
  final _percent = 0;

  List favourite = [];

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    bool inFavourite = false;
    return Scaffold(
      extendBody: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          actions: [
            IconButton(
                onPressed: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Setting(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.settings,
                  color: Colors.white,
                ))
          ],
          /*actions: [
            IconButton(
              onPressed: () async {
                setState(() {
                  _isSigningOut = true;
                });
                await FirebaseAuth.instance.signOut();
                setState(() {
                  _isSigningOut = false;
                });
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => Welcome(),
                  ),
                );
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
            ),
          ],*/
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50.0),
                  bottomRight: Radius.circular(0.0))
          ),
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
          title: const Text('PORTFOLIO', style: TextStyle(
            letterSpacing: 2.0,
            fontSize: 32,
          )),
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 12.0, 0.0, 0.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Text("Welcome", style: TextStyle(fontSize: 32, letterSpacing: 2, color: Colors.grey)),
                    //Text(/*"${_currentUser.displayName}"*/'Test'.toUpperCase(), style: const TextStyle(fontSize: 32, letterSpacing: 2, color: Colors.black))
                  ],
                ),
              ),
              SizedBox(height: _height*0.02),
              Center(
                child: Container(
                  width: width*0.8,
                  height: _height*0.3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.7),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(7, 8)
                        ),
                      ]
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 1.0),
                            child: Text("Balance", style: TextStyle(fontSize: 22, color: Colors.black),),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 4.0),
                            child: Text(_balance != null ? "\$ $_balance" : "Načítání...", style: TextStyle(fontSize: 38, color: Colors.black, letterSpacing: 2),),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 1.0),
                                    child: Text("Profit", style: TextStyle(fontSize: 20, color: Colors.black),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                                    child: Text( _profit != null ? "\$ $_profit" : "Načítání...", style: TextStyle(fontSize: 28, color: Colors.black, letterSpacing: 2),),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Image.asset('lib/assets/icon/icon.png', height: 70,),
                              ),
                              /*Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.0),
                                    color: Colors.lightBlueAccent,
                                  ),
                                  height: 30,
                                  width: 60,
                                  child: RichText(
                                    text: const TextSpan(
                                        children: [
                                          WidgetSpan(
                                              child:
                                              Icon(Icons.arrow_drop_up, color: Colors.white,)
                                          ),
                                          TextSpan(text: "0%"),
                                        ]
                                    ),
                                  ),
                                ),
                              )*/
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: _height*0.02,),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text("Watch List", style:TextStyle(fontSize: 32, letterSpacing: 2, color: Colors.black)),
              ),
              /*favourite.forEach((stock) {
                getStockPrice(stock.symbol);
                favouriteStocks.add(StockCardPf(context: context, title: stock.symbol, name: stock.name, price: 125))
              })*/
              //TODO: dodělat vypisování favourite
              /*FutureBuilder(
                future: DatabaseHelper.getFavourite(),
                builder: (BuildContext context, AsyncSnapshot<List<Favourite>> snapshot) {
                  if(snapshot.hasData){
                    return const Card(
                      child: ListTile(
                        contentPadding: EdgeInsets.all(8.0),
                        title: Text(snapshot.data.symbol),
                      ),
                    )
                  }
                },
              )*/
              StockCardPf(context: context, title: /*_favouriteSymbol*/'AMZN', name: 'Amazon', price: 125, onClick: () { navigateToStockCardPf(/*_favouriteSymbol*/'AMZN'); }),
              const Center(child: Text('Nothing in watch list', style: TextStyle(fontSize: 22, color: Colors.black),)),

              //StockCardPf(context: context, title: /*_favouriteSymbol*/'AMZN', name: 'Amazon', price: 125, onClick: () { navigateToStockCardPf(/*_favouriteSymbol*/'AMZN'); }),
              //StockCardPf(context: context, title:  "AAPL", name: "Apple", price: 170, onClick: () { navigateToStockCardPf("AAPL"); }),
              //StockCardPf(context: context, title: "AMZN", name: "Amazon", price: 224, onClick: () { navigateToStockCardPf("AMZN"); }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue,
        elevation: 1,
        unselectedItemColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'STOCKS',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_sharp),
            label: 'PORTFOLIO',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.compare_arrows),
            label: 'ORDERS',
            backgroundColor: Colors.white,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
  navigateToStockCardPf(title){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Stock(stockSymbol: title)),
    ).then((value) => setState(() {print('obnoveno');}));
  }
}