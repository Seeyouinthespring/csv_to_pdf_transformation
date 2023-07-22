import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/csv_parser.dart';
import '../models/chart_model.dart';
import 'chart_event.dart';
import 'chart_state.dart';

class ChartBloc extends Bloc<ChartEvent, ChartState> {
  ChartBloc() : super(ChartLoading(chartModel: ChartModel.placeholder())) {
    on<OnInit>(
      (event, emit) async {
        emit(ChartLoading(chartModel: ChartModel.placeholder()));
        var fileStringData = await event.service.getFile();
        ChartModel model = ChartModel(
          duration: 300,
          chartData: await CsVParser.csvToListModel(fileStringData),
        );

        emit(ChartData(chartModel: model));
      },
    );

    on<OnDurationSwitched>(
      (event, emit) async {
        ChartModel model = ChartModel(
          duration: event.duration,
          chartData: state.chartModel.chartData,
        );
        emit(ChartData(chartModel: model));
      },
    );

    on<OnLoading>((event, emit) async {
        emit(ChartLoading(chartModel: state.chartModel),);
      },
    );

    on<OnCancelLoading>(
      (event, emit) async {
        emit(ChartData(chartModel: state.chartModel),);
      }
    );
  }
}
