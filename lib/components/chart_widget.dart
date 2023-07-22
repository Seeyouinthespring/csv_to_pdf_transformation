import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../models/chart_model.dart';

class ChartWidget extends StatelessWidget{
  final ChartModel model;

  const ChartWidget({super.key, required this.model});

  List<FlSpot> _getSpots(ChartModel model) {
    List<FlSpot> result = [];
    int i = 0;
    while (model.chartData[i].time <= model.duration){
      FlSpot spot = FlSpot(model.chartData[i].time, model.chartData[i].speed);
      result.add(spot);
      i++;
    }
    return result;
  }

  Widget _bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 12,
    );
    Widget text = const Text('', style: style);
    if (value % 60 == 0) {
      text = Text('${value ~/ 60}', style: style);
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget _leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 12,
    );
    Widget text = const Text('', style: style);
    text = Text(value.toString(), style: style);

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineTouchData: LineTouchData(
          enabled: true,
          touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: Colors.black26,
            getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
              return touchedBarSpots.map((barSpot) {
                final flSpot = barSpot;
                if (flSpot.x == 0 || flSpot.x == 6) {
                  return null;
                }
                return LineTooltipItem(
                  '',
                  const TextStyle(),
                  children: [
                    TextSpan(
                      text: 'Time: ${flSpot.x.toString()}\n',
                      style: const TextStyle(
                        color: Colors.yellow,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    TextSpan(
                      text: 'Speed: ${flSpot.y.toString()}',
                      style: const TextStyle(
                        color: Colors.yellow,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                  textAlign: TextAlign.start,
                );
              }).toList();
            },
          ),
        ),
        gridData: FlGridData(
          show: true,
          drawHorizontalLine: true,
          verticalInterval: 60,
          horizontalInterval: 1,
          getDrawingVerticalLine: (value) {
            return const FlLine(
              color: Colors.black26,
              strokeWidth: 1,
            );
          },
          getDrawingHorizontalLine: (value) {
            return const FlLine(
              color: Colors.black26,
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: _bottomTitleWidgets,
              interval: 60,
            ),
            axisNameSize: 28,
            axisNameWidget: const Text(
              'Time (min)',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          leftTitles: AxisTitles(
            axisNameSize: 28,
            axisNameWidget: const Text(
              'Speed',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: _leftTitleWidgets,
              reservedSize: 30,
              interval: 1,
            ),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.black),
        ),
        minX: 0,
        maxX: model.duration.toDouble(),
        minY: 0,
        maxY: model.chartData.where((element) => element.time <= model.duration).map((e) => e.speed).toList().reduce(max).ceilToDouble(),
        lineBarsData: [
          LineChartBarData(
            color: Colors.black,
            spots: _getSpots(model),
            barWidth: 2,
            isStrokeCapRound: true,
            dotData: const FlDotData(
              show: false,
            ),
          ),
        ],
      ),
    );
  }
}
