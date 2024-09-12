import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:async';
import 'dart:io';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(home: BrakeExperiment()));
}

class BrakeExperiment extends StatefulWidget {
  const BrakeExperiment({super.key});

  @override
  BrakeExperimentState createState() => BrakeExperimentState();
}

class BrakeExperimentState extends State<BrakeExperiment> {
  bool _isRecording = false;
  final List<FlSpot> _velocitySpots = [];
  final List<FlSpot> _accelerationSpots = [];
  double _velocity = 0.0;
  double _acceleration = 0.0;
  StreamSubscription<AccelerometerEvent>? _accelerometerSubscription;
  final double _deltaTime = 0.1; // サンプリング間隔を0.1秒に変更
  double _elapsedTime = 0.0;
  final double _smoothingFactor = 0.1; // 加速度のスムージング係数
  final double _frictionCoefficient = 0.02; // 摩擦係数（環境に応じて調整が必要）

  @override
  void initState() {
    super.initState();
    _accelerometerSubscription = accelerometerEventStream().listen((AccelerometerEvent event) {
      if (_isRecording) {
        _processAccelerometerEvent(event);
      }
    });
  }

  @override
  void dispose() {
    _accelerometerSubscription?.cancel();
    super.dispose();
  }

  void _processAccelerometerEvent(AccelerometerEvent event) {
    setState(() {
      // 加速度のスムージング
      _acceleration = _acceleration * (1 - _smoothingFactor) + event.z * _smoothingFactor;

      // 速度の更新（摩擦を考慮）
      double frictionForce = _frictionCoefficient * _velocity.abs();
      double netAcceleration = _acceleration - (frictionForce * _velocity.sign);
      _velocity += netAcceleration * _deltaTime;

      // 速度が非常に小さい場合は0とする
      if (_velocity.abs() < 0.01) {
        _velocity = 0;
      }

      _elapsedTime += _deltaTime;
      _velocitySpots.add(FlSpot(_elapsedTime, _velocity));
      _accelerationSpots.add(FlSpot(_elapsedTime, _acceleration));

      // データポイントが多すぎる場合、古いものを削除
      if (_velocitySpots.length > 100) {
        _velocitySpots.removeAt(0);
        _accelerationSpots.removeAt(0);
      }
    });
  }

  void _startRecording() {
    setState(() {
      _isRecording = true;
      _velocitySpots.clear();
      _accelerationSpots.clear();
      _elapsedTime = 0.0;
      _velocity = 0.0;
      _acceleration = 0.0;
    });
  }

  void _stopRecording() {
    setState(() {
      _isRecording = false;
    });
    _saveDataToCsv(context);
  }

  Future<void> _saveDataToCsv(BuildContext context) async {
    List<List<dynamic>> rows = [
      ['Time', 'Velocity', 'Acceleration']
    ];
    for (int i = 0; i < _velocitySpots.length; i++) {
      rows.add([
        _velocitySpots[i].x,
        _velocitySpots[i].y,
        _accelerationSpots[i].y
      ]);
    }

    String csv = const ListToCsvConverter().convert(rows);
    final directory = await getExternalStorageDirectory();
    final path = '${directory?.path}/brake_experiment_data.csv';
    final File file = File(path);
    await file.writeAsString(csv);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('データを保存しました: $path'),
          action: SnackBarAction(
            label: '共有',
            onPressed: () => _shareCSV(path),
          ),
        ),
      );
    }
  }
  Future<void> _shareCSV(String filePath) async {
    final file = XFile(filePath);
    await Share.shareXFiles([file], text: 'ブレーキ実験データ');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ブレーキ実験'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '現在の速度: ${_velocity.toStringAsFixed(2)} m/s\n'
                    '現在の加速度: ${_acceleration.toStringAsFixed(2)} m/s²',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 300,
              child: _velocitySpots.isNotEmpty
                  ? LineChart(
                LineChartData(
                  minY: -10,
                  maxY: 10,
                  titlesData: const FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true, reservedSize: 30),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                    ),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  gridData: const FlGridData(show: true),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: _velocitySpots,
                      isCurved: true,
                      color: Colors.blue,
                      dotData: const FlDotData(show: false),
                    ),
                    LineChartBarData(
                      spots: _accelerationSpots,
                      isCurved: true,
                      color: Colors.red,
                      dotData: const FlDotData(show: false),
                    ),
                  ],
                ),
              )
                  : const Center(child: Text('データを記録中...')),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _isRecording ? null : _startRecording,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    ),
                    child: const Text('スタート'),
                  ),
                  ElevatedButton(
                    onPressed: _isRecording ? _stopRecording : null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15), backgroundColor: Colors.red,
                    ),
                    child: const Text('ストップ'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}