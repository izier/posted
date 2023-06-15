import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:posted/data/datasources/api_service.dart';
import 'package:posted/data/models/photo.dart';
import 'package:posted/data/models/post.dart';
import 'package:posted/data/models/user.dart';
import 'package:posted/presentation/pages/post_detail_page.dart';
import 'package:posted/presentation/pages/search_page.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchPage()));
            },
            child: SizedBox(
              height: 32,
              child: TextField(
                enabled: false,
                decoration: InputDecoration(
                  fillColor: Colors.black12,
                  filled: true,
                  contentPadding: const EdgeInsets.all(0),
                  isDense: true,
                  prefixIcon: const Icon(Icons.search, color: Colors.black),
                  hintText: 'Search',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: postList.isEmpty ?
          const Center(child: CircularProgressIndicator(color: Colors.black)) :
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                child: CachedNetworkImage(
                  imageUrl: photoList.where((photo) => photo.albumId == index + 1).first.thumbnailUrl,
                  placeholder: (context, url) => const SizedBox(width: 400, child: Center(child: CircularProgressIndicator(color: Colors.black))),
                  errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                ),
                onTap: () {
                  final post = postList[index];
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PostDetailPage(post: post, user: userList.where((user) => user.id == post.userId).first, photos: photoList.where((photo) => photo.albumId == post.id).toList())));
                },
              );
            },
            itemCount: postList.length,
          ),
    );
  }
}