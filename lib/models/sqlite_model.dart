class Favourite{
  int? id;
  String symbol;

  Favourite({this.id, required this.symbol});

  Favourite.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        symbol = res["symbol"];

  Map<String, Object?> toMap(){
    return {'id': id, 'symbol': symbol};
  }
}

class History{
  int id;
  String symbol;
  String name;
  int price;

  History({required this.id, required this.symbol, required this.name, required this.price});

  History.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        symbol = res["symbol"],
        name = res["name"],
        price = res["price"];

  Map<String, Object?> toMap(){
    return {'id': id, 'symbol': symbol, 'name': name, 'price': price};
  }
}

class User{
  int id;
  int balance;
  int profit;

  User( this.id,  this.balance, this.profit);

  User.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        balance = res["balance"],
        profit = res["profit"];

  Map<String, Object?> toMap(){
    return {'id': id, 'balance': balance, 'profit': profit};
  }
}

class Order{
  final int? id;
  final int buyPrice;
  final String symbol;

  Order({
    this.id,
    required this.buyPrice,
    required this.symbol
  });

  Order.fromMap(Map<String, dynamic> res)
    : id = res['id'],
      buyPrice = res['buyPrice'],
      symbol = res['symbol'];

  Map<String, Object?> toMap(){
    return {'id': id, 'buyPrice': buyPrice, 'symbol': symbol};
  }
}