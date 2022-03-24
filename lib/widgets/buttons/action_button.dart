import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stock_sim/services/sqlite_db.dart';


class ActionButton extends StatelessWidget {
  final BuildContext context;
  final String name;
  final String color;
  final icon;
  final String Print;

  ActionButton({required this.context, required this.name, required this.color, this.icon, required this.Print});

  get height => MediaQuery.of(context).size.height;
  get width => MediaQuery.of(context).size.width;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
          height: height*0.06,
          width: width*0.26,
          child: ElevatedButton.icon(
            icon: Icon(
              icon,
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              elevation: 5,
              primary: HexColor(color),
              onPrimary: Colors.white,
            ),
            onPressed: () {
              if(TimeOfDay.now().hour > 16 || TimeOfDay.now().hour < 9) {
                AlertDialog(
                    title: Text("Trh je otevřený od 9:30 do 16:00"),
                    actions: <Widget>[
                      TextButton(onPressed: (){
                        Navigator.pop(context);
                      },
                          child: Text('Rozumím')
                      ),
                    ]);
              }
              DatabaseHelper.insertUserRow();
              DatabaseHelper.getBalance();
              DatabaseHelper.insertHistoryRow();
              DatabaseHelper.getHistory();
              DatabaseHelper.insertFavourite();
              DatabaseHelper.getFavourite();
              /*print('$Print');
              print(DatabaseHelper.getBalance() + '10');*/
            },
            label: Text(name),
            //child: Text(name),
          ),
        )
    );
  }
}