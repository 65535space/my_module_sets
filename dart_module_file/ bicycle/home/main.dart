import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'subScreen.dart'; //名前を変える

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
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
      distanceFilter: 10, // 更新する際の移動距離（メートル）
    );

    // 現在位置の取得
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: locationSettings,
    );

    // 状態変化を追跡するため
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      // 現在位置を中心に初期カメラ位置を設定
      _initialCameraPosition = CameraPosition(
        target: _currentPosition!,
        zoom: 16.0, // ズームレベルは任意で調整
      );
    });

    // マップコントローラーが準備できていればカメラを移動
    if (_controller.isCompleted) {
      final GoogleMapController mapController = await _controller.future;
      mapController.animateCamera(CameraUpdate.newLatLng(_currentPosition!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('!!レベルのデータが入ります'),
        centerTitle: false,
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
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          _initialCameraPosition == null
              ? const Center(
                  child: CircularProgressIndicator()) // 初期位置が取得されるまでローディング表示
              : GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: _initialCameraPosition!,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  scrollGesturesEnabled: false,
                  // ユーザーによるスクロールの禁止
                  myLocationEnabled: true,
                  // 現在位置の表示を有効にする
                  myLocationButtonEnabled: false,
                  // 現在位置に移動ボタンを無効にする
                  zoomControlsEnabled: true,
                  //地図の右下などに表示される「+」と「-」のボタンによる拡大縮小機能の有効/無効を切り替える
                  zoomGesturesEnabled: false,
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
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => (const SubScreen()),
                        ),
                      );
                    },
                    icon: const Icon(Icons.travel_explore),
                    iconSize: 30,
                    splashColor: const Color(0x614285F4),
                  ),
                ),
                // SizedBoxを使った場合
                // SizedBox(
                //   width: 47,
                //   height: 47,
                //   child: Container(
                //       decoration: const BoxDecoration(
                //         shape: BoxShape.circle,
                //         color: Color(0x614285F4),
                //       ),
                //       child: const IconButton()),
                // ),
                const SizedBox(
                  width: 47,
                  height: 5,
                ),

                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0x614285F4),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => (const SubScreen()),
                        ),
                      );
                    },
                    icon: const Icon(Icons.business_center),
                    iconSize: 30,
                    splashColor: const Color(0x614285F4),
                  ),
                )

                // SizedBox(
                //   width: 47,
                //   height: 47,
                //   child: Container(
                //       decoration: const BoxDecoration(
                //         shape: BoxShape.circle,
                //         color: Color(0x614285F4),
                //       ),
                //       child: const Icon(Icons.business_center)),
                // ),
              ],
            ),
          ),

          //以下のボタンはfloatingactionbuttonプロパティに移動した
          // Positioned(
          //   bottom: 5,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       IconButton(
          //         onPressed: () {},
          //         icon: const Icon(Icons.play_circle_outline),
          //       ),
          //     ],
          //   ),
          // )
        ],
      ),
      floatingActionButton: Container(
        width: 70,
        height: 70,
        color: Colors.transparent,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => (const SubScreen()),
              ),
            );
          },
          backgroundColor: const Color(0x614285F4),
          splashColor: const Color(0x614285F4),
          shape: const CircleBorder(),
          elevation: 0,
          child: const Icon(
            Icons.play_circle_outline,
            size: 60,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
