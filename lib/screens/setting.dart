import 'package:flutter/material.dart';
import 'package:stock_sim/screens/portfolio.dart';


class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

int easter = 0;

class _SettingState extends State<Setting> {

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50.0),
                  bottomRight: Radius.circular(0.0))
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
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
          title: Text('SETTING', style: TextStyle(
            letterSpacing: 2.0,
            fontSize: 32,
          )),
          centerTitle: true,
        ),
      ),
      body: Container(
        child: ListView(
          children: [
            Card(
              color: Colors.blue,
              margin: EdgeInsets.all(8.0),
              child: InkWell(
                splashColor: Colors.blue,
                onLongPress: ()
                async {
                  print("yeha boi");
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(
                    width: 350,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "verze: 1.0",
                                style: Theme.of(context).textTheme.headline3,
                              )
                          )
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('About User'.toUpperCase(), style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            ),
            Divider(color: Colors.black, endIndent: 10.0, indent: 10.0, ),
            Card(
              color: Colors.blue,
              margin: EdgeInsets.fromLTRB(24.0, 5.0, 24.0, 5.0),
              child: Container(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Name: Test', style: TextStyle(color: Colors.white, fontSize: 24.0),)),
                  )),
            ),
            Card(
              color: Colors.blue,
              margin: EdgeInsets.fromLTRB(24.0, 5.0, 24.0, 5.0),
              child: Container(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Surname: Test', style: TextStyle(color: Colors.white, fontSize: 24.0),)),
                  )),
            ),
            Card(
              color: Colors.blue,
              margin: EdgeInsets.fromLTRB(24.0, 5.0, 24.0, 5.0),
              child: Container(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('E-mail: Test@test.com', style: TextStyle(color: Colors.white, fontSize: 24.0),)),
                  )),
            ),
            //TODO: načíst hodnoty z mobilu
            //TODO: po zmáčknutí tlačítka vymazat data v telefonu
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                width: width*0.6,
                height: height*0.07,
                // ignore: deprecated_member_use
                child: OutlineButton(
                  highlightedBorderColor: Colors.blueAccent,
                  splashColor: Colors.lightBlue,
                  borderSide: BorderSide(
                    width: 1.8,
                    style: BorderStyle.solid,
                    color: Colors.blue,
                  ),
                  shape: new RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  onPressed: () async {
                    Navigator.of(context)
                        .pushReplacement(
                      MaterialPageRoute(
                        builder: (context) =>
                            Portfolio(),
                      ),
                    );
                  },
                  child: const Text('Restart', style: TextStyle(color: Colors.black, fontSize: 22, letterSpacing: 2,)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
