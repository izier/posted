import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:posted/data/datasources/api_service.dart';
import 'package:posted/data/models/comment.dart';
import 'package:posted/data/models/photo.dart';
import 'package:posted/data/models/post.dart';
import 'package:posted/data/models/user.dart';
import 'package:posted/presentation/pages/user_detail_page.dart';

class PostDetailPage extends StatefulWidget {
  final Post post;
  final User user;
  final List<Photo> photos;

  const PostDetailPage({
    super.key,
    required this.post,
    required this.user,
    required this.photos,
  });

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  List<Comment> comments = [];
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final commentsData = await _apiService.getPostComments(widget.post.id);
    setState(() {
      comments = commentsData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width,
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return CachedNetworkImage(
                    imageUrl: widget.photos[index].url,
                    placeholder: (context, url) => SizedBox(width: MediaQuery.of(context).size.width, child: const Center(child: CircularProgressIndicator(color: Colors.black))),
                    errorWidget: (context, url, error) => SizedBox(width: MediaQuery.of(context).size.width, child: const Center(child: Icon(Icons.error))),
                  );
                },
                itemCount: widget.photos.length,
                scrollDirection: Axis.horizontal,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Icon(Icons.person),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => UserDetailPage(user: widget.user)));
                    },
                    child: Text(widget.user.username, style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(widget.post.title),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(widget.post.body),
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text('Comments', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 8),
            comments.isEmpty ?
                const Center(child: CircularProgressIndicator(color: Colors.black),) :
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(comments[index].email, style: const TextStyle(fontWeight: FontWeight.bold)),
                          Text(comments[index].body),
                          const SizedBox(height: 8),
                        ],
                      );
                    },
                    itemCount: comments.length,
                    physics: const NeverScrollableScrollPhysics(),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}