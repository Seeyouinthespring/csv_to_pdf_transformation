import '../models/chart_model.dart';

sealed class ChartState{
  final ChartModel chartModel;
  const ChartState({required this.chartModel});
}

class ChartLoading extends ChartState{
  ChartLoading({required super.chartModel});
}

class ChartError extends ChartState{
  final String message;
  ChartError({required this.message, required super.chartModel});
}

class ChartData extends ChartState{
  ChartData({required super.chartModel});
}