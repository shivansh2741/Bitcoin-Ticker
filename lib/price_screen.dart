import 'dart:convert';
import 'package:bitcoin_ticker/apirequest.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class PriceScreen extends StatefulWidget {
  final InitialPrice;
  PriceScreen({this.InitialPrice});
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  bool flag = false;
  MakeRequest makeRequest = MakeRequest();
  String dropdownvalue = 'USD';
  var cryptoprice;

  @override
  void initState() {
    super.initState();
    cryptoprice = widget.InitialPrice;
  }

  Future<dynamic> getinfo() async {
    var cryptodata = await makeRequest.getdata(dropdownvalue);
    if (flag == false) {
      cryptoprice = cryptodata;
      setState(() {
        flag = true;
      });
    }
    return cryptodata;
  }

  Widget iosPicker() {
    List<Text> iosMenuItemList = [];
    for (var textitem in currenciesList) {
      iosMenuItemList.add(Text(textitem));
    }
    return CupertinoPicker(
      itemExtent: 30.0,
      onSelectedItemChanged: (value) {
        setState(() {
          dropdownvalue = currenciesList[value];
          cryptoprice = getinfo();
        });
      },
      children: iosMenuItemList,
    );
  }

  Widget androidPicker() {
    List<DropdownMenuItem<String>> DropdownItemList = [];
    for (var currency in currenciesList) {
      var newItem = DropdownMenuItem(
        value: currency,
        child: Text(
          currency,
        ),
      );
      DropdownItemList.add(newItem);
    }
    return DropdownButton<String>(
        value: dropdownvalue,
        items: DropdownItemList,
        onChanged: (value) async {
          cryptoprice = await getinfo();
          setState(() {
            dropdownvalue = value;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('🤑 Coin Ticker')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $cryptoprice $dropdownvalue',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iosPicker() : androidPicker(),
          ),
        ],
      ),
    );
  }
}
