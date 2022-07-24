import 'dart:io';

import 'package:amval/src/config/storage/constants.dart';
import 'package:amval/src/presentation/logic/cubit/instrument/set_capture_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';


class Camera extends StatefulWidget {
  final CameraDescription camera;
  const Camera({required this.camera ,Key? key}) : super(key: key);

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {

  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.camera, ResolutionPreset.veryHigh);
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          FutureBuilder(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done){
                  return CameraPreview(_controller);
                }
                return const Center(child: CircularProgressIndicator(),);
              }
          ),
          Positioned(
              right: 0,
              left: 0,
              bottom: 10,
              height: 90.0,
              child: GestureDetector(
                onTap: () async {
                  try{
                    await _initializeControllerFuture;
                    final image = await _controller.takePicture();
                    capturePath = image.path;
                    await Navigator.pushNamed(context, "/display_screen");
                  }catch(e){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text("خطا در عکس برداری"),duration: durationForErrorMessage));
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  width: 80,
                  height: 80,
                  decoration:  const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle
                  ),
                  child: const Icon(Icons.camera, size: 55,),
                ),
                ),
              )
        ],
      ),

    );
  }


}



/// display capture
class DisplayPictureScreen extends StatelessWidget {

  const DisplayPictureScreen({Key? key})  : super(key: key);

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Image.file(File(capturePath)),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.save),
                label: "ذخیره",
                backgroundColor: Colors.blue
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.camera_alt),
                label: "دوربین",
                backgroundColor: Colors.blue
            ),
          ],
          onTap: (value){
            if (value == 0){
              BlocProvider.of<SetCaptureCubit>(context)
                  .setCapture(capturePath);
              capturePath = capturePath;
              int count = 0;
              Navigator.of(context).popUntil((context) => count++ >= 2);
            }
            else {
              Navigator.pop(context);
            }
          }
      ),
    );
    
  }

  
}