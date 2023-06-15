import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:posted/data/models/comment.dart';
import 'package:posted/data/models/photo.dart';
import 'package:posted/data/models/post.dart';
import 'package:posted/data/models/user.dart';

class ApiService {
  static const baseUrl = 'https://jsonplaceholder.typicode.com';
  final http.Client client = http.Client();
  
  Future<List<Post>> getPostList() async {
    final response = await client.get(
      Uri.parse("$baseUrl/posts")
    );
    return List.from(jsonDecode(response.body)).map((post) => Post.fromJson(post)).toList();
  }

  Future<List<Comment>> getPostComments(int id) async {
    final response = await client.get(
        Uri.parse("$baseUrl/posts/$id/comments")
    );

    return List.from(jsonDecode(response.body)).map((comment) => Comment.fromJson(comment)).toList();
  }

  Future<List<Photo>> getPhotos() async {
    final response = await client.get(
        Uri.parse("$baseUrl/photos")
    );

    return List.from(jsonDecode(response.body)).map((photo) => Photo.fromJson(photo)).toList();
  }

  Future<List<User>> getUserList() async {
    final response = await client.get(
      Uri.parse("$baseUrl/users")
    );

    return List.from(jsonDecode(response.body)).map((user) => User.fromJson(user)).toList();
  }

  Future<List<Post>> getUserPost(int id) async {
    final response = await client.get(
        Uri.parse("$baseUrl/users/$id/posts")
    );

    return List.from(jsonDecode(response.body)).map((post) => Post.fromJson(post)).toList();
  }

  Future<List<Photo>> getUserPhotos(int id) async {
    final response = await client.get(
        Uri.parse("$baseUrl/users/$id/photos")
    );

    return List.from(jsonDecode(response.body)).map((photo) => Photo.fromJson(photo)).toList();
  }
}