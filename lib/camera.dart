import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Camera extends StatefulWidget {
  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  File _image;
  String _imagepath;

  void pickImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void takePhoto() async {
    var imagem = await ImagePicker.pickImage(source: ImageSource.camera);

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String bgPath = appDocDir.uri.resolve("background.jpg").path;
    // ignore: unused_local_variable
    File bgFile = await imagem.copy(bgPath);

    setState(() {
      _image = imagem;
    });
  }

  void saveImage(path) async {
    SharedPreferences saveimage = await SharedPreferences.getInstance();
    saveimage.setString("imagepath", path);
  }

  void loadImage() async {
    SharedPreferences saveimage = await SharedPreferences.getInstance();
    setState(() {
      _imagepath = saveimage.getString("imagepath");
    });
  }

  @override
  // ignore: must_call_super
  void initState() {
    loadImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Camera"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            _imagepath != null
                ? CircleAvatar(
                    backgroundImage: FileImage(File(_imagepath)), radius: 80)
                : CircleAvatar(
                    radius: 80,
                    backgroundImage: _image != null ? FileImage(_image) : null),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              // ignore: deprecated_member_use
              child: RaisedButton(
                  child: Text("Pick Image"),
                  onPressed: () {
                    pickImage();
                  }),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              // ignore: deprecated_member_use
              child: RaisedButton(
                  child: Text("Tirar foto"),
                  onPressed: () {
                    takePhoto();
                  }),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
                padding: const EdgeInsets.all(8),
                // ignore: deprecated_member_use
                child: RaisedButton(
                    child: Text("Save"),
                    onPressed: () {
                      saveImage(_image.path);
                      print("Sucesso");
                    })),
          ],
        ),
      ),
    );
  }
}
