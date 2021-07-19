import 'package:flutter/material.dart';
import 'data_model.dart';
import 'http_request.dart';
import 'main.dart';

import 'package:intl/intl.dart';

final formatter = new NumberFormat("#,###");

class GlobalDataPage extends StatelessWidget {
  final HttpService httpService = HttpService();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        elevation: 0,
        title: Row(
          children: [
            Text(
              'Covid',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Tracker 🌎',
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
            
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
       bottomNavigationBar: DataHomeSl().bottomNavBar(context),
    );
  }

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
                'Cases Todays 🌎:',
                style: TextStyle(color: Colors.white),
              ),
              Text('${formatter.format(data.todayCasesGl)}',
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
                'Deaths Todays 🌎:',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Text('${formatter.format(data.todayDeathsGl)}',
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
                'Total Cases 🌎:',
                style: TextStyle(color: Colors.white),
              ),
              Text('${formatter.format(data.totalCasesGl)}',
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
                'Total Deaths 🌎:',
                style: TextStyle(color: Colors.white),
              ),
              Text('${formatter.format(data.totalDeathsGl)}',
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
                'Total Recovered 🌎:',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              Text('${formatter.format(data.recoveredGL)}',
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
                'Total Active 🌎:',
                style: TextStyle(color: Colors.white),
              ),
              Text('${formatter.format(data.totalCasesGl - (data.recoveredGL+data.totalDeathsGl))}',
                  style: TextStyle(fontSize: 15)),
            ],
          ),
        ),
      ],
    ));
  }
}
