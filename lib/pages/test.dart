import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;
// import 'package:firebase_admob/firebase_admob.dart';
// import './boundary_box.dart';

class FaceDetectionFromLiveCamera extends StatefulWidget {
  @override
  _FaceDetectionFromLiveCameraState createState() =>
      _FaceDetectionFromLiveCameraState();
}

class _FaceDetectionFromLiveCameraState
    extends State<FaceDetectionFromLiveCamera> {
  bool detected = false;
  List<CameraDescription> _availableCameras;
  CameraController cameraController;
  bool isDetecting = false;
  List<dynamic> _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  bool front = true;
  // InterstitialAd interstitialAd;
  @override
  void initState() {
    super.initState();
    // FirebaseAdMob.instance.initialize(appId: 'ca-app-pub-8295782880270632~3798840407');
    // interstitialAd = myInterstitial()..load()..show();
    loadModel();
    _getAvailableCameras();
  }

  @override
  void dispose() {
    // cameraController.description.
    cameraController?.dispose();
    // interstitialAd.dispose();
    super.dispose();
  }
// static MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
//   keywords: <String>['apps', 'games', 'news'], // or MobileAdGender.female, MobileAdGender.unknown
//   testDevices: <String>[], // Android emulators are considered test devices
// );

// InterstitialAd myInterstitial() {
//     // return InterstitialAd(
//     //   adUnitId: 'ca-app-pub-8295782880270632/9789533681',
//     //   targetingInfo: targetingInfo,
//     //   listener: (MobileAdEvent event) {
//     //     if (event == MobileAdEvent.failedToLoad) {
//     //       interstitialAd..load();
//     //     } else if (event == MobileAdEvent.closed) {
//     //       interstitialAd = myInterstitial()..load();
//     //     }
//     //   },
//     // );
//   }

  Future<void> _getAvailableCameras() async {
    WidgetsFlutterBinding.ensureInitialized();
    _availableCameras = await availableCameras();
    _initializeCamera(_availableCameras[1]);
  }

  void loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
  }

  Future<void> _initializeCamera(CameraDescription description) async {
    cameraController = CameraController(description, ResolutionPreset.medium);
    try {
      await cameraController.initialize().then(
        (_) {
          if (!mounted) {
            return;
          }
          cameraController.startImageStream(
            // cameraController.st
            (CameraImage img) {
              if (!isDetecting) {
                isDetecting = true;
                Tflite.runModelOnFrame(
                  bytesList: img.planes.map(
                    (plane) {
                      return plane.bytes;
                    },
                  ).toList(),
                  threshold: 0.5,
                  rotation: 0,
                  imageHeight: img.height,
                  imageWidth: img.width,
                  numResults: 1,
                ).then(
                  (recognitions) {
                    if (recognitions.any((element) =>
                        element["label"] == "1 Masked" &&
                        (element["confidence"] * 100) > 95)) {
                      detected = true;
                      setState(() {});
                      cameraController.stopImageStream();
                    }
                    setRecognitions(recognitions, img.height, img.width);
                    isDetecting = false;
                  },
                );
              }
            },
          );
        },
      );
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  void _toggleCameraLens() {
    // get current lens direction (front / rear)
    final lensDirection = cameraController.description.lensDirection;
    CameraDescription newDescription;
    if (lensDirection == CameraLensDirection.front) {
      newDescription = _availableCameras.firstWhere((description) =>
          description.lensDirection == CameraLensDirection.back);
    } else {
      newDescription = _availableCameras.firstWhere((description) =>
          description.lensDirection == CameraLensDirection.front);
    }

    if (newDescription != null) {
      _initializeCamera(newDescription);
    } else {
      print('Asked camera not available');
    }
  }

  void setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return detected
        ? SafeArea(
            child: AlertDialog(
              title: Text('AlertDialog Title'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Face Detector'),
                    Text('Checking For Mask'),
                  ],
                ),
              ),
              actions: <Widget>[
                ElevatedButton(
                  child: Text('Approve'),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.popAndPushNamed(context, '/CardsList');
                    print("\n\n\n\n\n\n\n\ tadaaa");
                    // Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          )
        : Container(
            constraints: const BoxConstraints.expand(),
            child: cameraController == null
                ? Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  )
                : Scaffold(
                    floatingActionButton: FloatingActionButton(
                      onPressed: () {
                        front == true ? front = false : front = true;
                        _toggleCameraLens();
                      },
                      child: Icon(front == true
                          ? Icons.camera_rear
                          : Icons.camera_front),
                    ),
                    // backgroundColor: Colors.black,
                    appBar: AppBar(
                      title: Text("Mask detector"),
                      centerTitle: true,
                      // backgroundColor: Colors.redAccent,
                    ),
                    body: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // aspectRatio: cameraController.value.aspectRatio,
                          height: 200,
                          width: 300,
                          child: CameraPreview(cameraController),
                        ),
                        BoundaryBox(
                            _recognitions == null ? [] : _recognitions,
                            math.max(_imageHeight, _imageWidth),
                            math.min(_imageHeight, _imageWidth),
                            screen.height,
                            screen.width),
                      ],
                    ),
                  ),
          );
  }
}

// import 'package:flutter/material.dart';

class BoundaryBox extends StatelessWidget {
  final List<dynamic> results;
  final int previewH;
  final int previewW;
  final double screenH;
  final double screenW;

  BoundaryBox(
      this.results, this.previewH, this.previewW, this.screenH, this.screenW);

  @override
  Widget build(BuildContext context) {
    List<Widget> _renderStrings() {
      return results.map((re) {
        return Column(
          children: <Widget>[
            Container(
              // left: (screenW / 4),
              // bottom: -(screenH - 80),
              // width: screenW,
              // height: screenH,
              child: Text(
                "${re["label"] == '1 Masked' ? "Mask detected" : "Mask not detected"} ${(re["confidence"] * 100).toStringAsFixed(0)}% ${re["label"]}",
                style: TextStyle(
                  backgroundColor: Colors.white,
                  color:
                      re["label"] == '0 with_mask' ? Colors.green : Colors.red,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              // left: 30,
              // top: 30,
              // width: screenW,
              // height: screenH,
              child: Text(
                "Detection only on veritcal camera feed",
                style: TextStyle(
                  backgroundColor: Colors.black,
                  color: Colors.purple,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        );
      }).toList();
    }

    return Stack(
      children: _renderStrings(),
    );
  }
}
