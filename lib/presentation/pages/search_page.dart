import 'package:flutter/material.dart';
import 'package:posted/data/datasources/api_service.dart';
import 'package:posted/data/models/user.dart';
import 'package:posted/presentation/widgets/user_search_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final ApiService _apiService = ApiService();
  List<User> userList = [];
  List<User> searchList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final users = await _apiService.getUserList();
    setState(() {
      userList = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: SizedBox(
            height: 32,
            child: TextField(
              autofocus: true,
              cursorColor: Colors.black,
              cursorWidth: 1,
              decoration: InputDecoration(
                fillColor: Colors.black12,
                filled: true,
                contentPadding: const EdgeInsets.all(0),
                isDense: true,
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                hintText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (text) {
                if(text.isEmpty) {
                  setState(() {
                    searchList = [];
                  });
                } else {
                  setState(() {
                    searchList = userList.where((user) => (user.name.toLowerCase().contains(text.toLowerCase()))||(user.username.toLowerCase().contains(text.toLowerCase()))).toList();
                  });
                }
              },
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return InkWell(
            child: UserSearchCard(user: searchList[index]),
            onTap: () {},
          );
        },
        itemCount: searchList.length,
      ),
    );
  }
}