import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rpbank/widgets/trasaction_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.align_horizontal_left_rounded,
            color: Colors.black,
          ),
        ),
        title: Text(
          "MAHESH",
          style: TextStyle(
            color: Colors.black,
            fontSize: 29,
            fontFamily: "Sansation",
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          Container(
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
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          // height: height,
          // width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: height * 0.4,
                width: height * 0.54,
                child: Stack(
                  children: [
                    // SizedBox(
                    //   height: height * 0.4,
                    //   width: width*0.98,
                    //   child:
                    Image.asset(
                      "assets/images/card.png",
                      fit: BoxFit.contain,
                    ),
                    // ),
                    Positioned(
                      top: 35,
                      right: 30,
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                        shadows: [
                          BoxShadow(
                            blurStyle: BlurStyle.inner,
                            offset: Offset(0, 2),
                            color: Colors.black26,
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 55,
                      left: 30,
                      child: Text(
                        "Good morning,\nMahesh Alyana",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize:
                              width < height ? width * 0.06 : width * 0.03,
                          fontFamily: "Sansation",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 55,
                        right: 30,
                        child: Column(
                          children: [
                            Text(
                              "Your balance",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: width < height
                                    ? width * 0.04
                                    : width * 0.02,
                                fontFamily: "Sansation",
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              "₹2000",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: width < height
                                    ? width * 0.045
                                    : width * 0.025,
                                fontFamily: "Sansation",
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        )),
                  ],
                ),
              ),
              Container(
                height: height * 0.5,
                width: width * 0.95,
                child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 17,
                            ),
                            SizedBox(
                              width: width * 0.85,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width: width * 0.22,
                                    height: width * 0.22,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xff0f1113),
                                          blurRadius: 16,
                                          offset: Offset(3, 4),
                                        ),
                                        BoxShadow(
                                          color: Color(0x66434d56),
                                          blurRadius: 16,
                                          offset: Offset(-3, -4),
                                        ),
                                      ],
                                      color: Colors.black,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Icon(
                                            Icons.send,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          "SEND",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontFamily: "Sansation",
                                            fontWeight: FontWeight.w700,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: width * 0.22,
                                    height: width * 0.22,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xff0f1113),
                                          blurRadius: 16,
                                          offset: Offset(3, 4),
                                        ),
                                        BoxShadow(
                                          color: Color(0x66434d56),
                                          blurRadius: 16,
                                          offset: Offset(-3, -4),
                                        ),
                                      ],
                                      color: Colors.black,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          "EDIT",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontFamily: "Sansation",
                                            fontWeight: FontWeight.w700,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: width * 0.22,
                                    height: width * 0.22,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xff0f1113),
                                          blurRadius: 16,
                                          offset: Offset(3, 4),
                                        ),
                                        BoxShadow(
                                          color: Color(0x66434d56),
                                          blurRadius: 16,
                                          offset: Offset(-3, -4),
                                        ),
                                      ],
                                      color: Colors.black,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Icon(
                                            Icons.logout,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          "LOGOUT",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontFamily: "Sansation",
                                            fontWeight: FontWeight.w700,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Your Transactions",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 26,
                                    fontFamily: "Sansation",
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      return TrasactionTile();
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
