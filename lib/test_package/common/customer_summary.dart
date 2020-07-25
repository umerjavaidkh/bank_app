import 'package:abc_bank_app/data/GithubUser.dart';
import 'package:abc_bank_app/test_package/common/separator.dart';
import 'package:abc_bank_app/test_package/model/planets.dart';
import 'package:flutter/material.dart';

import '../text_style.dart';


class CustomerSummary extends StatelessWidget {

  final Customer customer;
  final bool horizontal;

  CustomerSummary(this.customer, {this.horizontal = true});

  CustomerSummary.vertical(this.customer): horizontal = false;


  @override
  Widget build(BuildContext context) {

    final planetThumbnail = new Container(
      margin: new EdgeInsets.symmetric(
        vertical: 16.0
      ),
      alignment: horizontal ? FractionalOffset.centerLeft : FractionalOffset.center,
      child:
      new Container(
          width: 92.0,
          height: 92.0,
          decoration: new BoxDecoration(
              shape: BoxShape.circle,
              image: new DecorationImage(
                  fit: BoxFit.fill,
                  image: new NetworkImage(
                      customer.avatar)
              )
          )),
    );



    Widget _planetValue({String value, String image}) {
      return new Container(
        child: new Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Image.asset(image, height: 12.0),
            new Container(width: 8.0),
            new Text("Customer", style: Style.smallTextStyle),
          ]
        ),
      );
    }


    final planetCardContent = Card(
      elevation: 8.0,
      child: new Container(
        margin: new EdgeInsets.fromLTRB(horizontal ? 76.0 : 16.0, horizontal ? 16.0 : 42.0, 16.0, 16.0),
        constraints: new BoxConstraints.expand(),
        child: new Column(
          crossAxisAlignment: horizontal ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          children: <Widget>[
            new Container(height: 4.0),
            new Text(customer.first_name+" "+customer.last_name, style: Style.titleTextStyle),
            new Container(height: 6.0),
            new Text("", style: Style.commonTextStyle),
            //new Separator(),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Expanded(
                    flex: horizontal ? 1 : 0,
                    child: _planetValue(
                        value: "1",
                        image: 'assets/img/ic_distance.png')

                ),
                new Container(
                  width: horizontal ? 8.0 : 32.0,
                ),
                new Expanded(
                    flex: horizontal ? 1 : 0,
                    child: _planetValue(
                        value: "no",
                        image: 'assets/img/ic_gravity.png')
                )
              ],
            ),
          ],
        ),
      ),

    );

    final planetCard =Container(
          child: planetCardContent,
          height: horizontal ? 124.0 : 154.0,
          margin: horizontal
              ? new EdgeInsets.only(left: 46.0)
              : new EdgeInsets.only(top: 72.0),

        );



    return new GestureDetector(
      onTap: horizontal
          ? () => Navigator.of(context).push(
            new PageRouteBuilder(
              //pageBuilder: (_, __, ___) => new DetailPage(planet),
              transitionsBuilder: (context, animation, secondaryAnimation, child) =>
                new FadeTransition(opacity: animation, child: child),
              ) ,
            )
          : null,
      child: new Container(
        margin: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0,
        ),
        child: new Stack(
          children: <Widget>[
            planetCard,
            planetThumbnail,
          ],
        ),
      )
    );
  }
}