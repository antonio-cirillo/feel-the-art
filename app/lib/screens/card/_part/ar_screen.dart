import 'dart:core';
import 'package:image/image.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart';

class ARSreen extends StatefulWidget {
  final String image;
  const ARSreen({Key? key, required this.image}) : super(key: key);

  @override
  _ARSreenState createState() => _ARSreenState();
}

class _ARSreenState extends State<ARSreen> {
  late ArCoreController arCoreController;

  @override
  Widget build(BuildContext context) {
    return ArCoreView(
      onArCoreViewCreated: _onArCoreViewCreated,
      enablePlaneRenderer: true,
      enableTapRecognizer: true,
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    _addImage();
  }

  void _addImage() async {

    Uint8List imageBytes = await getAssetImage(widget.image);
    List dimensions = getImageDimensions(imageBytes);

    final image = ArCoreImage(
        bytes : imageBytes,
        width: dimensions.first,
        height: dimensions.last
    );

    arCoreController.addArCoreNode(ArCoreNode(
      image: image,
      position: Vector3(0, 0, -1.3),
    ));
  }

  Future<Uint8List> getAssetImage(String path) async {
    final ByteData byteData = await rootBundle.load(path);
    return byteData.buffer.asUint8List();
  }

  List getImageDimensions(Uint8List list){
    final image = decodeImage(list);
    if(image!=null) {
      return [image.width, image.height];
    }
    return [50,100];
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}

