import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_manager/photo_manager.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final List<Widget> _mediaList = [];
  final List<File> path = [];
  File? _file;
  int currentPage = 0;
  int? lastPage;
  @override
  _fetchNewMedia() async {
    lastPage = currentPage;
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (ps.isAuth) {
      List<AssetPathEntity> album =
          await PhotoManager.getAssetPathList(onlyAll: true);
      List<AssetEntity> media =
          await album[0].getAssetListPaged(page: currentPage, size: 60);

      for (var asset in media) {
        if (asset.type == AssetType.image) {
          final file = await asset.file;
          if (file != null) {
            path.add(File(file.path));
          }
        }
      }

      List<Widget> temp = [];
      for (var asset in media) {
        temp.add(FutureBuilder(
            future: asset.thumbnailDataWithSize(ThumbnailSize(200, 200)),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.memory(snapshot.data!, fit: BoxFit.cover),
                      )
                    ],
                  ),
                );
              }

              return Container();
            }));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchNewMedia();
  }

  int indexx = 0;

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'Nouveau post',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
          ),
          centerTitle: false,
          actions: [
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Text('Suivant',
                    style: TextStyle(fontSize: 15.sp, color: Colors.blue)),
              ),
            )
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 475.h,
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisExtent: 1,
                            crossAxisSpacing: 1),
                    itemBuilder: (context, index) {
                      return _mediaList[index];
                    }
                  ),
              ),

              Container(
                width: double.infinity,
                height: 40.h,
                color: Colors.white,
                child: Row(children: [
                  SizedBox(width: 10.w),
                  Text(
                    'Recent',
                    style:
                        TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
                  )
                ]),
              ),

              GridView.builder(
                  shrinkWrap: true,
                  itemCount: _mediaList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisExtent: 1,
                      crossAxisSpacing: 2),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          indexx == index;
                        });
                      },
                      child: _mediaList[index],
                    );
                  }),
            ],
          ),
        )));
  }
}
