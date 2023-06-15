import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LinkCard extends StatelessWidget {
  final String name;
  final String link;
  final int index;
  final int length;

  const LinkCard({
    super.key,
    required this.name,
    required this.link,
    required this.index,
    required this.length,
  });

  @override
  Widget build(BuildContext context) {
    var margin;

    if (index == 0) {
      margin = const EdgeInsets.only(left: 16, right: 4);
    } else if (index == length - 1) {
      margin = const EdgeInsets.only(right: 16, left: 4);
    } else {
      margin = const EdgeInsets.symmetric(horizontal: 4);
    }

    return Container(
      margin: margin,
      child: InkWell(
        onTap: () => launchUrlString(link),
        child: Container(
          height: 200,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black, width: 0.5),
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.black,
                  ),
                  child: Center(child: Text(name, style: const TextStyle(color: Colors.white, fontSize: 10))),
                ),
                const SizedBox(height: 16),
                Text(name),
              ],
            ),
          ),
        ),
      ),
    );
  }
}