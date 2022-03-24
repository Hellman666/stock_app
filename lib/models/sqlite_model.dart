class Favourite{
  int id;
  String symbol;
  String name;

  Favourite({required this.id, required this.symbol, required this.name});

  Favourite.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        symbol = res["symbol"],
        name = res["name"];

  Map<String, Object?> toMap(){
    return {'id': id, 'symbol': symbol, 'name': name};
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