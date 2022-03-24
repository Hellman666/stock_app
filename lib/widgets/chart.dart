import 'package:flutter/material.dart';
import 'package:stock_sim/models/api_model.dart';
import 'package:stock_sim/services/alphavantage_repo.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';



class Chart extends StatefulWidget {
  Chart({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  late TrackballBehavior _trackballBehavior;
  List<TimeSeriesDaily> timeModelList = [];



  late Future<List> _timeSeriesDaily;
  late double minimum;
  late double maximum;

  @override
  void initState() {
    //_chartData = getChartData();
    minimum = 999999;
    maximum = 0;
    _trackballBehavior = TrackballBehavior(
        enable: true, activationMode: ActivationMode.singleTap);
    _timeSeriesDaily = APIManager().getTime(widget.title);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: FutureBuilder(
              future: _timeSeriesDaily,
              builder: (context, AsyncSnapshot<List> snapshot) {
                if(snapshot.hasData){
                  List<ChartSampleData> _chartData = getCustomChartData(snapshot.data!);
                  return SfCartesianChart(
                    title: ChartTitle(text: widget.title),
                    trackballBehavior: _trackballBehavior,
                    series: [
                      CandleSeries<ChartSampleData, DateTime>(
                        dataSource: _chartData,
                        xValueMapper: (ChartSampleData sales, _) => sales.x,
                        lowValueMapper: (ChartSampleData sales, _) => sales.low,
                        highValueMapper: (ChartSampleData sales, _) => sales.high,
                        openValueMapper: (ChartSampleData sales, _) => sales.open,
                        closeValueMapper: (ChartSampleData sales, _) => sales.close,
                        enableSolidCandles: true,

                      ),
                    ],
                    primaryXAxis: DateTimeAxis(
                        dateFormat: DateFormat.MMM(),
                        majorGridLines: MajorGridLines(width: 0)),
                    primaryYAxis: NumericAxis(
                        minimum: minimum - 0.2,
                        maximum: maximum + 0.2,
                        interval: 0.1,
                        numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0)),
                  );
                }
                else{
                  return Center(child: CircularProgressIndicator());
                }

              },
            )
            ));
  }
  List<ChartSampleData> getCustomChartData(List data){
    List<ChartSampleData> resultList = [];
    for(var i = 0; i < data.length / 3; i++){
      if(double.parse(data[i].value["3. low"]) < minimum) minimum = double.parse(data[i].value["3. low"]);
      if(double.parse(data[i].value["2. high"]) > maximum) maximum = double.parse(data[i].value["2. high"]);

      resultList.add(
        ChartSampleData(
            x: DateTime.parse(data[i].key.toString()),
            open: double.parse(data[i].value["1. open"]),
            high: double.parse(data[i].value["2. high"]),
            low: double.parse(data[i].value["3. low"]),
            close: double.parse(data[i].value["4. close"])
        ),
      );
    }
    /*data.forEach((e){


    e.value.forEach((k,v){
      print('KEY: $k');
      print('VALUE: $v');
      resultList.add(
        ChartSampleData(
            x: DateTime.parse(e.toString()),
            open: 98.97,
            high: 101.19,
            low: 95.36,
            close: 97.13
        ),
      );
    });

  });*/

    return resultList;
  }
}

class ChartSampleData {
  ChartSampleData({
    this.x,
    this.open,
    this.close,
    this.low,
    this.high,
  });

  final DateTime? x;
  final num? open;
  final num? close;
  final num? low;
  final num? high;
}

class ModelTime {
  final DateTime? time;
  final num? open;
  final num? high;
  final num? low;
  final num? close;
  final num? volume;

  ModelTime(this.time, this.open, this.high, this.low, this.close, this.volume);
}