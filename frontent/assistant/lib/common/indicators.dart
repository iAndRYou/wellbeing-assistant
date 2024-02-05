import 'package:assistant/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:tuple/tuple.dart';

const indicatorGradient = SweepGradient(
  colors: <Color>[
    Colors.red,
    Colors.yellow,
    Colors.green,
  ],
  stops: <double>[0.0, 0.5, 1.0],
);

const invertedGradient = SweepGradient(
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
  required String displayedValue,
  required String title,
  required double width,
  required double height,
  bool showGradient = true,
  bool inverted = false,
  Color color = const Color.fromARGB(100, 150, 150, 150),
  Color indicatorColor = const Color.fromARGB(150, 80, 80, 80),
  Color labelColor = const Color.fromARGB(150, 80, 80, 80),
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
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                widget: Text(
                  displayedValue,
                  style: themeData.textTheme.headlineSmall?.copyWith(
                    color: labelColor,
                  ),
                ),
                angle: 90,
                positionFactor: 0.1,
              ),
              GaugeAnnotation(
                widget: Text(title,
                    style: themeData.textTheme.bodySmall?.copyWith(
                      color: labelColor,
                    )),
                angle: 90,
                positionFactor: 0.8,
              ),
            ],
            pointers: [
              WidgetPointer(
                value: value,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: themeData.scaffoldBackgroundColor,
                  child: CircleAvatar(
                    radius: 5,
                    backgroundColor: indicatorColor,
                  ),
                ),
              )
            ],
            axisLineStyle: AxisLineStyle(
              thickness: 8,
              cornerStyle: CornerStyle.bothCurve,
              color: color,
              gradient: showGradient
                  ? inverted
                      ? invertedGradient
                      : indicatorGradient
                  : null,
            ),
          )
        ],
      ),
    ),
  );
}
