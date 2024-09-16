import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';

class VideoCaptureScreen extends StatefulWidget {
  @override
  _VideoCaptureScreenState createState() => _VideoCaptureScreenState();
}

class _VideoCaptureScreenState extends State<VideoCaptureScreen> {
  CameraController? _controller;
  late List<CameraDescription> cameras;
  bool isRecording = false;
  CameraLensDirection currentDirection = CameraLensDirection.back;
  
  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  void _initializeCamera() async {
    cameras = await availableCameras();
    _controller = CameraController(
      cameras.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.back),
      ResolutionPreset.medium,
    );
    await _controller!.initialize();
    setState(() {});
  }

  void _toggleRecording() async {
    if (isRecording) {
      final video = await _controller!.stopVideoRecording();
      final path = await _saveVideoToDownloads(video);
      Navigator.pop(context, File(path));
    } else {
      await _controller!.startVideoRecording();
    }
    setState(() {
      isRecording = !isRecording;
    });
  }

  Future<String> _saveVideoToDownloads(XFile video) async {
    final directory = await getExternalStorageDirectory();
    final path = '${directory!.path}/${DateTime.now().millisecondsSinceEpoch}.mp4';
    await video.saveTo(path);
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Capture Video')),
      body: _controller != null && _controller!.value.isInitialized
          ? Column(
              children: [
                AspectRatio(
                  aspectRatio: _controller!.value.aspectRatio,
                  child: CameraPreview(_controller!),
                ),
                IconButton(
                  icon: Icon(isRecording ? Icons.stop : Icons.videocam),
                  onPressed: _toggleRecording,
                ),
              ],
            )
          : Center(child: CircularProgressIndicator()),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
