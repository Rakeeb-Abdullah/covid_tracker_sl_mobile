import 'package:flutter/material.dart';
import 'http_request.dart';
import 'data_model.dart';
import 'package:intl/intl.dart';
import 'pie_chart_pg.dart';
import 'global_data.dart';

final formatter = new NumberFormat("#,###");

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        fontFamily: 'Poppins',
      ),
      home: DataHomeSl(),
    );
  }
}

class DataHomeSl extends StatelessWidget {
  final HttpService httpService = HttpService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 70,
            elevation: 0,
            title: Column(children: [
              Row(
                children: [
                  Text(
                    'Covid',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Tracker 🇱🇰',
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              Row(
                children: [
                  Text(
                    'www.prorakabd.xyz',
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 10,color:Colors.black.withOpacity(0.7))
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ])),
        body: Container(
          decoration: BoxDecoration(),
          child: FutureBuilder(
            future: httpService.getData(),
            builder: (BuildContext context, AsyncSnapshot<Data> snapshot) {
              if (snapshot.hasData) {
                Data data = snapshot.data;
                return dataCards(data);
              } else {
                return Container(child: Center(
                  
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo_fb.png',
                      height: 120,
                      width: 120,
                    ),
                    Padding(padding: EdgeInsets.all(20),child:
                      CircularProgressIndicator(color: Colors.teal,)),
                  ],
                )));
              }
            },
          ),
        ),
        bottomNavigationBar: bottomNavBar(context));
  }
//Bottom Nav Bar

  Widget bottomNavBar(BuildContext context) {
    return Container(
    
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 20),
          ],
        ),
        child: ClipRRect(
          // borderRadius: BorderRadius.only(
          //     topRight: Radius.circular(15), topLeft: Radius.circular(15)),
          child: BottomAppBar(
              color: Colors.teal[300],
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: IconButton(
                
                      icon: Icon(
                      
                        Icons.flag,
                        size: 30,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      }),
                ),
                Spacer(),
                Padding(
                    padding: EdgeInsets.all(10),
                    child: IconButton(
                        icon: Icon(Icons.public, size: 30, color: Colors.white),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GlobalDataPage()));
                        })),
                Spacer(),
                Padding(
                    padding: EdgeInsets.all(10),
                    child: IconButton(
                        icon: Icon(Icons.pie_chart,
                            size: 30, color: Colors.white),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChartsPage(
                                      // bottomNavBar: BottomAppBar(),
                                      )));
                        })),
              ])),
        ));
  }

// Data Card widget

  Widget dataCards(Data data) {
    return (GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 4,
      mainAxisSpacing: 10,
      padding: EdgeInsets.all(10),

      // shrinkWrap: true,

      children: [
        Card(
          color: Colors.purple[400],
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.coronavirus,
                size: 50,
                color: Colors.teal[100],
              ),
              Text(
                'Cases Todays 🇱🇰:',
                style: TextStyle(color: Colors.white),
              ),
              Text('${formatter.format(data.todayCasesLk)}',
                  style: TextStyle(fontSize: 15)),
            ],
          ),
        ),
        Card(
          color: Colors.grey[600],
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.warning_rounded,
                size: 50,
                color: Colors.teal[100],
              ),
              Text(
                'Deaths Todays 🇱🇰:',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Text('${formatter.format(data.todayDeathsLk)}',
                  style: TextStyle(fontSize: 15)),
            ],
          ),
        ),
        Card(
          color: Colors.blue[800],
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.coronavirus_outlined,
                size: 50,
                color: Colors.teal[100],
              ),
              Text(
                'Total Cases 🇱🇰:',
                style: TextStyle(color: Colors.white),
              ),
              Text('${formatter.format(data.totalCasesLk)}',
                  style: TextStyle(fontSize: 15)),
            ],
          ),
        ),
        Card(
          color: Colors.red,
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.warning_amber_rounded,
                size: 50,
                color: Colors.teal[100],
              ),
              Text(
                'Total Deaths 🇱🇰:',
                style: TextStyle(color: Colors.white),
              ),
              Text('${formatter.format(data.totalDeathsLk)}',
                  style: TextStyle(fontSize: 15)),
            ],
          ),
        ),
        Card(
          color: Colors.green,
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.done_rounded,
                size: 50,
                color: Colors.teal[100],
              ),
              Text(
                'Total Recovered 🇱🇰:',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              Text('${formatter.format(data.recoveredLk)}',
                  style: TextStyle(fontSize: 15)),
            ],
          ),
        ),
        Card(
          color: Colors.lightBlue,
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.king_bed_rounded,
                size: 50,
                color: Colors.teal[100],
              ),
              Text(
                'Total Active 🇱🇰:',
                style: TextStyle(color: Colors.white),
              ),
              Text('${formatter.format(data.activeCasesLk)}',
                  style: TextStyle(fontSize: 15)),
            ],
          ),
        ),
      ],
    ));
  }
}
