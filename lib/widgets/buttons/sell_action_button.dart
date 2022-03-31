import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stock_sim/models/sqlite_model.dart';
import 'package:stock_sim/screens/portfolio.dart';
import 'package:stock_sim/screens/stock.dart';
import 'package:stock_sim/services/alphavantage_repo.dart';
import 'package:stock_sim/services/sqlite_db.dart';

import '../open.dart';


class SellActionButton extends StatefulWidget {
  final BuildContext context;
  final String name;
  final String color;
  final icon;
  final String Print;
  final int? id;

  SellActionButton({required this.context, required this.name, required this.color, this.icon, required this.Print, required this.id});

  @override
  State<SellActionButton> createState() => _SellActionButtonState();
}

class _SellActionButtonState extends State<SellActionButton> {
  get height => MediaQuery.of(widget.context).size.height;
  get width => MediaQuery.of(widget.context).size.width;

  @override
  void initState() {

    DatabaseHelper.getTrades().then((value) {
      Order _orderRow = Order.fromMap(value[0]);
      setState(() {
        _price = _orderRow.buyPrice;
        _historySymbol = _orderRow.symbol;
        _historyName = _orderRow.name;
      });
      print(_price);
    });

    DatabaseHelper.getBalance().then((value) {
      User _userRow = User.fromMap(value[0]);
      setState(() {
        _balance = _userRow.balance;
        _profit = _userRow.profit;
      });
    });
    super.initState();
  }

  late String _historySymbol;
  late String _historyName;
  late int _historyPrice;
  int? _profit;
  int? _price;
  int? _balance;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
          height: height*0.06,
          width: width*0.26,
          child: ElevatedButton.icon(
            icon: Icon(
              widget.icon,
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              elevation: 5,
              primary: HexColor(widget.color),
              onPrimary: Colors.white,
            ),
            onPressed: () {
              showDialog(
                  context: context, 
                  builder: (context) => AlertDialog(
                    title: const Text('You sell a stock'),
                    content: Text('At the moment you sell a stock ${widget.name}'),
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

              double stockPrice = double.parse(APIManager.price);
              int actualPrice = stockPrice.round();

              print(_price);
              int profit = actualPrice - _price!;
              int finishProfit = profit + _profit!;
              print('Profit: $profit');
              int newPrice = _price! + profit + _balance!;
              print('New price: $newPrice');

              DatabaseHelper.updateBalance(User(id: 1, balance: newPrice, profit: finishProfit));
              DatabaseHelper.sellTrades(widget.id);


              DatabaseHelper.insertHistory(_historySymbol, _historyName, finishProfit);

              print('selled');
            },
            label: Text(widget.name),
            //child: Text(name),
          ),
        )
    );
  }
}