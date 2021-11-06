import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp2/services/firebaseService.dart';
import 'package:flutterapp2/widgets/fireBaseButton.dart';
import 'package:path/path.dart';

class Example extends StatefulWidget {
  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  UploadTask? task;
  List<File>? file;

  @override
  Widget build(BuildContext context) {
    // final fileName = file != null ? basename(file!.path) : 'No File Selected';

    return Scaffold(
      appBar: AppBar(
        title: Text('Example'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonWidget(
                text: 'Select File',
                icon: Icons.attach_file,
                onClicked: selectFile,
              ),
              SizedBox(height: 8),
              // Text(
              //   fileName,
              //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              // ),
              SizedBox(height: 48),
              ButtonWidget(
                text: 'Upload File',
                icon: Icons.cloud_upload_outlined,
                onClicked: uploadFile,
              ),
              SizedBox(height: 20),
              task != null ? buildUploadStatus(task!) : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg'],
    );
    if (result == null) return;
    List<File> files = result.paths.map((path) => File(path!)).toList();
    setState(() => file = files);
  }

  Future uploadFile() async {
    if (file == null) return;
    for( int i = 0; i < file!.length; i++ ){
      
      print( file![i] );
      print('----');
      
      final fileName = basename(file![i].toString());
      final destination = '/hola${i.toString()}';

      task = FirebaseService.uploadFile(destination, file![i]);
      setState(() {});

      if (task == null) return;

      final snapshot = await task!.whenComplete(() {});
      final urlDownload = await snapshot.ref.getDownloadURL();

      print('Download-Link: $urlDownload');
    }
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);

            return Text(
              '$percentage %',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            );
          } else {
            return Container();
          }
        },
      );
}
