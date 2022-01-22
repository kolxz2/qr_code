import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;

class QrCode extends StatefulWidget {
  const QrCode({Key key}) : super(key: key);

  @override
  State<QrCode> createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {

  final String _fileUrl = 'https://upload.wikimedia.org/wikipedia/commons/9/9a/Gull_portrait_ca_usa.jpg';
  final String _fileName = 'Gull_portrait_ca_usa.jpg';
  final Dio _dio = Dio();

  String _progress = "-";


  Future<bool> _requestPermissions() async {
    var permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);

    if (permission != PermissionStatus.granted) {
      await PermissionHandler().requestPermissions([PermissionGroup.storage]);
      permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
    }

    return permission == PermissionStatus.granted;
  }

  void _onReceiveProgress(int received, int total) {
    if (total != -1) {
      setState(() {
        _progress = (received / total * 100).toStringAsFixed(0) + "%";
      });
    }
  }

  Future<void> _startDownload(String savePath) async {
    Map<String, dynamic> result = {
      'isSuccess': false,
      'filePath': null,
      'error': null,
    };
    try {
      final response = await _dio.download(
          _fileUrl,
          savePath,
          onReceiveProgress: _onReceiveProgress
      );
      result['isSuccess'] = response.statusCode == 200;
      result['filePath'] = savePath;
    } catch (ex) {
      result['error'] = ex.toString();
    }
  }

  Future<Directory> _getDownloadDirectory() async {
    try {
      if (Platform.isAndroid) {
        return await DownloadsPathProvider.downloadsDirectory;
        DownloadsPathProvider.downloadsDirectory;
      }
      return await getApplicationDocumentsDirectory();
    } catch(e){
      print(e);
    }
  }

  Future<void> _download() async {
    final dir = await _getDownloadDirectory();
    final isPermissionStatusGranted = await _requestPermissions();

    if (isPermissionStatusGranted) {
      final savePath = path.join(dir.path, _fileName);
      await _startDownload(savePath);
    } else {
      // handle the scenario when user declines the permissions
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const Expanded(
                flex: 3,
                child: Image(
                  image: AssetImage(
                    "assets/images/fvsr-logo.png",
                  ),
                ),
              ) ,
              Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _download,
                        child: const Text("Скачать",
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          onPrimary: Colors.white,
                          shadowColor: Colors.greenAccent,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          minimumSize: const Size(150, 70),
                          maximumSize: const Size(150, 70),//////// HERE
                        ),
                      ),
                    ],
              ))
            ],
          )
        ),
    );
  }
}
