import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'item_box.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(home: OverlookSign()));
}

class OverlookSign extends StatefulWidget {
  const OverlookSign({super.key});

  @override
  OverlookSignState createState() => OverlookSignState();
}

class OverlookSignState extends State<OverlookSign> {
  bool isVisible = true;
  late GoogleMapController controller;
  late LatLngBounds bounds; //全ての座標を含む変数

  List<LatLng> markerPositions = [
    // 本来はここに標識の座標を指定
    const LatLng(35.681236, 139.767125), // 東京駅
    const LatLng(34.693738, 135.502165), // 大阪駅
  ];

  @override
  void initState() {
    super.initState();
    bounds = _createBounds(markerPositions);
  }

  LatLngBounds _createBounds(List<LatLng> positions) {
    double south =
        positions.map((p) => p.latitude).reduce((a, b) => a < b ? a : b);
    double west =
        positions.map((p) => p.longitude).reduce((a, b) => a < b ? a : b);
    double north =
        positions.map((p) => p.latitude).reduce((a, b) => a > b ? a : b);
    double east =
        positions.map((p) => p.longitude).reduce((a, b) => a > b ? a : b);

    return LatLngBounds(
      southwest: LatLng(south, west),
      northeast: LatLng(north, east),
    );
  }

  void _onMapCreated(GoogleMapController mapController) {
    controller = mapController;
    _moveCameraToBounds();
  }

  void _moveCameraToBounds() {
    controller
        .animateCamera(CameraUpdate.newLatLngBounds(bounds, 50)); // 50はパディング
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Google Maps Example')),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: markerPositions.first,
              zoom: 5,
            ),
            markers: markerPositions
                .map((position) => Marker(
                    markerId: MarkerId(position.toString()),
                    position: position))
                .toSet(),
          ),
          Positioned(
            top: 100,
            right: 0,
            child: Column(
              children: [
                const SizedBox(
                  width: 47,
                  height: 35,
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
                          builder: (context) => (ItemBox(isVisible)),
                        ),
                      );
                    },
                    icon: const Icon(Icons.business_center),
                    iconSize: 30,
                    splashColor: const Color(0x614285F4),
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
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => (ItemBox(isVisible)), // 本来はHome()に遷移する
              ),
            );
          },
          backgroundColor: const Color(0x614285F4),
          splashColor: const Color(0x614285F4),
          shape: const CircleBorder(),
          elevation: 0,
          child: const Icon(
            Icons.cancel,
            size: 60,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
