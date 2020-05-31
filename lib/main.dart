import 'package:flutter/material.dart';
import 'dart:math';
void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ItCrowdPage(),
    );
  }
}
const SCALE_FRACTION = 0.7;
const FULL_SCALE = 1.0;
const PAGER_HEIGHT = 100.0;

class ItCrowdPage extends StatefulWidget {
  @override
  _ItCrowdPageState createState() => _ItCrowdPageState();
}

class _ItCrowdPageState extends State<ItCrowdPage> {
  double viewPortFraction = 0.5;

  PageController pageController;

  int currentPage = 2;

  List<String> listOfCharacters = ['Total Orders','Reviews','Top dishes'];
  

  double page = 2.0;

  @override
  void initState() {
    pageController =
        PageController(initialPage: currentPage, viewportFraction: viewPortFraction);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        title: Text(
          "Scroll 3d",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 10,),
          Container(
            height: PAGER_HEIGHT,
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification notification) {
                if (notification is ScrollUpdateNotification) {
                  setState(() {
                    page = pageController.page;
                  });
                }
              },
              child: PageView.builder(
                onPageChanged: (pos) {
                  setState(() {
                    currentPage = pos;
                  });
                },
                physics: BouncingScrollPhysics(),
                controller: pageController,
                itemCount: listOfCharacters.length,
                itemBuilder: (context, index) {
                  final scale =
                      max(SCALE_FRACTION, (FULL_SCALE - (index - page).abs()) + viewPortFraction);
                  return circleOffer(
                      listOfCharacters[index], scale);
                },
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(20.0),
          //   child: Text(
          //       listOfCharacters[currentPage]['name'],
          //       textAlign: TextAlign.center,
          //       style: TextStyle(fontSize: 20),
          //     ),
          // ),

        ],
      ),
    );
  }

  Widget circleOffer(String text, double scale) {

    return Align(
        
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: EdgeInsets.only(bottom: 10),
          height: PAGER_HEIGHT * scale,
          width: PAGER_HEIGHT*1.5,
          child: Card(
              elevation: 4,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(side: BorderSide(color: Colors.grey.shade200, width: 1,),borderRadius: BorderRadius.all(Radius.circular(10))),
              child: RaisedButton(
                color: Colors.red,
                child:Text(text),
                onPressed: (){},
                //it: BoxFit.cover,
              ),
            ),
        ),
    );
  }
}