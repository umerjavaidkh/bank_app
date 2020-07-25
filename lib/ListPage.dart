import 'dart:convert';

import 'package:abc_bank_app/data/GithubUser.dart';
import 'package:abc_bank_app/test_package/common/customer_summary.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListPage extends StatefulWidget {


  ListPage({Key key, this.title}) : super(key: key);

  final String title;



  @override
  _ListPageState createState() => _ListPageState();

}

class _ListPageState extends State<ListPage> {


  List<Customer> list = List();

  List<Customer> parseProducts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Customer>((json) =>Customer.fromJson(json)).toList();
  }

  _fetchData() async {

    final response =
    await http.get("https://api.npoint.io/82d2c20fa88817019213");
    if (response.statusCode == 200) {

      Map<String, dynamic> data = jsonDecode(response.body);
      //print(response.body);
      for(var item in data['result']){
        //print(item);
        list.add(new Customer.fromJson(item));
      }


     /* list = (json.decode(response.body)["result"] as List)
          .map((data) => new Customer.fromJson(data))
          .toList();*/

      setState(() {

      });

    } else {
      throw Exception('Failed to load photos');
    }
  }



  @override
  void initState() {
    super.initState();

    _fetchData();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x806573d0),
      appBar: topAppBar,
      body: new Scaffold(
        body: new Column(
          children: <Widget>[

            new HomePageBody(list),
          ],
        ),
      ),
      bottomNavigationBar: makeBottom,
    );
  }
}

final topAppBar = AppBar(
  elevation: 0.1,
  backgroundColor: Color(0x806573d0),
  title: Text("Customers"),

);



final makeBottom = Container(
  height: 55.0,
  child: BottomAppBar(
    color: Color(0xff6573d0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.home, color: Colors.white),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.blur_on, color: Colors.white),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.hotel, color: Colors.white),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.account_box, color: Colors.white),
          onPressed: () {},
        )
      ],
    ),
  ),
);






class HomePageBody extends StatelessWidget {



  List<Customer> customers;

   HomePageBody(List<Customer> _usersData){

     if(_usersData==null) return;


     customers=_usersData;

  }


  @override
  Widget build(BuildContext context) {
    return new Expanded(
      child: new Container(
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
        child: new CustomScrollView(
          scrollDirection: Axis.vertical,
          shrinkWrap: false,
          slivers: <Widget>[
            new SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              sliver: new SliverList(
                delegate: new SliverChildBuilderDelegate(
                      (context, index) => new CustomerSummary(customers[index]),
                  childCount: customers == null ? 0 : customers.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}









