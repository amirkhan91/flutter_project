import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class VideoCaptureScreen extends StatefulWidget {
  @override
  _VideoCaptureScreenState createState() => _VideoCaptureScreenState();
}

class _VideoCaptureScreenState extends State<VideoCaptureScreen> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  bool _isRecording = false;
  double _zoomLevel = 1.0;
  Timer? _timer;
  int _recordTime = 0;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    _controller = CameraController(_cameras![0], ResolutionPreset.high);
    await _controller?.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    _controller?.dispose();
    _timer?.cancel();
    super.dispose();
  }

  Future<String> _getVideoFilePath() async {
    final Directory? externalDir = await getExternalStorageDirectory();
    final String dirPath = '${externalDir!.path}/Download'; // Save to Downloads folder
    await Directory(dirPath).create(recursive: true); // Ensure the directory exists
    return '$dirPath/${DateTime.now().millisecondsSinceEpoch}.mp4';
  }

  Future<void> _startVideoRecording() async {
    if (_controller != null && !_isRecording) {
      final String filePath = await _getVideoFilePath();
      await _controller?.startVideoRecording();
      setState(() {
        _isRecording = true;
        _startTimer();
      });
    }
  }

  Future<void> _stopVideoRecording() async {
    if (_controller != null && _isRecording) {
      final XFile videoFile = await _controller!.stopVideoRecording();
      final String filePath = await _getVideoFilePath();
      await videoFile.saveTo(filePath); // Save video to the specified file path
      setState(() {
        _isRecording = false;
        _stopTimer();
      });
    }
  }

  void _switchCamera() {
    setState(() {
      final CameraDescription selectedCamera = _cameras!.firstWhere(
        (camera) => camera != _controller?.description,
      );
      _controller = CameraController(selectedCamera, ResolutionPreset.high);
      _controller?.initialize();
    });
  }

  void _toggleFlash() {
    if (_controller != null) {
      _controller!.setFlashMode(_controller!.value.flashMode == FlashMode.off ? FlashMode.torch : FlashMode.off);
    }
  }

  void _setZoomLevel(double zoom) {
    if (_controller != null) {
      _controller!.setZoomLevel(zoom);
      setState(() {
        _zoomLevel = zoom;
      });
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        _recordTime++;
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() {
      _recordTime = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Capture Video')),
      body: _controller == null || !_controller!.value.isInitialized
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: CameraPreview(_controller!),
                ),
                Text(
                  _isRecording ? 'Recording: ${_recordTime}s' : '',
                  style: TextStyle(fontSize: 18, color: Colors.red),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(_controller!.value.flashMode == FlashMode.off ? Icons.flash_off : Icons.flash_on),
                      onPressed: _toggleFlash,
                    ),
                    IconButton(
                      icon: Icon(Icons.camera_front),
                      onPressed: _switchCamera,
                    ),
                    IconButton(
                      icon: Icon(Icons.zoom_out),
                      onPressed: () => _setZoomLevel(0.5),
                    ),
                    IconButton(
                      icon: Icon(Icons.zoom_in),
                      onPressed: () => _setZoomLevel(1.0),
                    ),
                    IconButton(
                      icon: Icon(Icons.zoom_out_map),
                      onPressed: () => _setZoomLevel(2.0),
                    ),
                    FloatingActionButton(
                      onPressed: _isRecording ? _stopVideoRecording : _startVideoRecording,
                      child: Icon(_isRecording ? Icons.stop : Icons.videocam),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
