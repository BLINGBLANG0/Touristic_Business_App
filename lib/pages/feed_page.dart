import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/posting_page.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/widgets/post_card.dart';
import 'dart:ui';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 216, 140, 229),
              centerTitle: false,
              title: const Text(
                'Feed',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.share,
                    color: primaryColor,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PostingPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
      body: Stack(
        children: [
          // Blurred background
          Positioned.fill(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: const Color.fromARGB(255, 250, 119, 243).withOpacity(0.5), // Adjust the opacity as needed
              ),
            ),
          ),
          // Main content
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection("posts").orderBy("datePublished", descending: true).snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (ctx, index) => Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: width * 0.05, // Adjusted for better width
                    vertical: 10, // Decreased vertical margin
                  ),
                  child: PostCard(
                    snap: snapshot.data!.docs[index].data(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
