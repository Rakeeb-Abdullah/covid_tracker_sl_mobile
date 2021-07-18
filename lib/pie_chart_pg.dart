import 'package:flutter/material.dart';
import 'data_model.dart';
import 'http_request.dart';
import 'package:pie_chart/pie_chart.dart';

class ChartsPage extends StatelessWidget {
  final HttpService httpService = HttpService();
  final Widget bottomNavBar;
  ChartsPage({Key key, @required this.bottomNavBar}) : super(key: key);
  @override
  Widget build(BuildContext context){
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
                'Tracker 🇱🇰',
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
        body:FutureBuilder(
          future: httpService.getData(),
          builder: (BuildContext context,AsyncSnapshot<Data> snapshot){
            if(snapshot.hasData){
              Data data = snapshot.data;
              return pieChartContainer(data);
            }else{
              return CircularProgressIndicator();
            }
          },
        ),
        bottomNavigationBar: bottomNavBar,
        );
  }
  
    Widget pieChartContainer(Data data) {
    Map<String, double> dataMap = {
      'Deaths': data.todayDeathsLk.toDouble(),
      'Recovered': data.recoveredLk.toDouble(),
      'Active Cases': data.activeCasesLk.toDouble()
    };
    return PieChart(dataMap: dataMap);
  }


  }
