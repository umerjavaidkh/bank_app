import 'dart:convert';

import 'package:abc_bank_app/customer_listing/text_style.dart';
import 'package:abc_bank_app/data/Customer.dart';
import 'package:flutter/cupertino.dart';

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:load/load.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:syncfusion_flutter_charts/charts.dart';

class DetailPage extends StatefulWidget {
  Customer customer;

  DetailPage(this.customer, {Key key, this.title}) : super(key: key);

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
      body: new Scaffold(
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
    return Expanded(
      child: Container(
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
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Container(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(width: 15),
                Expanded(
                  flex: 1,
                  child: getCardContainerLeft(customer),
                ),
                Container(width: 15),
                Expanded(
                  flex: 1,
                  child: getCardContainerRight(customer),
                ),
                Container(width: 15),
              ],
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              //height: 40,
              alignment: Alignment.centerLeft,
              child: Text("Stats",
                  style: TextStyle(color: Colors.black, fontSize: 30)),
            ),
            getStatsCard(customer),
          ],
        ),
      ),
    );
  }
}

getCardLeft(Customer customer) {
  return Card(
    color: Color(0xffedf1ff),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    elevation: 3.0,
    child: Container(
      margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
      constraints: BoxConstraints.expand(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(height: 4.0),
          Text("Incomes", style: Style.titleTextStyleBlack),
          Container(
            height: 120,
            width: 160,
            child: SimpleBarChart(SimpleBarChart._createSampleData1()),
          ),


          Row(
            children: <Widget>[
              Container(
                width: 10),
              Text("\$6000", style: Style.titleTextStyle),
              Container(
                width: 40,),
              Text("May", style: Style.smallTextStyle),
            ],
          )

        ],
      ),
    ),
  );
}

getCardRight(Customer customer) {
  return Card(
    color: Color(0xffffede9),
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
          new Text("Spending", style: Style.titleTextStyleBlack),
          Container(
            height: 120,
            width: 160,
            child: SimpleBarChart(SimpleBarChart._createSampleData2()),
          ),

          Row(
            children: <Widget>[
              Container(
                  width: 10),
              Text("\$1103.2", style: Style.titleTextStyleOrange),
              Container(
                width: 40,),
              Text("May", style: Style.smallTextStyleOrange),
            ],
          )

        ],
      ),
    ),
  );
}

getCardContainerLeft(Customer customer) {
  return Container(
    child: getCardLeft(customer),
    height: 205.0,
    // margin:  EdgeInsets.all(10.0),
  );
}

getCardContainerRight(Customer customer) {
  return Container(
    child: getCardRight(customer),
    height: 205.0,
    // margin:  EdgeInsets.all(10.0),
  );
}

getStatsCard(Customer customer) {

  List sampleData = [
    {"open":50.0, "high":100.0, "low":40.0, "close":80, "volumeto":5000.0},
    {"open":80.0, "high":90.0, "low":55.0, "close":65, "volumeto":4000.0},
    {"open":65.0, "high":120.0, "low":60.0, "close":90, "volumeto":7000.0},
    {"open":90.0, "high":95.0, "low":85.0, "close":80, "volumeto":2000.0},
    {"open":80.0, "high":85.0, "low":40.0, "close":50, "volumeto":3000.0},
  ];

  return Container(

    margin: EdgeInsets.all(10.0),
    child: Card(
      color: Color(0xffffffff),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      elevation: 8.0,
      child: new Container(
        margin: new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        constraints: new BoxConstraints.expand(),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Container(height: 20),
            SfCartesianChart(
                primaryXAxis: DateTimeAxis(),
                primaryYAxis: NumericAxis(
                    minimum: 10
                ),
                // Chart title
                title: ChartTitle(text: 'Half yearly analysis'),
                // Enable legend
                legend: Legend(isVisible: true),
                // Enable tooltip
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <ChartSeries<SalesData, DateTime>>[
                  SplineAreaSeries<SalesData, DateTime>(
                      borderWidth: 4,
                      borderDrawMode: BorderDrawMode.top,
                      borderColor:  const Color.fromRGBO(255, 194, 0, 1),
                      gradient: LinearGradient(
                          colors:<Color>[
                            Colors.transparent,
                            Color.fromRGBO(255, 224, 130, 0.5),
                            Color.fromRGBO(255, 213, 79, 0.5)
                          ],
                          stops: <double>[
                            0.0,
                            0.5,
                            1.0,
                          ],
                          transform: GradientRotation(270.toDouble() * 3.14 / 180)
                      ),
                      dataSource: <SalesData>[
                        SalesData(DateTime(2019,1,1), 35),
                        SalesData(DateTime(2019,1,2), 28),
                        SalesData(DateTime(2019,1,3), 34),
                        SalesData(DateTime(2019,1,4), 32),
                        SalesData(DateTime(2019,1,5), 40),
                        SalesData(DateTime(2019,1,6), 23),
                        SalesData(DateTime(2019,1,7), 31),
                        SalesData(DateTime(2019,1,8), 19),
                        SalesData(DateTime(2019,1,9), 39),
                        SalesData(DateTime(2019,1,10), 42),
                      ],
                      xValueMapper: (SalesData sales, _) => sales.year,
                      yValueMapper: (SalesData sales, _) => sales.sales,
                      markerSettings: MarkerSettings(
                          isVisible: true,
                          color: Colors.white60,
                          borderColor: Colors.blue,
                          height: 10,
                          width: 10
                      )
                  )
                ])


          ],
        ),
      ),
    ),
    height: 360.0,
    // margin:  EdgeInsets.all(10.0),
  );
}

class SimpleBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleBarChart(this.seriesList, {this.animate});

  /// Creates a [BarChart] with sample data and no transition.
  factory SimpleBarChart.withSampleData1() {
    return new SimpleBarChart(
      _createSampleData1(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  /// Creates a [BarChart] with sample data and no transition.
  factory SimpleBarChart.withSampleData2() {
    return new SimpleBarChart(
      _createSampleData2(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<OrdinalSales, String>> _createSampleData1() {
    final data = [
      new OrdinalSales('1', 5),
      new OrdinalSales('2', 25),
      new OrdinalSales('3', 100),
      new OrdinalSales('4', 75),
      new OrdinalSales('5', 50),
      new OrdinalSales('6', 33),
      new OrdinalSales('7', 78),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }

  static List<charts.Series<OrdinalSales, String>> _createSampleData2() {
    final data = [
      new OrdinalSales('1', 5),
      new OrdinalSales('2', 20),
      new OrdinalSales('3', 20),
      new OrdinalSales('4', 45),
      new OrdinalSales('5', 90),
      new OrdinalSales('6', 33),
      new OrdinalSales('7', 58),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}


class SalesData {
  SalesData(this.year, this.sales);

  final DateTime year;
  final double sales;
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}



