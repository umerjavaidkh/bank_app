import 'dart:convert';


import 'package:abc_bank_app/customer_listing/text_style.dart';
import 'package:abc_bank_app/data/GithubUser.dart';

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:load/load.dart';



class DetailPage extends StatefulWidget {

  Customer customer;

  DetailPage(this.customer,{Key key, this.title}) : super(key: key);

  final String title;



  @override
  _DetailPageState createState() => _DetailPageState(customer);

}

class _DetailPageState extends State<DetailPage> {

  Customer customer;

  _DetailPageState(this.customer);

  @override
  void initState() {
    super.initState();

    //showLoadingDialog();

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: topAppBar,
      body:  new Scaffold(
        body: new Column(
          children: <Widget>[

            new PageBody(customer),
          ],
        ),
      ),

    );
  }
}

final topAppBar = AppBar(
  elevation: 0.1,
  backgroundColor: Color(0xff6573d0),
  title: Text("Finance"),

);


class PageBody extends StatelessWidget {

  Customer customer;

  PageBody(this.customer);

  @override
  Widget build(BuildContext context) {
    return
    Expanded(
    child:
       Container(
         decoration: BoxDecoration(
           //borderRadius: BorderRadius.all(Radius.circular(40)),
             boxShadow: <BoxShadow>[
               BoxShadow(
                   color: Colors.grey.shade200,
                   offset: Offset(2, 4),
                   blurRadius: 5,
                   spreadRadius: 2)
             ],
             gradient: LinearGradient(
                 begin: Alignment.topCenter,
                 end: Alignment.bottomCenter,
                 colors: [Color(0xffffffff), Color(0xff6573d0)])),

         padding:  EdgeInsets.all(10.0),
        child: Column(

          children: <Widget>[

            Container(height: 20),
            Row(

              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(width: 15),
                 Expanded(
                    flex:  1 ,
                    child:getCardContainerLeft(customer),

                ),
                Container(width: 15),
                 Expanded(
                    flex: 1 ,
                     child:getCardContainerRight(customer),
                ),
                Container(width: 15),
              ],
            ),

            Container(
              padding:  EdgeInsets.all(20.0),
              //height: 40,
              alignment: Alignment.centerLeft,
              child:Text("Stats",style: TextStyle(color: Colors.black,fontSize: 30)),

            ),
            getStatsCard(customer),
          ],

        ),

      ),
    );

  }




}


getCardLeft(Customer customer) {

  return   Card(

    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    elevation: 3.0,

    child: new Container(
      margin: new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(height: 4.0),
          new Text("abcd",
              style: Style.titleTextStyle),
          new Container(height: 6.0),
          new Text("dob", style: Style.commonTextStyle),
          //new Separator(),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Expanded(
                  flex: 3,
                  child: _labelValue(
                      value: "email",
                      image: 'assets/img/ic_distance.png')

              ),
              new Container(
                width: 0.0,
              ),
              new Expanded(
                  flex: 1,
                  child: _labelValue(
                      value: "active",
                      image: 'assets/img/ic_gravity.png')
              )
            ],
          ),
        ],
      ),
    ),

  );
}


getCardRight(Customer customer) {

  return   Card(

    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    elevation: 3.0,

    child: new Container(
      margin: new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(height: 4.0),
          new Text("Spending",
              style: Style.titleTextStyle),
          new Container(height: 6.0),
          new Text("dob", style: Style.commonTextStyle),
          //new Separator(),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Expanded(
                  flex: 3,
                  child: _labelValue(
                      value: "email",
                      image: 'assets/img/ic_distance.png')

              ),
              new Container(
                width: 0.0,
              ),
              new Expanded(
                  flex: 1,
                  child: _labelValue(
                      value: "active",
                      image: 'assets/img/ic_gravity.png')
              )
            ],
          ),
        ],
      ),
    ),

  );
}


Widget _labelValue({String value, String image}) {
  return new Container(
    child: new Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[

          new Text(value, style: Style.smallTextStyle),
        ]
    ),
  );
}

getCardContainerLeft(Customer customer) {
  return Container(
    child: getCardLeft(customer),
    height: 200.0,
    // margin:  EdgeInsets.all(10.0),
  );
}

getCardContainerRight(Customer customer) {
  return Container(
    child: getCardRight(customer),
    height: 200.0,
    // margin:  EdgeInsets.all(10.0),
  );
}


getStatsCard(Customer customer) {

  return Container(
      margin:  EdgeInsets.all(10.0),
    child: Card(

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      elevation: 3.0,

      child: new Container(
        margin: new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        constraints: new BoxConstraints.expand(),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

          ],
        ),
      ),

    ),
    height: 360.0,
    // margin:  EdgeInsets.all(10.0),
  );


}









