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
    final String dirPath = '${externalDir!.path}/Download'; 
    await Directory(dirPath).create(recursive: true); 
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
    
    // Get the file path in the Downloads folder
    final Directory? downloadsDir = await getExternalStorageDirectory();
    final String downloadsPath = '${downloadsDir!.path}/Download'; // Public Downloads folder path
    final String newFilePath = '$downloadsPath/${DateTime.now().millisecondsSinceEpoch}.mp4';
    
    // Create the Downloads folder if it doesn't exist
    await Directory(downloadsPath).create(recursive: true);

    // Move the captured video file to the Downloads folder
    final File savedVideo = File(videoFile.path);
    await savedVideo.copy(newFilePath);
    
    setState(() {
      _isRecording = false;
      _stopTimer();
    });

    // Notify the user that the video has been saved
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Video saved to Downloads folder')),
    );
  }
}


 void _switchCamera() {
  if (_cameras != null && _cameras!.isNotEmpty) {
    CameraDescription newCamera;
    
    
    if (_controller?.description.lensDirection == CameraLensDirection.back) {
      newCamera = _cameras!.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => _cameras!.first, 
      );
    } else {
      newCamera = _cameras!.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
        orElse: () => _cameras!.first, 
      );
    }

    if (_controller != null) {
      _controller!.dispose();
    }
    
    
    _controller = CameraController(newCamera, ResolutionPreset.high);
    _controller?.initialize().then((_) {
      setState(() {});
    });
  }
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
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
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
      appBar: AppBar(title: const Text('Capture Video')),
      body: _controller == null || !_controller!.value.isInitialized
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: CameraPreview(_controller!),
                ),
                Text(
                  _isRecording ? 'Recording: ${_recordTime}s' : '',
                  style: const TextStyle(fontSize: 18, color: Colors.red),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(_controller!.value.flashMode == FlashMode.off ? Icons.flash_off : Icons.flash_on),
                      onPressed: _toggleFlash,
                    ),
                    IconButton(
                      icon: const Icon(Icons.camera_front),
                      onPressed: _switchCamera,
                    ),
                    IconButton(
                      icon: const Icon(Icons.zoom_out),
                      onPressed: () => _setZoomLevel(0.5), 
                    ),
                    IconButton(
                      icon: const Icon(Icons.zoom_in),
                      onPressed: () => _setZoomLevel(1.0), 
                    ),
                    IconButton(
                      icon: const Icon(Icons.zoom_out_map),
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
