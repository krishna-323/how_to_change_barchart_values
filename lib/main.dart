import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GlobalKey<_BarChartDataState> barChartKey = GlobalKey<_BarChartDataState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Expanded(child: BarChartData(key: UniqueKey())), // Add a key to BarChartData
            Expanded(child: LineChartData()),
            Expanded(child: PieChartData( barChartKey: barChartKey,)),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  final String x;
  final int y;
  final Color color;

  ChartData(this.x, this.y, this.color);

  ChartData copyWith({String? x, int? y, Color? color}) {
    return ChartData(x ?? this.x, y ?? this.y, color ?? this.color);
  }
}

class ChartData2 {
  final String x;
  final int targeted;
  final int achieved;
  final int enquiry;
  final int sales;
  final Color color;

  ChartData2(this.x, this.targeted, this.achieved, this.enquiry, this.sales, this.color);
}

// BarChart.
class BarChartData extends StatefulWidget {
  const BarChartData({Key? key}) : super(key: key);

  @override
  State<BarChartData> createState() => _BarChartDataState();
}

class _BarChartDataState extends State<BarChartData> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true, animationDuration: 1);
    super.initState();
  }

  final List<ChartData> barChartDataSales = [
    ChartData('Jan', 25, const Color.fromRGBO(9, 0, 136, 1)),
    ChartData('Feb', 38, const Color.fromRGBO(147, 0, 119, 1)),
    ChartData('Mar', 34, const Color.fromRGBO(228, 0, 124, 1)),
    ChartData('April', 34, const Color.fromRGBO(228, 0, 124, 1)),
    ChartData('May', 23, const Color.fromRGBO(228, 0, 124, 1)),
    ChartData('Jun', 33, const Color.fromRGBO(228, 0, 124, 1)),
    ChartData('Others', 52, const Color.fromRGBO(255, 189, 57, 1)),
  ];

  final List<ChartData> barChartDataEnquiry = [
    ChartData('Jan', 60, const Color.fromRGBO(9, 0, 136, 1)),
    ChartData('Feb', 32, const Color.fromRGBO(147, 0, 119, 1)),
    ChartData('Mar', 41, const Color.fromRGBO(228, 0, 124, 1)),
    ChartData('April', 31, const Color.fromRGBO(228, 0, 124, 1)),
    ChartData('May', 41, const Color.fromRGBO(228, 0, 124, 1)),
    ChartData('Jun', 51, const Color.fromRGBO(228, 0, 124, 1)),
    ChartData('Others', 22, const Color.fromRGBO(255, 189, 57, 1)),
  ];

  void updateBarChartData(int index, int newValue) {
    setState(() {
      barChartDataSales[index] = barChartDataSales[index].copyWith(y: newValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      tooltipBehavior: _tooltipBehavior,
      isTransposed: true,
      primaryXAxis: CategoryAxis(),
      series: <ChartSeries>[
        BarSeries<ChartData, String>(
          color: const Color(0xff747AF2),
          dataSource: barChartDataSales,
          name: "Sales",
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
        ),
        BarSeries<ChartData, String>(
          color: const Color(0xffEF376E),
          dataSource: barChartDataEnquiry,
          name: "Enquiry",
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
        ),
      ],
    );
  }
}

// LineChart.
class LineChartData extends StatefulWidget {
  const LineChartData({Key? key}) : super(key: key);

  @override
  State<LineChartData> createState() => _LineChartDataState();
}

class _LineChartDataState extends State<LineChartData> {
  List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 18),
    _SalesData('Mar', 32),
    _SalesData('Apr', 32),
    _SalesData('May', 40),
    _SalesData('Jun', 29),
  ];

  List<_SalesData> data2 = [
    _SalesData('Jan', 30),
    _SalesData('Feb', 8),
    _SalesData('Mar', 34),
    _SalesData('Apr', 42),
    _SalesData('May', 45),
    _SalesData('Jun', 39),
  ];

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <ChartSeries>[
        LineSeries<_SalesData, String>(
          dataSource: data,
          xValueMapper: (_SalesData sales, _) => sales.year,
          yValueMapper: (_SalesData sales, _) => sales.sales,
          name: 'Sales',
          dataLabelSettings: const DataLabelSettings(isVisible: true),
        ),
        LineSeries<_SalesData, String>(
          dataSource: data2,
          xValueMapper: (_SalesData sales, _) => sales.year,
          yValueMapper: (_SalesData sales, _) => sales.sales,
          name: 'Sales 2',
          dataLabelSettings: const DataLabelSettings(isVisible: true),
        ),
      ],
    );
  }
}

// PieChart.
class PieChartData extends StatefulWidget {
  final GlobalKey<_BarChartDataState> barChartKey;

  const PieChartData({Key? key, required this.barChartKey,}) : super(key: key);

  @override
  State<PieChartData> createState() => _PieChartDataState();
}

class _PieChartDataState extends State<PieChartData> {
  late TooltipBehavior _tooltipBehavior;

  final List<ChartData2> pieChartData = [
    ChartData2('David', 25, 10, 60, 30, const Color.fromRGBO(0, 37, 150, 190)),
    ChartData2('Steve', 38, 11, 50, 20, const Color.fromRGBO(147, 0, 119, 1)),
    ChartData2('Jack', 34, 15, 40, 25, const Color.fromRGBO(228, 0, 124, 1)),
    ChartData2('Krishna', 52, 28, 30, 20, const Color.fromRGBO(255, 189, 57, 1)),
  ];

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(
      color: Colors.grey.shade100,
      duration: 2,
      opacity: 1,
      enable: true,
      animationDuration: 1,
      builder: (dynamic data, dynamic point, dynamic series, int pointIndex, int seriesIndex) {
        final ChartData2 chartData = data as ChartData2;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 150,
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(chartData.x, style: const TextStyle(color: Colors.black)),
                Text('Targeted: ${chartData.targeted}L', style: const TextStyle(color: Colors.black)),
                Text('Achieved: ${chartData.achieved}L', style: const TextStyle(color: Colors.black)),
                Text('Enquiry: ${chartData.enquiry}', style: const TextStyle(color: Colors.blue)),
                Text('Sales: ${chartData.sales} Sales', style: const TextStyle(color: Colors.green)),
              ],
            ),
          ),
        );
      },
    );

    // print('--------in pie chart-----');
    // print(widget.barChartKey.currentState?.barChartDataSales); // Access the bar chart data
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      enableMultiSelection: true,
      legend: Legend(
        isVisible: true,
        overflowMode: LegendItemOverflowMode.scroll,
      ),
      tooltipBehavior: _tooltipBehavior,
      series: <CircularSeries>[
        DoughnutSeries<ChartData2, String>(
          onPointTap: (pointInteractionDetails) {
            final barChartState = widget.barChartKey.currentState;
            print('Bar Chart Sales Data:');
            print(barChartState?.barChartDataSales);
            print('Bar Chart Enquiry Data:');
            print(barChartState?.barChartDataEnquiry);
            if (barChartState != null) {

            }
          },

          enableTooltip: true,
          dataSource: pieChartData,
          pointColorMapper: (ChartData2 data, _) => data.color,
          xValueMapper: (ChartData2 data, _) => data.x,
          yValueMapper: (ChartData2 data, _) => data.enquiry,
          dataLabelSettings: DataLabelSettings(
            isVisible: true,
            builder: (data, point, series, pointIndex, seriesIndex) {
              return Text(
                "${data.x}",
                style: const TextStyle(color: Colors.white, fontSize: 12),
              );
            },
          ),
        ),
      ],
    );
  }
}


class _SalesData {
  _SalesData(this.year, this.sales);
  final String year;
  final int sales;
}
