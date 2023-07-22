import 'data_model.dart';

class ChartModel {
  final int duration;
  final List<DataModel> chartData;

  ChartModel({required this.duration, required this.chartData});

  factory ChartModel.placeholder(){
    return ChartModel(duration: 300, chartData: []);
  }
}