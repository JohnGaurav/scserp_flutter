import 'dart:ui';

class EduData {
  EduData(this.year, this.sales);

  final String year;
  final double sales;
}

class DeptWisePresentData {
  DeptWisePresentData(this.name, this.count);
  final String name;
  final double count;
}

class GenderWiseData {
  final String gender;
  final double count;
  final Color color;
  GenderWiseData(this.gender, this.count, this.color);
}

class AnnualRevenueData {
  final String title;
  final double count;
  final Color color;
  AnnualRevenueData(this.title, this.count, this.color);
}

class AgeWiseData {
  AgeWiseData(this.name, this.count);

  final String name;
  final double count;
}
