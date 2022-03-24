import 'package:flutter/material.dart';
import 'package:stock_sim/services/alphavantage_repo.dart';

class AboutStock extends StatelessWidget {

  late APIManager _stockInfo;

  @override
  void initState(){
    _stockInfo = APIManager();
    _stockInfo.aboutStock('AAPL');
  }
  Widget build(BuildContext context) {



    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child:
      Container(
        width: width*0.8,
        padding: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.grey, width: 3.0),
        ),
        child: const Text(
          'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur vitae diam non enim vestibulum interdum. Fusce consectetuer risus a nunc. Maecenas fermentum, sem in pharetra pellentesque, velit turpis volutpat ante, in pharetra metus odio a lectus. Donec iaculis gravida nulla. Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. In convallis. Etiam egestas wisi a erat. Donec ipsum massa, ullamcorper in, auctor et, scelerisque sed, est. Etiam commodo dui eget wisi. Cras elementum. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Fusce wisi. Phasellus enim erat, vestibulum vel, aliquam a, posuere eu, velit. Vestibulum fermentum tortor id mi.'
          , textAlign: TextAlign.center,
        ),
      ),
    );
  }
}