import 'package:flutter/material.dart';
import 'http_request.dart';
import 'data_model.dart';
import 'package:intl/intl.dart';

final formatter = new NumberFormat("#,###");

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.teal,
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 100,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15))),
          title: Row(
            children: [
              Text('Covid Tracker '),
              Icon(
                Icons.coronavirus,
                size: 40,
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
        body: FutureBuilder(
          future: httpService.getData(),
          builder: (BuildContext context, AsyncSnapshot<Data> snapshot) {
            if (snapshot.hasData) {
              Data data = snapshot.data;
              return dataCards(data);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        bottomNavigationBar: bottomNavBar());
  }

//Bottom Nav Bar

  Widget bottomNavBar() {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 20),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15), topLeft: Radius.circular(15)),
          child: BottomAppBar(
              color: Colors.teal,
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
                      onPressed: () {}),
                ),
                Text('|'),
                Padding(
                    padding: EdgeInsets.all(10),
                    child: IconButton(
                        icon: Icon(Icons.public, size: 30, color: Colors.white),
                        onPressed: () {}))
              ])),
        ));
  }

// Data Card widget

  Widget dataCards(Data data) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 4,
      mainAxisSpacing: 10,
      padding: EdgeInsets.all(10),
      children: <Widget>[
        Card(
          color: Colors.teal[200],
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
                color: Colors.teal[900],
              ),
              Text(
                'Cases Todays-SL:',
                style: TextStyle(color: Colors.white),
              ),
              Text('${formatter.format(data.todayCasesLk)}',
                  style: TextStyle(fontSize: 15)),
            ],
          ),
        ),


        Card(
          color: Colors.teal[200],
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
                color: Colors.teal[900],
              ),
              Text(
                'Deaths Todays-SL:',
                style: TextStyle(color: Colors.white),
              ),
              Text('${formatter.format(data.todayDeathsLk)}',
                  style: TextStyle(fontSize: 15)),
            ],
          ),
        ),


        Card(
          color: Colors.teal[200],
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
                color: Colors.teal[900],
              ),
              Text(
                'Total Cases-SL:',
                style: TextStyle(color: Colors.white),
              ),
              Text('${formatter.format(data.totalCasesLk)}',
                  style: TextStyle(fontSize: 15)),
            ],
          ),
        ),


        Card(
          color: Colors.teal[200],
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
                color: Colors.teal[900],
              ),
              Text(
                'Total Deaths-SL:',
                style: TextStyle(color: Colors.white),
              ),
              Text('${formatter.format(data.totalDeathsLk)}',
                  style: TextStyle(fontSize: 15)),
            ],
          ),
        ),


        Card(
          color: Colors.teal[200],
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
                color: Colors.teal[900],
              ),
              Text(
                'Total Recovered-SL:',
                style: TextStyle(color: Colors.white),
              ),
              Text('${formatter.format(data.recoveredLk)}',
                  style: TextStyle(fontSize: 15)),
            ],
          ),
        ),


        Card(
          color: Colors.teal[200],
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
                color: Colors.teal[900],
              ),
              Text(
                'Total Active-SL:',
                style: TextStyle(color: Colors.white),
              ),
              Text('${formatter.format(data.activeCasesLk)}',
                  style: TextStyle(fontSize: 15)),
            ],
          ),
        ),
      ],
    );
  }
}
