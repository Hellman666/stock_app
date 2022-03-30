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

 BuyActionButton({required this.context, required this.name, required this.color, this.icon, required this.Print, required this.symbol});

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
      });
    });

    super.initState();
  }

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
              /*if(TimeOfDay.now().hour > 22 && TimeOfDay.now().hour < 15.5) {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Information about market'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: const <Widget>[
                            Text('The market is open from 15:30 until 22:00'),
                            Text('You bought the stock, but at the old price'),
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

              //int _balance = Portfolio()._balance;

              //print(_balance);
              double stockPrice = double.parse(APIManager.price);
              int price = stockPrice.round();
              print(price);
              var calculate = _balance! - stockPrice;
              order = calculate.round();
              print (order);
              DatabaseHelper.insertTrades(widget.symbol, price);
              DatabaseHelper.getTrades();
              //TODO: poslat hodnotu order do databáze Users místo balance
              //TODO: udělat podmínku, pokud není dostatek peněz na účtě, tak si nemůžeme akcii koupit




              /*var percent = APIManager.percent;
              print(percent);
              print(percent.runtimeType);*/

              //print(Order.runtimeType);


              /*DatabaseHelper.insertUserRow();
              DatabaseHelper.getBalance();
              DatabaseHelper.insertHistoryRow();
              DatabaseHelper.getHistory();
              DatabaseHelper.insertFavourite();
              DatabaseHelper.getFavourite();*/

              //print(APIManager.price);
              //print(APIManager.percent);


              //print(APIManager.data["Global Quote"]["10. change percent"]);
              /*print('$Print');
              print(DatabaseHelper.getBalance() + '10');*/
            },
            label: Text(widget.name),
            //child: Text(name),
          ),
        )
    );
  }
}