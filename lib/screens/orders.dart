import 'package:flutter/material.dart';
import 'package:stock_sim/screens/portfolio.dart';
import 'package:stock_sim/screens/stocks.dart';
import 'package:stock_sim/services/sqlite_db.dart';
import 'package:stock_sim/widgets/close.dart';
import 'package:stock_sim/widgets/open.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Orders extends StatefulWidget {

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  final textController = TextEditingController();
  int _selectedIndex = 1;
  //late User _currentUser;
  //bool _isSigningOut = false;

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
                return Stocks(/*user: _currentUser*/);
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
                return Orders();
              }
          ),
          );
          break;
      }
    });
  }

  late List<GDPData> _chartData;

  @override
  void initState(){
    _chartData = getChartData();

    super.initState();
  }

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
            children: [
              SfCircularChart(
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
              ),

              Text('My porfolio', style: Theme.of(context).textTheme.headline5,),
              const Divider(color: Colors.black, height: 40, indent: 20, endIndent: 20, thickness: 2,),
              const Text('This cards are preparing for you',style: TextStyle(fontSize: 28),),
              //OpenStockCard(context: context, title: 'Microsoft', name: 'MSFT', price: 2487, percent: '124'),
              //OpenStockCard(context: context, title: 'Tesla', name: 'TSLA', price: 487, percent: '12'),
              SizedBox(height: height*0.05,),
              Text('Order history', style: Theme.of(context).textTheme.headline5,),
              const Divider(color: Colors.black, height: 40, indent: 20, endIndent: 20, thickness: 2,),
              /*TextField(
                  controller: textController,
                ),
                FutureBuilder<List<History>>(
                  future: DatabaseHelper.instance.getHistory(),
                  builder: (BuildContext context, AsyncSnapshot<List<History>> snapshot){
                    if(!snapshot.hasData){
                      return const Center(child: Text('Loading...'));
                    }
                    return snapshot.data!.isEmpty
                        ? const Center(child: Text('No stocks in list'))
                        :ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: snapshot.data!.map((history) {
                        return Center(
                          child: ListTile(
                            title: Text(history.title),
                          ),
                        );
                      }).toList(),
                    );
                  }),
                  */
              const Text('This cards are preparing for you',style: TextStyle(fontSize: 28),),
              //---------------------------------------------------------------------------
              /*CloseStockCard(context: context, title: 'APPL', name: 'Apple', price: 124),
              CloseStockCard(context: context, title: 'NTFX', name: 'Netflix', price: 180),
              CloseStockCard(context: context, title: 'FB', name: 'Facebook', price: 24),
              CloseStockCard(context: context, title: 'NVDA', name: 'NVIDIA', price: 75),
              CloseStockCard(context: context, title: 'AMZN', name: 'Amazon', price: 320),*/
            ],
          ),
        ),
      ),
      /*floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.upload_rounded),
        onPressed: () async {
          await DatabaseHelper.instance.add(
            History(title: textController.text),
          );
          setState((){
            textController.clear();
          });
          print(textController.text);
        },
      ),*/
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

  List<GDPData> getChartData() {
    final List<GDPData> chartData = [
      GDPData('TSLA', 2487),
      GDPData('MSFT', 487),
      GDPData('FB', 180),
      GDPData('AMZN', 320),
    ];
    return chartData;
  }
}

class GDPData{
  GDPData(this.continent, this.gdp);
  final String continent;
  final int gdp;
}