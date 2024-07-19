import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddPostCreen extends StatefulWidget {
  const AddPostCreen({super.key});

  @override
  State<AddPostCreen> createState() => _AddPostCreenState();
}

class _AddPostCreenState extends State<AddPostCreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Add Post'),),);
  }
}