import 'package:flutter/material.dart';
import 'package:stock_sim/models/sqlite_model.dart';
import 'package:stock_sim/screens/orders.dart';
import 'package:stock_sim/screens/portfolio.dart';
import 'package:stock_sim/services/alphavantage_repo.dart';
import 'package:stock_sim/services/sqlite_db.dart';
import 'package:stock_sim/widgets/buttons/stock_info.dart';
import 'package:stock_sim/widgets/stock_card.dart';
import 'package:http/http.dart' as http;

class Stocks extends StatefulWidget {

  @override
  _StocksState createState() => _StocksState();
}

class _StocksState extends State<Stocks> {


  int _selectedIndex = 1;

  final _searchController = TextEditingController();
  final APIManager _searchManager = APIManager();

  Future<List<Map<String, dynamic>>>? _balance;

  @override
  void initState() {
    DatabaseHelper.getBalance();
    _balance = _getBalance();
    /*DatabaseHelper.getBalance().then((value) {
      User _userRow = User.fromMap(value[0]);
      setState(() {
        _balance = _userRow.balance;
      });
    });*/
    super.initState();
  }

  Future<List<Map<String, dynamic>>> _getBalance() async{
    List<Map<String, dynamic>> _balance = await DatabaseHelper.getBalance();
    return _balance;
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
                return Portfolio();
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

  List<StockCard> _stockCards = [];
  bool _loading = false;

  @override
  Widget build(BuildContext context) {



    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBody: false,
      //extendBodyBehindAppBar: true,
      appBar: //MyAppBar();
      PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
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
          title: const Text('STOCKS', style: TextStyle(
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                  FutureBuilder<List<Map<String, dynamic>>>(
                    future: _balance,
                    builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                      List<Widget> children;
                      if (snapshot.hasData) {
                        children = snapshot.data!.map((balance) {
                          return Center(child: Text('${balance['balance']} \$', style: Theme.of(context).textTheme.headline2,));
                        }).toList();
                      } else if (snapshot.hasError) {
                        children = <Widget>[
                          Text(snapshot.error.toString())
                        ];
                      } else {
                        children = const <Widget>[
                          SizedBox(
                            width: 60,
                            height: 60,
                            child: CircularProgressIndicator(),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: Text('Nothing in watch list', style: TextStyle(fontSize: 22, color: Colors.black),),
                          )
                        ];
                      }
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: children,
                        ),
                      );
                    },
                  ),
                  /*Center(
                      child: Text('$_balance \$', style: Theme.of(context).textTheme.headline2,)
                  ),*/
                ),
                _searchBox(context),
                //Groups(),
                _loading
                    ? CircularProgressIndicator()
                    : Column(
                    children: <Widget>[..._stockCards,]
                )
              ],
            )
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

  Widget _searchBox(BuildContext context){
    return Container(
      width: 300,
      height: 80,
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
            labelText: 'Search',
            suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () async {
                  String _searchedKeyword = _searchController.text;
                  _loading = true;
                  List _searchResults = await _searchManager.searchStock(_searchedKeyword);

                  //TODO: error handling
                  List<StockCard> _tmpStockCards = [];
                  _searchResults.forEach((element) {
                    StockCard _stockCard = _createStockCard(element);
                    _tmpStockCards.add(_stockCard);
                  });
                  setState(() {
                    _stockCards = _tmpStockCards;
                  });
                  _loading = false;
                }
            )
        ),
      ),
    );
  }
  StockCard _createStockCard(Map<String, dynamic> data){
    return StockCard(context: context, title: data["1. symbol"], name: data["2. name"],);
  }
}

/*class Groups extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
          child: TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {},
            child: const Text('Favourite'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {},
            child: const Text('Tops'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
          child: TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {},
            child: const Text('Losers'),
          ),
        ),
      ],
    );
  }
}*/
