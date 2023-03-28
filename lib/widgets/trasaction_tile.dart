import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TrasactionTile extends StatefulWidget {
  TrasactionTile({
    super.key,
    required this.amount,
    required this.balance,
    required this.date,
    required this.name,
    required this.time,
  });
  String name;
  String date;
  String time;
  String amount;
  String balance;

  @override
  State<TrasactionTile> createState() => _TrasactionTileState();
}

class _TrasactionTileState extends State<TrasactionTile> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: width * 0.9,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SvgPicture.asset(
              "assets/images/rectangle.svg",
              fit: BoxFit.fitWidth,
            ),
            Positioned(
              top: 23,
              left: 0.5,
              child: Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/dp.png"),
                    ),
                    border: Border.all(color: Colors.black),
                    shape: BoxShape.circle,
                    color: Colors.red),
              ),
            ),
            Positioned(
              left: 65,
              child: Container(
                height: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontFamily: "Sansation",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          widget.date,
                          style: TextStyle(
                            color: Color(0x7f000000),
                            fontSize: 9,
                            fontFamily: "Sansation",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.time,
                          style: TextStyle(
                            color: Color(0x7f000000),
                            fontSize: 7,
                            fontFamily: "Sansation",
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 23,
              right: 20,
              child: Container(
                // height: 54,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "₹${widget.amount}",
                      style: TextStyle(
                        color: widget.amount.contains("-")? Colors.red : Color(0xff0eb300),
                        fontSize: 19,
                        fontFamily: "Sansation",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "New balance",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontFamily: "Sansation",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "₹${widget.balance}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontFamily: "Sansation",
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
