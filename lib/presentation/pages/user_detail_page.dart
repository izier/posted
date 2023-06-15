import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:posted/data/datasources/api_service.dart';
import 'package:posted/data/models/photo.dart';
import 'package:posted/data/models/post.dart';
import 'package:posted/data/models/user.dart';
import 'package:posted/presentation/pages/post_detail_page.dart';

class UserDetailPage extends StatefulWidget {
  final User user;

  const UserDetailPage({
    super.key,
    required this.user,
  });

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  final ApiService _apiService = ApiService();
  List<Post> postList = [];
  List<Photo> photoList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final posts = await _apiService.getUserPost(widget.user.id);
    final photos = await _apiService.getUserPhotos(widget.user.id);
    setState(() {
      postList = posts;
      photoList = photos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.username, style: const TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Icon(Icons.person, size: 64),
                    Column(
                      children: [
                        Text(postList.length.toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                        const Text('posts'),
                      ],
                    ),
                    Column(
                      children: [
                        Text(photoList.length.toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                        const Text('photos'),
                      ],
                    ),
                  ],
                ),
                Text(widget.user.username),
                Text(widget.user.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                const SizedBox(height: 16),
              ],
            ),
          ),
          postList.isEmpty ?
              const Center(child: CircularProgressIndicator(color: Colors.black)):
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: CachedNetworkImage(
                        imageUrl: photoList.where((photo) => photo.albumId == postList[index].id).first.thumbnailUrl,
                        placeholder: (context, url) => const SizedBox(width: 400, child: Center(child: CircularProgressIndicator(color: Colors.black))),
                        errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                      ),
                      onTap: () {
                        final post = postList[index];
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PostDetailPage(post: post, user: widget.user, photos: photoList.where((photo) => photo.albumId == post.id).toList())));
                      },
                    );
                  },
                  itemCount: postList.length,
                ),
              ),
        ],
      ),
    );
  }
}