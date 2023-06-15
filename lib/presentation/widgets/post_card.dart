import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:posted/data/models/photo.dart';
import 'package:posted/data/models/post.dart';
import 'package:posted/data/models/user.dart';
import 'package:posted/presentation/pages/post_detail_page.dart';
import 'package:posted/presentation/pages/user_detail_page.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final User user;
  final List<Photo> photos;

  const PostCard({
    super.key,
    required this.post,
    required this.user,
    required this.photos,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Text('Posted by '),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => UserDetailPage(user: user)));
                },
                child: Text(user.username, style: const TextStyle(fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width,
          child: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return CachedNetworkImage(
                imageUrl: photos[index].url,
                placeholder: (context, url) => SizedBox(width: MediaQuery.of(context).size.width, child: const Center(child: CircularProgressIndicator(color: Colors.black))),
                errorWidget: (context, url, error) => SizedBox(width: MediaQuery.of(context).size.width, child: const Center(child: Icon(Icons.error))),
              );
            },
            itemCount: photos.length,
            scrollDirection: Axis.horizontal,
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(post.title),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => PostDetailPage(post: post, user: user, photos: photos)));
            },
            child: const Text('See detail', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}