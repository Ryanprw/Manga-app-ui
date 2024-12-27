import 'package:flutter/material.dart';
import 'package:komik_gang/data/models/manga_model.dart';

class MangaDetailPage extends StatelessWidget {
  final MangaModel manga;

  const MangaDetailPage({Key? key, required this.manga}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "CHAPTER ${manga.chapter}",
                        style: const TextStyle(
                          fontFamily: 'GangofThree',
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        "Page ${130}", // Ubah sesuai kebutuhan
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 12,
                          color: Colors.white54,
                        ),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                ],
              ),
            ),

            // Main Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Manga Image
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.network(
                          manga.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),

                    // Detail Manga
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Nama Pengarang
                          Text(
                            manga.chapter,
                            style: const TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 12,
                              color: Colors.white54,
                            ),
                          ),
                          const SizedBox(height: 4.0),

                          // Judul Manga
                          Text(
                            manga.title.toUpperCase(),
                            style: TextStyle(
                              fontFamily: 'GangofThree',
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8.0),

                          // Rating dan Tag
                          Row(
                            children: [
                              const Icon(Icons.star,
                                  color: Colors.amber, size: 18),
                              const SizedBox(width: 4.0),
                              Text(
                                manga.rating.toStringAsFixed(1),
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.amber,
                                ),
                              ),
                              const SizedBox(width: 12.0),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 2.0),
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: const Text(
                                  'TOP',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),

                          // Deskripsi Manga
                          Text.rich(
                            TextSpan(
                              text:
                                  'If there\'s one thing college students want, it\'s money! After getting a job at a diner, lori runs into the familiar... ',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                              children: [
                                TextSpan(
                                  text: 'read more',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.amber,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Read Now Button
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF9CB55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                onPressed: () {},
                child: const Text(
                  "READ NOW →",
                  style: TextStyle(
                    fontFamily: 'GangofThree',
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
