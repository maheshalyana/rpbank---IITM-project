import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TrasactionTile extends StatefulWidget {
  const TrasactionTile({super.key});

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
                    shape: BoxShape.circle,
                    color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
