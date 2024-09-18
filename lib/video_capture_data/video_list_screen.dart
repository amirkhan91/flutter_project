
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:test_proj/video_capture_data/video_player_scree.dart';

import 'package:video_thumbnail/video_thumbnail.dart';
import 'video_capture_screen.dart'; // Custom video capture screen

class VideoListScreen extends StatefulWidget {
  @override
  _VideoListScreenState createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoListScreen> {
  List<FileSystemEntity> _videos = [];

  @override
  void initState() {
    super.initState();
    _loadVideos();
  }

  void _loadVideos() async {
    final Directory? directory = await getExternalStorageDirectory();
    final String dirPath = '${directory!.path}/Download'; // Path to Downloads folder
    final List<FileSystemEntity> files = Directory(dirPath).listSync();
    setState(() {
      _videos = files.where((file) => file.path.endsWith('.mp4')).toList();
    });
  }

  Future<String?> _getThumbnail(String videoPath) async {
    return await VideoThumbnail.thumbnailFile(
      video: videoPath,
      imageFormat: ImageFormat.JPEG,
      maxHeight: 64, 
      quality: 75,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Video List')),
      body: _videos.isEmpty
          ? Center(child: Text('No videos found.'))
          : ListView.builder(
              itemCount: _videos.length,
              itemBuilder: (context, index) {
                String videoName = _videos[index].path.split('/').last;
                return FutureBuilder<String?>(
                  future: _getThumbnail(_videos[index].path),
                  builder: (context, snapshot) {
                    return ListTile(
                      leading: snapshot.hasData
                          ? Image.file(File(snapshot.data!))
                          : Icon(Icons.videocam),
                      title: Text(videoName),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                VideoPlayerScreen(videoPath: _videos[index].path),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => VideoCaptureScreen()),
          );
          _loadVideos(); // Refresh the list after capturing a new video
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
