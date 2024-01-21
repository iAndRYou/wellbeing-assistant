import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:tuple/tuple.dart';

const indicatorGradient = SweepGradient(
  colors: <Color>[
    Colors.green,
    Colors.yellow,
    Colors.red,
  ],
  stops: <double>[0.0, 0.5, 1.0],
);

Widget radialIndicator({
  required Tuple2<double, double> range,
  required double value,
  required double width,
  required double height,
  bool showGradient = true,
  Color color = const Color.fromARGB(100, 150, 150, 150),
  Color indicatorColor = const Color.fromARGB(100, 80, 80, 80),
  Color labelColor = const Color.fromARGB(100, 80, 80, 80),
  Color backgroundColor = Colors.white,
}) {
  return SizedBox(
    width: width,
    height: height,
    child: Center(
      child: SfRadialGauge(
        axes: <RadialAxis>[
          RadialAxis(
            minimum: range.item1,
            maximum: range.item2,
            startAngle: 155,
            endAngle: 25,
            showLabels: false,
            showTicks: false,
            pointers: [
              WidgetPointer(
                value: value,
                child: CircleAvatar(
                  radius: height / 10,
                  backgroundColor: backgroundColor,
                  child: CircleAvatar(
                    radius: height / 10 - 5,
                    backgroundColor: indicatorColor,
                  ),
                ),
              )
            ],
            axisLineStyle: AxisLineStyle(
              thickness: height / 10 - 5,
              cornerStyle: CornerStyle.bothCurve,
              color: color,
              gradient: showGradient ? indicatorGradient : null,
            ),
          )
        ],
      ),
    ),
  );
}
