import 'package:csv_to_pdf_transformation/bloc/chart_event.dart';
import 'package:csv_to_pdf_transformation/components/dropdown_selector.dart';
import 'package:csv_to_pdf_transformation/services/csv_parser.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_app_file/open_app_file.dart';

import '../bloc/chart_bloc.dart';
import '../bloc/chart_state.dart';
import '../components/action_button.dart';
import '../components/chart_widget.dart';
import '../components/text_report.dart';
import '../services/file_service.dart';
import '../services/pdf_generator.dart';

class ChartPage extends StatelessWidget {
  final FileService fileService;
  final GlobalKey<State<StatefulWidget>> _printKey = GlobalKey();

  ChartPage({super.key, required this.fileService});

  @override
  Widget build(BuildContext context) {

    context.read<ChartBloc>().add(OnInit(service: fileService));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Chart page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<ChartBloc, ChartState>(
                builder: (context, state) {

                  double avgSpeed5 = state.chartModel.chartData.isEmpty ? 0.0
                      : CsVParser.roundDouble(state.chartModel.chartData.where((element) => element.time <= 300).map((e) => e.speed).average, 2,);
                  double avgSpeed10 = state.chartModel.chartData.isEmpty ? 0.0
                      : CsVParser.roundDouble(state.chartModel.chartData.where((element) => element.time <= 600).map((e) => e.speed).average, 2,);

                  if (state is ChartLoading) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  }
                  if (state is ChartLoading) {
                    return const Center(child: Text('ERROR'));
                  }
                  return  Column(
                    children: [
                      DropdownSelector(
                        duration: state.chartModel.duration,
                        onChanged: (value) {
                          context.read<ChartBloc>().add(OnDurationSwitched(duration: value));
                        },
                      ),
                      RepaintBoundary(
                        key: _printKey,
                        child: Column(
                          children: [
                            const Image(image: AssetImage('assets/images/speed.png')),
                            Container(
                              padding: const EdgeInsets.only(right: 10, top: 10, bottom: 10, left: 5),
                              width: MediaQuery.of(context).size.width,
                              height: 300,
                              child: ChartWidget(model: state.chartModel),
                            ),
                            TextReport(
                              avgSpeed5: avgSpeed5,
                              avgSpeed10: avgSpeed10,
                            ),
                          ],
                        ),
                      ),
                      ActionButton(
                        title: 'Generate .pdf',
                        onPressed: () async {
                          //context.read<ChartBloc>().add(OnLoading());
                          String a = await PdfGenerator.createPdf(_printKey);
                          //context.read<ChartBloc>().add(OnCancelLoading());
                          OpenAppFile.open(a);
                        },
                      ),
                    ],
                  );
                }
            ),
          ],
        ),
      ),
    );
  }
}
