import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:stock_sim/screens/portfolio.dart';
import 'package:stock_sim/screens/stock.dart';
import 'package:stock_sim/services/sqlite_db.dart';


class StockCardPf extends StatelessWidget {
  final BuildContext context;
  final String title;
  final String name;
  final GestureTapCallback onClick;
  final int? id;

  StockCardPf({required this.context, required this.title, required this.name, required this.onClick, this.id});

  get _height => MediaQuery.of(context).size.height;
  get width => MediaQuery.of(context).size.width;

  @override

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(
        child: Container(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: InkWell(
              splashColor: Colors.lightBlueAccent,
              onTap: onClick,
              child: SizedBox(
                width: width*0.8,
                height: _height*0.15,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12.0, 10.0, 0.0, 0.0),
                          child: Text(title, maxLines: 1, style: const TextStyle(fontSize: 38.0),),
                        ),
                        SizedBox(
                          width: width*0.6,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12.0, 2.0, 0.0, 0.0),
                            child: Text(name, maxLines: 1, style: const TextStyle(fontSize: 28.0, color: Colors.black54, overflow: TextOverflow.ellipsis),),
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                        //onPressed: () => DatabaseHelper.removeFavourite(id),
                      onPressed: () {
                        DatabaseHelper.removeFavourite(id);
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Remove'),
                              content: const Text('You remove this stock from favourite'),
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
                      },
                      icon: Icon(Icons.restore_from_trash_sharp, color: Colors.red,),
                    ),
                  ],
                ),
              ),
            ),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              boxShadow: const [
                BoxShadow(
                    color: Colors.blue,
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: Offset(4, 5)
                ),
              ]
          ),
        ),
      ),
    );
  }
}