import 'package:flutter/material.dart';
import 'package:posted/data/datasources/api_service.dart';
import 'package:posted/data/models/photo.dart';
import 'package:posted/data/models/post.dart';
import 'package:posted/data/models/user.dart';
import 'package:posted/presentation/widgets/post_card.dart';

class PostListPage extends StatefulWidget {
  const PostListPage({super.key});

  @override
  State<PostListPage> createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  final ApiService _apiService = ApiService();
  List<Post> postList = [];
  List<Photo> photoList = [];
  List<User> userList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final posts = await _apiService.getPostList();
    final photos = await _apiService.getPhotos();
    final users = await _apiService.getUserList();
    setState(() {
      postList = posts;
      photoList = photos;
      userList = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posted', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: postList.isEmpty ?
          const Center(
            child: CircularProgressIndicator(color: Colors.black),
          ) :
          ListView.builder(
            itemBuilder: (context, index) {
              return PostCard(post: postList[index], user: userList.where((user) => user.id == postList[index].userId).first, photos: photoList.where((photo) => photo.albumId == (index + 1)).toList());
            },
            itemCount: postList.length,
          ),
    );
  }
}