import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const HomeApp());
}

class HomeApp extends StatefulWidget {
  const HomeApp({super.key});

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Home());
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final Completer<GoogleMapController> _controller = Completer();

  // 現在位置を格納する変数
  LatLng? _currentPosition;

  // 初期カメラ位置を動的に設定するための変数
  CameraPosition? _initialCameraPosition;

  double _direction = 0;

  // 位置情報を記録するための変数
  final bool _isTracking = false;

  // ルートを保存するリスト
  final List<LatLng> _routePoints = [];

  @override
  void initState() {
    super.initState();
    _getCurrentPosition(); // 現在位置の取得
    FlutterCompass.events!.listen((event) {
      if (event.heading != null) {
        setState(() {
          _direction = event.heading!; // !でnullでないことを明示
        });
      } else {
        // 方位を取得できなかった場合の処理
        setState(() {
          _direction = event.heading ?? 0.0;
        });
        debugPrint('方位を取得できませんでした');
      }
    });
  }

  // 現在位置を取得する非同期メソッド
  Future<void> _getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 位置情報サービスが有効か確認
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      debugPrint('位置情報サービスが無効です。');
      return;
    }

    // 位置情報の権限を確認
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        debugPrint('位置情報の権限が拒否されました。');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      debugPrint('位置情報の権限が永続的に拒否されています。');
      return;
    }

    // 設定オブジェクトの作成
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high, // 高精度の位置情報
      distanceFilter: 1, // 更新する際の移動距離（メートル）
    );

    // // 現在位置の取得
    // Position position = await Geolocator.getCurrentPosition(
    //   locationSettings: locationSettings,
    // );

    // 位置情報の更新を監視
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      // 状態変化を追跡するため
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        if (_isTracking) {
          _routePoints.add(_currentPosition!);
        }
        // 現在位置を中心に初期カメラ位置を設定
        _initialCameraPosition = CameraPosition(
          target: _currentPosition!,
          zoom: 16.0, // ズームレベルは任意で調整
        );

        // マップが初期化されていればカメラを移動
        if (_controller.isCompleted) {
          _moveCamera();
        }
      });
    });
  }

  Future<void> _moveCamera() async {
    final GoogleMapController mapController = await _controller.future;
    mapController.animateCamera(CameraUpdate.newLatLng(_currentPosition!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('google map'),
        automaticallyImplyLeading: false,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        actions: <Widget>[
          Transform.rotate(
            angle: _direction * (pi / 180),
            child: SizedBox(
              width: 47,
              height: 47,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xD7FFFFFF),
                ),
                child: const Icon(Icons.assistant_navigation),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          _initialCameraPosition == null
              ? const Center(
                  child: CircularProgressIndicator(),
                ) // 初期位置が取得されるまでローディング表示
              : GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: _initialCameraPosition!,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },

                  scrollGesturesEnabled: true,
                  // ユーザーによるスクロールの禁止
                  myLocationEnabled: true,
                  // 現在位置の表示を有効にする
                  myLocationButtonEnabled: false,
                  // 現在位置に移動ボタンを無効にする
                  zoomControlsEnabled: true,
                  //地図の右下などに表示される「+」と「-」のボタンによる拡大縮小機能の有効/無効を切り替える
                  zoomGesturesEnabled: true,
                  //ピンチイン/アウトなどのジェスチャーによる拡大縮小機能の有効/無効を切り替えます。
                ),

          Positioned(
            top: 100,
            right: 0,
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0x614285F4),
                  ),
                ),
                const SizedBox(
                  width: 47,
                  height: 5,
                ),
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0x614285F4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        width: 70,
        height: 70,
        color: Colors.transparent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
