import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_train/models/post_model.dart';
import 'package:flutter_train/provider.dart';
import 'package:flutter_train/screens/posts.dart';
import 'package:provider/provider.dart';

bool like = false;

class PostDetails extends StatelessWidget {
  PostDetails({Key? key, required this.dataPost}) : super(key: key);
  PostModel dataPost;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Consumer<ChangeLikeProvider>(builder: (context, value, child) {
            return DesignPost(
                name: dataPost.name!,
                time: dataPost.time!,
                descripsion: dataPost.details!,
                image: dataPost.image!);
          }),
          ChangeLike()
        ],
      ),
    );
  }
}

class ChangeLike extends StatefulWidget {
  const ChangeLike({Key? key}) : super(key: key);

  @override
  State<ChangeLike> createState() => _ChangeLikeState();
}

class _ChangeLikeState extends State<ChangeLike> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChangeLikeProvider>(context);

    return GestureDetector(
      onTap: () {
        provider.changLike();
      },
      child: Row(
        children: [
          Icon(
            Icons.favorite_sharp,
            size: 50,
            color: Colors.red,
          )
        ],
      ),
    );
  }
}
