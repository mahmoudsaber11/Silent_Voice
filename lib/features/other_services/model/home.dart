import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String answer = "";
  CameraController? cameraController;
  CameraImage? cameraImage;
  List<String> word = [];

//  change the model name in main file at line number 35,36
  loadmodel() async {
    Tflite.loadModel(
      model: "assets1/model_unquant.tflite",
      labels: "assets1/labels.txt",
    );
  }

  initCamera() {
    // cameraController = CameraController(cameras![0], ResolutionPreset.medium);

    // OR
    cameraController = CameraController(
        const CameraDescription(
          name: '0', // 0 for back camera and 1 for front camera
          lensDirection: CameraLensDirection.back,
          sensorOrientation: 0,
        ),
        ResolutionPreset.medium);

    cameraController!.initialize().then(
      (value) {
        if (!mounted) {
          return;
        }
        setState(
          () {
            cameraController!.startImageStream(
              (image) => {
                if (true)
                  {
                    setState(
                      () {
                        cameraImage = image;
                      },
                    ),
                    //  cameraImage = image,

                    applymodelonimages(),
                  }
              },
            );
          },
        );
      },
    );
  }

  applymodelonimages() async {
    try {
      if (cameraImage != null) {
        var predictions = await Tflite.runModelOnFrame(
            bytesList: cameraImage!.planes.map(
              (plane) {
                return plane.bytes;
              },
            ).toList(),
            imageHeight: cameraImage!.height,
            imageWidth: cameraImage!.width,
            imageMean: 127.5,
            imageStd: 127.5,
            rotation: 90,
            numResults: 3,
            threshold: 0.1,
            asynch: true);

        answer = '';

        for (var prediction in predictions!) {
          answer +=
              // ignore: prefer_interpolation_to_compose_strings
              prediction['label'].toString().substring(0, 1).toUpperCase() +
                  prediction['label'].toString().substring(1) +
                  " " +
                  (prediction['confidence'] as double).toStringAsFixed(3) +
                  '\n';
        }

        setState(
          () {
            answer = answer;
          },
        );

        if (predictions.isNotEmpty) {
          setState(() {
            final label = predictions[0]['label'];
            word.add(label);
            final wordLetters = word
                .where((label) => label != "NOTHING")
                .map((label) => label.substring(2))
                .join();

            // ignore: avoid_print
            print(wordLetters);
          });
        }
      }
    } catch (e) {
      //  print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    initCamera();
    loadmodel();
  }

  @override
  void dispose() async {
    super.dispose();

    await Tflite.close();
    cameraController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: cameraImage != null
            ? Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.blue,
                child: Stack(
                  children: [
                    Positioned(
                      child: Center(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: AspectRatio(
                            aspectRatio: cameraController!.value.aspectRatio,
                            child: CameraPreview(
                              cameraController!,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          color: Colors.black87,
                          child: Center(
                            child: Text(
                              answer,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            : Container(),
      ),
    );
  }
}
