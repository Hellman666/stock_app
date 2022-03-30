import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stock_sim/models/sqlite_model.dart';
import 'package:stock_sim/screens/portfolio.dart';
import 'package:stock_sim/screens/stock.dart';
import 'package:stock_sim/services/alphavantage_repo.dart';
import 'package:stock_sim/services/sqlite_db.dart';


class SellActionButton extends StatefulWidget {
  final BuildContext context;
  final String name;
  final String color;
  final icon;
  final String Print;

  SellActionButton({required this.context, required this.name, required this.color, this.icon, required this.Print});

  @override
  State<SellActionButton> createState() => _SellActionButtonState();
}

class _SellActionButtonState extends State<SellActionButton> {
  get height => MediaQuery.of(widget.context).size.height;
  get width => MediaQuery.of(widget.context).size.width;

  @override
  void initState() {
    DatabaseHelper.getBalance().then((value) {
      User _userRow = User.fromMap(value[0]);
      setState(() {
        _balance = _userRow.balance;
      });
    });
    super.initState();
  }

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
              //TODO: udělat podmínku pro pordej
              /*if(symbol = order.symbol/*(symbol v databázi)*/){
                actualPrice - buyPrice = profit;
                _balance = _balance + profit + buyprice
                //TODO: odstanění prodané akcie z databáze
              } else {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('You cannot sell the stock'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: const <Widget>[
                          Text('You can\'t sell a stock because you haven\' bought it'),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              }*/

              double stockPrice = double.parse(APIManager.price);
              int actualPrice = stockPrice.round();

              print('$actualPrice - předchozí cena = profit');
              print('profit + předchozí cena + balance');

              DatabaseHelper.getTrades();
            },
            label: Text(widget.name),
            //child: Text(name),
          ),
        )
    );
  }
}