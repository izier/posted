import 'package:flutter/material.dart';
import 'package:posted/data/models/user.dart';
import 'package:posted/presentation/pages/user_detail_page.dart';

class UserSearchCard extends StatelessWidget {
  final User user;

  const UserSearchCard({
    super.key,
    required this.user
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => UserDetailPage(user: user)));
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.person),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.username, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(user.name),
              ],
            )
          ],
        ),
      ),
    );
  }
}