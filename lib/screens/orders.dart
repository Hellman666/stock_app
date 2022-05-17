import 'package:flutter/material.dart';
import 'package:stock_sim/models/sqlite_model.dart';
import 'package:stock_sim/screens/portfolio.dart';
import 'package:stock_sim/screens/stocks.dart';
import 'package:stock_sim/services/sqlite_db.dart';
import 'package:stock_sim/widgets/close.dart';
import 'package:stock_sim/widgets/open.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);



  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  final textController = TextEditingController();
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print(index);
      switch(index){
        case 0:
          Navigator.pushReplacement(context, PageRouteBuilder(
              transitionDuration: const Duration(seconds: 1),
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
                return Stocks(/*user: _currentUser*/);
              }
          ),
          );
          break;
        case 1:
          Navigator.pushReplacement(context, PageRouteBuilder(
              transitionDuration: const Duration(seconds: 1),
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
                return const Portfolio();
              }
          ),
          );
          break;
        case 2:
          Navigator.pushReplacement(context, PageRouteBuilder(
              transitionDuration: const Duration(seconds: 1),
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
                return const Orders();
              }
          ),
          );
          break;
      }
    });
  }

  //late List<GDPData> _chartData;
  Future<List<Map<String, dynamic>>>? _trades;
  Future<List<Map<String, dynamic>>>? _history;

  @override
  void initState(){
    super.initState();
    _trades = _getTrades();
    _history = _getHistory();

    /*DatabaseHelper.getTrades().then((value) {
      Order _orderRow = Order.fromMap(value[0]);
      setState(() {
        _symbol = _orderRow.symbol;
        _price = _orderRow.buyPrice;
      });
    });

    _chartData = getChartData(_symbol, _price);*/
  }

  //late String _symbol;
  //late int _price;


  Future<List<Map<String, dynamic>>> _getHistory() async{
    List<Map<String, dynamic>> _history = await DatabaseHelper.getHistory();
    return _history;
  }

  Future<List<Map<String, dynamic>>> _getTrades() async{
    List<Map<String, dynamic>> _trades = await DatabaseHelper.getTrades();
    return _trades;
  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    //double width = MediaQuery.of(context).size.width;



    return Scaffold(
      extendBody: false,
      //extendBodyBehindAppBar: true,
      appBar: //MyAppBar();
      PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
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
          title: const Text('ORDERS', style: TextStyle(
            letterSpacing: 2.0,
            fontSize: 32,
          )),
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          //color: HexColor("4A96AD"),
          child: Column(
            children: <Widget>[

                /*SfCircularChart(
                  legend:
                  Legend(isVisible: true, textStyle: TextStyle(fontSize: 22)),
                  series: <CircularSeries>[
                    DoughnutSeries<GDPData, String>(
                      dataSource: _chartData,
                      xValueMapper: (GDPData data, _) => data.continent,
                      yValueMapper: (GDPData data, _) => data.gdp,
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                    ),
                  ],
                ),*/

              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Image.asset('lib/assets/icon/icon.png', height: 200,),
              ),

              Text('My porfolio', style: Theme.of(context).textTheme.headline5,),
              const Divider(color: Colors.black, height: 40, indent: 20, endIndent: 20, thickness: 2,),
              //const Text('No open trades',style: TextStyle(fontSize: 28),),


              //Text(trades[0]['id']),


              FutureBuilder<List<Map<String, dynamic>>>(
                future: _trades,
                builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                  List<Widget> children;
                  if (snapshot.hasData) {
                    children = snapshot.data!.map((order) {
                      return OpenStockCard(context: context, name: order["name"], price: order["buyPrice"], symbol: order['symbol'], id: order['id']);
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
                        padding: EdgeInsets.only(top: 5),
                        child: Text('No open trades', style: TextStyle(fontSize: 32, color: Colors.black),),
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
              SizedBox(height: height*0.05,),
              Text('Order history', style: Theme.of(context).textTheme.headline5,),
              const Divider(color: Colors.black, height: 40, indent: 20, endIndent: 20, thickness: 2,),

              FutureBuilder<List<Map<String, dynamic>>>(
                future: _history,
                builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                  List<Widget> children;
                  if (snapshot.hasData) {
                    children = snapshot.data!.map((orderHistory) {
                      return CloseStockCard(context: context, symbol: orderHistory['symbol'], name: orderHistory['name'], profit: orderHistory['price'],);
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
                        child: Text('Nothing in history', style: TextStyle(fontSize: 22, color: Colors.black),),
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

  /*List<GDPData> getChartData(String symbol, int price) {
    final List<GDPData> chartData = [
      GDPData(symbol, price),
    ];
    return chartData;
  }*/
}

/*class GDPData{
  GDPData(this.continent, this.gdp);
  final String continent;
  final int gdp;
}*/