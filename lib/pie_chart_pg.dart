import 'package:flutter/material.dart';
import 'data_model.dart';
import 'http_request.dart';
import 'package:pie_chart/pie_chart.dart';
import 'main.dart';

class ChartsPage extends StatelessWidget {
  final HttpService httpService = HttpService();
  // final Widget bottomNavBar;
  // ChartsPage({Key key, @required this.bottomNavBar}) : super(key: key);
  @override
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
              'Charts',
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
            return pieChartContainer(data);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      bottomNavigationBar: DataHomeSl().bottomNavBar(context),
    );
  }

  
  Widget pieChartContainer(Data data) {
    Map<String, double> datamaplocal = {
      'Deaths': data.totalDeathsLk.toDouble(),
      'Recovered': data.recoveredLk.toDouble(),
      'Active Cases': data.activeCasesLk.toDouble()
    };

    Map<String, double> datamapglobal = {
      'Deaths': data.totalDeathsGl.toDouble(),
      'Recovered': data.recoveredGL.toDouble(),
      'Active Cases': data.totalCasesGl -
          (data.recoveredGL + data.totalDeathsGl).toDouble(),
    };

    return Column(
      children: [
        Card(
          color: Colors.yellow[100],
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.all(30),
                  child: PieChart(
                    dataMap: datamaplocal,
                    colorList: [
                      Colors.red,
                      Colors.teal[600],
                      Colors.blue[300],
                    ],
                    animationDuration:Duration(milliseconds: 30),

                    
                    ringStrokeWidth: 40,
                    centerText: "Local Covid Cases",
                    chartType: ChartType.ring,
                    chartRadius: 150,
                    chartValuesOptions: ChartValuesOptions(
                      showChartValuesInPercentage: true,
                      showChartValuesOutside: true,
                        showChartValues: true,
                        chartValueBackgroundColor: Colors.transparent),
                  )),
            ],
          ),
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        Card(
          color:Colors.blue[100],
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.all(30),
                  child: PieChart(
                    dataMap: datamapglobal,
                    colorList: [
                      Colors.red,
                      Colors.teal,
                      Colors.blue[400],
                    ],
                    ringStrokeWidth: 40,
                    centerText: "Global Covid Cases",
                    chartType: ChartType.ring,
                    chartRadius: 150,
                    animationDuration:Duration(milliseconds: 30),
                    chartValuesOptions: ChartValuesOptions(
                        showChartValuesInPercentage: true,
                      showChartValuesOutside: true,
                        showChartValues: true,
                        chartValueBackgroundColor: Colors.transparent),
                  )),
            ],
          ),
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        Center(child: Text("Last Updated: ${data.updateTime}"),)

      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
}
