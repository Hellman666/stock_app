import 'package:http/http.dart' as http;
import 'package:stock_sim/models/api_model.dart';
import 'dart:convert';

class APIManager {
  String apikey = '8G7779PB6G3VUAGF';

  Future<List> getTime(String symbol) async {
    var client = http.Client();
    var timeSeriesDaily;
    List timeSeriesList = [];

    try{
      var response = await client.get(Uri.parse(
          'https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=$symbol&apikey=$apikey'));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        var timeSeries = jsonMap["Time Series (Daily)"];
        timeSeries.entries.forEach((e){
          timeSeriesList.add(e);
        });
        return timeSeriesList;
      }
    }
    catch(e) {
      print('error $e');
      return timeSeriesDaily;
    }
    return timeSeriesDaily;
  }

  Future<List> getStock(String symbol) async {
    var client = http.Client();

    try {
      var response = await client.get(Uri.parse(
          'https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=$symbol&apikey=$apikey'));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var data = json.decode(jsonString);
        print(data);
      }
    }
    catch(e) {
      print('error $e');
      return [];
    }
    return [];
  }

  Future searchStock(String keyword) async {
    var client = http.Client();

    try {
      var response = await client.get(Uri.parse(
          'https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=$keyword&apikey=$apikey'));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var data = json.decode(jsonString);
        List bestMatches = data["bestMatches"];
        bestMatches.forEach((stock) {
          print (stock["1. symbol"]);
        });
        //print('${data["bestMatches"]}');
        return data["bestMatches"];
      }
    }
    catch (e) {
      print('error $e');
      return "Our system can't search this keyword, please try again.";
    }
    return []; //TODO: ?
  }

  Future aboutStock(String keyword) async{
    var client = http.Client();

    try{
      var response = await client.get(Uri.parse(
          'https://www.alphavantage.co/query?function=OVERVIEW&symbol=$keyword&apikey=$apikey'));
      if(response.statusCode == 200){
        var jsonString = response.body;
        var data = json.decode(jsonString);
        print(data);
      }
    }
    catch (e){
      print('error $e');
      return "Our system can't search this keyword, please try again.";
    }
  }
}
