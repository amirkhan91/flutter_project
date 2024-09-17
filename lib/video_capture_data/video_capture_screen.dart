// import 'dart:async';
// import 'dart:io';
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';

// class VideoCaptureScreen extends StatefulWidget {
//   @override
//   _VideoCaptureScreenState createState() => _VideoCaptureScreenState();
// }

// class _VideoCaptureScreenState extends State<VideoCaptureScreen> {
//   CameraController? _controller;
//   List<CameraDescription>? _cameras;
//   bool _isRecording = false;
//   double _zoomLevel = 1.0;
//   Timer? _timer;
//   int _recordTime = 0;

//   @override
//   void initState() {
//     super.initState();
//     _initializeCamera();
//   }

//   Future<void> _initializeCamera() async {
//     _cameras = await availableCameras();
//     _controller = CameraController(_cameras![0], ResolutionPreset.high);
//     await _controller?.initialize();
//     setState(() {});
//   }

//   @override
//   void dispose() {
//     _controller?.dispose();
//     _timer?.cancel();
//     super.dispose();
//   }

//   Future<String> _getVideoFilePath() async {
//     final Directory? externalDir = await getExternalStorageDirectory();
//     final String dirPath = '${externalDir!.path}/Download'; // Save to Downloads folder
//     await Directory(dirPath).create(recursive: true); // Ensure the directory exists
//     return '$dirPath/${DateTime.now().millisecondsSinceEpoch}.mp4';
//   }

//   Future<void> _startVideoRecording() async {
//     if (_controller != null && !_isRecording) {
//       final String filePath = await _getVideoFilePath();
//       await _controller?.startVideoRecording();
//       setState(() {
//         _isRecording = true;
//         _startTimer();
//       });
//     }
//   }

//   Future<void> _stopVideoRecording() async {
//     if (_controller != null && _isRecording) {
//       final XFile videoFile = await _controller!.stopVideoRecording();
//       final String filePath = await _getVideoFilePath();
//       await videoFile.saveTo(filePath); // Save video to the specified file path
//       setState(() {
//         _isRecording = false;
//         _stopTimer();
//       });
//     }
//   }

//   void _switchCamera() {
//     setState(() {
//       final CameraDescription selectedCamera = _cameras!.firstWhere(
//         (camera) => camera != _controller?.description,
//       );
//       _controller = CameraController(selectedCamera, ResolutionPreset.high);
//       _controller?.initialize();
//     });
//   }

//   void _toggleFlash() {
//     if (_controller != null) {
//       _controller!.setFlashMode(_controller!.value.flashMode == FlashMode.off ? FlashMode.torch : FlashMode.off);
//     }
//   }

//   void _setZoomLevel(double zoom) {
//     if (_controller != null) {
//       _controller!.setZoomLevel(zoom);
//       setState(() {
//         _zoomLevel = zoom;
//       });
//     }
//   }

//   void _startTimer() {
//     _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
//       setState(() {
//         _recordTime++;
//       });
//     });
//   }

//   void _stopTimer() {
//     _timer?.cancel();
//     setState(() {
//       _recordTime = 0;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Capture Video')),
//       body: _controller == null || !_controller!.value.isInitialized
//           ? const Center(child: CircularProgressIndicator())
//           : Column(
//               children: [
//                 Expanded(
//                   child: CameraPreview(_controller!),
//                 ),
//                 Text(
//                   _isRecording ? 'Recording: ${_recordTime}s' : '',
//                   style: const TextStyle(fontSize: 18, color: Colors.red),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     IconButton(
//                       icon: Icon(_controller!.value.flashMode == FlashMode.off ? Icons.flash_off : Icons.flash_on),
//                       onPressed: _toggleFlash,
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.camera_front),
//                       onPressed: _switchCamera,
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.zoom_out),
//                       onPressed: () => _setZoomLevel(0.5), // Wide Angle
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.zoom_in),
//                       onPressed: () => _setZoomLevel(1.0), // Normal
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.zoom_out_map),
//                       onPressed: () => _setZoomLevel(2.0), // Zoom
//                     ),
//                     FloatingActionButton(
//                       onPressed: _isRecording ? _stopVideoRecording : _startVideoRecording,
//                       child: Icon(_isRecording ? Icons.stop : Icons.videocam),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//     );
//   }
// }
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;
import 'dart:developer';

class VideoCaptureScreen extends StatefulWidget {
  @override
  _VideoCaptureScreenState createState() => _VideoCaptureScreenState();
}

class _VideoCaptureScreenState extends State<VideoCaptureScreen> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  bool _isRecording = false;

  @override
  void initState() {
    super.initState();
    requestPermissions();
    _initializeCamera();
  }

  Future<void> requestPermissions() async {
    await [
      Permission.camera,
      Permission.microphone,
      Permission.storage,
    ].request();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    _controller = CameraController(_cameras![0], ResolutionPreset.high);
    await _controller?.initialize();
    setState(() {});
  }

  Future<void> _startVideoRecording() async {
    if (_controller != null && !_isRecording) {
      await _controller?.startVideoRecording();
      setState(() {
        _isRecording = true;
      });
    }
  }

  Future<void> _stopVideoRecording() async {
    if (_controller != null && _isRecording) {
      final XFile videoFile = await _controller!.stopVideoRecording();
      setState(() {
        _isRecording = false;
      });
      // Save the file to the Downloads folder
      await _saveVideoToDownloads(videoFile);
    }
  }

  Future<void> _saveVideoToDownloads(XFile videoFile) async {
    // Check if we are on Android 11 or higher
    if (Platform.isAndroid && (await _isAndroidROrHigher())) {
      await _saveToDownloadsAndroid11(videoFile);
    } else {
      await _saveToDownloadsLegacy(videoFile);
    }
  }

  Future<bool> _isAndroidROrHigher() async {
    return (await const MethodChannel('app_channel').invokeMethod<int>('getSdkVersion'))! >= 30;
  }

  Future<void> _saveToDownloadsAndroid11(XFile videoFile) async {
    try {
      final String fileName = path.basename(videoFile.path);
      final Uri uri = await _saveFileToDownloads(
        fileName: fileName,
        mimeType: 'video/mp4',
        filePath: videoFile.path,
      );
      log('Video saved to Downloads folder: $uri');
    } catch (e) {
      log('Error saving to Downloads using MediaStore: $e');
    }
  }

  Future<void> _saveToDownloadsLegacy(XFile videoFile) async {
    try {
      final Directory? downloadsDirectory = await getExternalStorageDirectory();
      final String downloadsPath = '${downloadsDirectory!.path}/Download'; // Public Downloads folder
      final String fileName = path.basename(videoFile.path);
      final File newFile = File('$downloadsPath/$fileName');
      await videoFile.saveTo(newFile.path); // Move file to Downloads
      log('Video saved to legacy Downloads folder: $newFile');
    } catch (e) {
      log('Error saving to Downloads on legacy Android: $e');
    }
  }

  Future<Uri> _saveFileToDownloads({
    required String fileName,
    required String mimeType,
    required String filePath,
  }) async {
    // Implement MediaStore API code here
    // Placeholder for the actual implementation
    throw UnimplementedError();
  }

  void _switchCamera() async {
    if (_controller != null) {
      setState(() {
        _controller = null; // Show loading spinner
      });
      final CameraDescription selectedCamera = _cameras!.firstWhere(
        (camera) => camera != _controller?.description,
      );
      _controller = CameraController(selectedCamera, ResolutionPreset.high);
      await _controller?.initialize();
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      onPressed: _isRecording ? _stopVideoRecording : _startVideoRecording,
                      child: Icon(_isRecording ? Icons.stop : Icons.videocam),
                    ),
                    IconButton(
                      icon: const Icon(Icons.switch_camera),
                      onPressed: _switchCamera,
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
