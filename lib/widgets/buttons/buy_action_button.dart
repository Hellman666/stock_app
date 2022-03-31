import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stock_sim/models/sqlite_model.dart';
import 'package:stock_sim/screens/portfolio.dart';
import 'package:stock_sim/screens/stock.dart';
import 'package:stock_sim/services/alphavantage_repo.dart';
import 'package:stock_sim/services/sqlite_db.dart';


class BuyActionButton extends StatefulWidget {
  final BuildContext context;
  final String name;
  final String color;
  final icon;
  final String Print;
  final String symbol;
  final String buyName;

 BuyActionButton({required this.context, required this.name, required this.color, this.icon, required this.Print, required this.symbol, required this.buyName});

  @override
  State<BuyActionButton> createState() => _BuyActionButtonState();
}

class _BuyActionButtonState extends State<BuyActionButton> {
  get height => MediaQuery.of(widget.context).size.height;
  get width => MediaQuery.of(widget.context).size.width;

  @override
  void initState() {
    DatabaseHelper.getBalance().then((value) {
      User _userRow = User.fromMap(value[0]);
      setState(() {
        _balance = _userRow.balance;
        _profit = _userRow.profit;
      });
    });

    super.initState();
  }

  int? _profit;
  int? _balance;
  static int? order;

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
              double stockPrice = double.parse(APIManager.price);
              int price = stockPrice.round();
              print(price);
              var calculate = _balance! - stockPrice;
              order = calculate.round();
              print (order);


              if(_balance! - stockPrice < 0){
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('You can\'t buy a stock'),
                      content: Text('You don\'t have enough money for stock ${widget.buyName}'),
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
              } else {
                DatabaseHelper.updateBalance(User(id: 1, balance: order, profit: _profit));
                print(_balance);

                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('You buy a stock'),
                      content: Text('At the moment you buy a stock ${widget.buyName}'),
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

                DatabaseHelper.insertTrades(widget.symbol, price, widget.buyName);
                DatabaseHelper.getTrades();
              }
            },
            label: Text(widget.name),
          ),
        )
    );
  }
}