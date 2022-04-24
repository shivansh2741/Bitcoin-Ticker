import 'package:flutter/material.dart';
import 'price_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'apirequest.dart';
import 'price_screen.dart';

class Loading_Screen extends StatefulWidget {
  @override
  State<Loading_Screen> createState() => _Loading_ScreenState();
}

class _Loading_ScreenState extends State<Loading_Screen> {
  @override
  MakeRequest makeRequest = MakeRequest();

  void initState() {
    super.initState();
    getPrice();
  }

  void getPrice() async {
    var pricedata = await makeRequest.getdata('USD');
    print(pricedata);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PriceScreen(
        InitialPrice: pricedata,
      );
    }));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 40.0,
        ),
      ),
    );
  }
}
