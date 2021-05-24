import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:tflite/tflite.dart';
// import 'package:url_launcher/url_launcher.dart';

class FaceDetection extends StatefulWidget {
  @override
  _FaceDetectionState createState() => _FaceDetectionState();
}

class _FaceDetectionState extends State<FaceDetection> {
  List _outputs;
  File _image;
  bool _loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
      numThreads: 1,
    );
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        imageMean: 0.0,
        imageStd: 255.0,
        numResults: 2,
        threshold: 0.2,
        asynch: true);
    setState(() {
      _loading = false;
      _outputs = output;
    });
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  pickImage() async {
    final picker = ImagePicker();

    var image = await picker.getImage(source: ImageSource.camera);
    // var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      _loading = true;
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clear Mask Test'),
        backgroundColor: Colors.blue[800],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _loading
                  ? Container(
                      height: 200,
                      width: 200,
                    )
                  : Container(
                      margin: EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _image == null
                              ? Container()
                              : Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
                                  child: Image.file(
                                    _image,
                                  ),
                                ),
                          SizedBox(
                            height: 20,
                          ),
                          _image == null
                              ? Container()
                              : _outputs != null
                                  ? Text(
                                      _outputs[0]["label"],
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    )
                                  : Container(child: Text("")),
                          SizedBox(height: 10),
                          Text(
                            'Pick an image to test',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              FloatingActionButton(
                tooltip: 'Pick Image',
                onPressed: pickImage,
                child: Icon(
                  Icons.add_a_photo,
                  size: 20,
                  color: Colors.white,
                ),
                backgroundColor: Colors.amber,
              ),
              Divider(),
              _outputs != null
                  ? _outputs[0]["label"] == "1 Masked"
                      ? Container(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/CardsList');
                              // launch(
                              // 'https://wa.me/918240375474?text=Hi, could you advise me with ${_outputs[0]["label"]}');
                            },
                            child: Text('Proceed to Banking'),
                          ),
                        )
                      : Container(
                          child: Text("Please Wear a Mask"),
                        )
                  : Text("Scan Your Face")
            ],
          ),
        ),
      ),
    );
  }
}
