import 'package:abc_bank_app/Widget/SlideRightRoute.dart';
import 'package:abc_bank_app/customer_detail/DetailPage.dart';
import 'package:abc_bank_app/data/Customer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../ListPage.dart';
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
      alignment: horizontal ? FractionalOffset.centerLeft : FractionalOffset
          .center,
      child:
      new Container(
          width: 92.0,
          height: 92.0,
          child: CachedNetworkImage(
            imageUrl: customer.avatar,
            placeholder: (context, url) => const CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 46,
            ),
            imageBuilder: (context, image) => CircleAvatar(
              backgroundImage: image,
              radius: 46,
            ),
          ),
          ),
    );



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


    final planetCardContent = Card(
      elevation: 8.0,
      child: new Container(
        margin: new EdgeInsets.fromLTRB(
            horizontal ? 60.0 : 16.0, horizontal ? 16.0 : 42.0, 16.0, 16.0),
        constraints: new BoxConstraints.expand(),
        child: new Column(
          crossAxisAlignment: horizontal
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,
          children: <Widget>[
            new Container(height: 4.0),
            new Text(customer.first_name + " " + customer.last_name,
                style: Style.titleTextStyle),
            new Container(height: 6.0),
            new Text(customer.dob, style: Style.commonTextStyle),
            //new Separator(),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Expanded(
                    flex: horizontal ? 3 : 0,
                    child: _labelValue(
                        value: customer.email,
                        image: 'assets/img/ic_distance.png')

                ),
                new Container(
                  width: horizontal ? 0.0 : 24.0,
                ),
                new Expanded(
                    flex: horizontal ? 1 : 0,
                    child: _labelValue(
                        value: customer.status,
                        image: 'assets/img/ic_gravity.png')
                )
              ],
            ),
          ],
        ),
      ),

    );

    final planetCard = Container(
      child: planetCardContent,
      height: horizontal ? 124.0 : 154.0,
      margin: horizontal
          ? new EdgeInsets.only(left: 46.0)
          : new EdgeInsets.only(top: 72.0),

    );


    return new GestureDetector(
      onTap: horizontal
          ? () =>
          Navigator.of(context).push(
            new PageRouteBuilder(
              //pageBuilder: (_, __, ___) => new DetailPage(planet),
              transitionsBuilder: (context, animation, secondaryAnimation,
                  child) =>
              new FadeTransition(opacity: animation, child: child),
            ),
          )
          : null,
      child:

      InkWell(
        onTap: () {
          Navigator.push(context, SlideRightRoute(page: DetailPage(customer)));
        },

        child: new Container(
          margin: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 24.0,
          ),
          child:
          Stack(
            children: <Widget>[
              planetCard,
              planetThumbnail,
            ],
          ),
        ),
      ),
    );
  }
}
