class Data {
  final int totalCasesLk;
  final int todayCasesLk;
  final int totalDeathsLk;
  final int todayDeathsLk;
  final int activeCasesLk;
  final int recoveredLk;

  final int totalCasesGl;
  final int todayCasesGl;
  final int totalDeathsGl;
  final int todayDeathsGl;
  final int recoveredGL;


  Data({
    this.todayCasesLk,
    this.todayDeathsLk,
    this.totalCasesLk,
    this.totalDeathsLk,
    this.activeCasesLk,
    this.recoveredLk,

    this.recoveredGL,
    this.todayCasesGl,
    this.todayDeathsGl,
    this.totalCasesGl,
    this.totalDeathsGl,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      todayCasesLk: json['data']['local_new_cases'] as int,
      todayDeathsLk: json['data']['local_new_deaths'] as int,
      totalCasesLk: json['data']['local_total_cases'] as int,
      totalDeathsLk: json['data']['local_deaths'] as int,
      activeCasesLk:
          json['data']['local_total_number_of_individuals_in_hospitals'] as int,
      recoveredLk: json['data']['local_recovered'] as int,

      recoveredGL: json['data']['global_recovered'] as int,
      todayCasesGl: json['data']['global_new_cases'] as int,
      todayDeathsGl: json['data']['global_new_deaths'] as int,
      totalCasesGl: json['data']['global_total_cases'] as int,
      totalDeathsGl: json['data']['local_total_deaths'] as int,
    );
  }
}
