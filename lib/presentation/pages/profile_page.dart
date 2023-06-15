import 'package:flutter/material.dart';
import 'package:posted/presentation/widgets/link_card.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final List links = [
    ['GitHub', 'https://github.com/izier'],
    ['Linkedin', 'https://linkedin.com/in/faizirfanudin'],
    ['Instagram', 'https://instagram.com/ui.byiz'],
    ['Instagram', 'https://instagram.com/i.zier'],
  ];

  final List projects = [
    ['Posted', 'https://github.com/izier/posted'],
    ['t_sk', 'https://github.com/izier/t_sk'],
    ['Gamology', 'https://github.com/izier/Gamology_BLoC'],
    ['musiQ', 'https://github.com/izier/musiQ'],
    ['Ditonton', 'https://github.com/izier/ditonton'],
    ['nmixx app', 'https://github.com/izier/nmixx_app'],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('izier', style: TextStyle(color: Colors.black)),
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
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset('img/pp.jpg', width: 64),
                    ),
                    const Column(
                      children: [
                        Text('6', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                        Text('projects'),
                      ],
                    ),
                    const Column(
                      children: [
                        Text('10', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                        Text('repositories'),
                      ],
                    ),
                  ],
                ),
                const Text('izier'),
                const Text('Moch Faiz Irfanudin', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                const SizedBox(height: 8),
                const Text('Information System Undergraduate of Universitas Brawijaya'),
                const Text('Flutter - Mobile Development and UI/UX Design'),
                const SizedBox(height: 16),
                const Text('My links', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
              ],
            ),
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return LinkCard(name: links[index][0], link: links[index][1], index: index, length: links.length);
              },
              itemCount: links.length,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.black,
                    ),
                    child: Center(child: Text(projects[index][0], style: const TextStyle(color: Colors.white))),
                  ),
                  onTap: () => launchUrlString(projects[index][1]),
                );
              },
              itemCount: projects.length,
            ),
          ),
        ],
      ),
    );
  }
}