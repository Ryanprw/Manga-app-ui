import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:komik_gang/data/models/manga_model.dart';
import 'package:komik_gang/data/repositories/manga_repository.dart';
import 'package:komik_gang/ui/widgets/custom_discover.dart';
import 'package:komik_gang/ui/widgets/custom_search.dart';
import 'package:shimmer/shimmer.dart'; // Import shimmer

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MangaRepository mangaRepository = MangaRepository();
  bool isAnime = false; // Toggle between manga and anime
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: IndexedStack(
          index: pageIndex,
          children: [
            _buildMainPage(),
            DiscoverPage(),
            _buildBookmarkPage(),
            _buildProfilePage(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        selectedItemColor: Colors.amberAccent,
        unselectedItemColor: Colors.grey[600],
        onTap: (idx) {
          setState(() {
            pageIndex = idx;
          });
        },
        currentIndex: pageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_outlined),
            label: '',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isAnime = !isAnime;
          });
        },
        backgroundColor: Colors.amberAccent,
        child: Icon(isAnime ? Icons.movie : Icons.book),
      ),
    );
  }

  Widget _buildMainPage() {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          isAnime ? "Anime" : "Manga",
          style: const TextStyle(
            fontFamily: 'GangofThree',
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final result = await showSearch(
                context: context,
                delegate: MangaSearchDelegate(mangaRepository),
              );
              if (result != null) {}
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<List<MangaModel>>(
              future: isAnime
                  ? mangaRepository.fetchAnimeByGenre(1)
                  : mangaRepository.fetchMangaByGenre(1),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return _buildShimmer();
                }
                if (snapshot.hasData) {
                  final data = snapshot.data!;
                  return Column(
                    children: [
                      _buildCurrentlyReading(data[0]),
                      const Gap(16),
                      _buildSectionTitle(
                        "FOR YOU",
                        style: const TextStyle(
                          fontFamily: 'GangofThree',
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                      Container(
                        height: 220,
                        margin: const EdgeInsets.only(left: 16),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final item = data[index];
                            return Container(
                              width: 320,
                              margin: const EdgeInsets.only(right: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(item.imageUrl),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                  const Gap(8),
                                  Text(
                                    item.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const Gap(4),
                                  Text(
                                    isAnime ? "Episode 12" : "Chapter 47",
                                    style: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      const Gap(16),
                      _buildSectionTitle(
                        "ALL",
                        style: const TextStyle(
                          fontFamily: 'GangofThree',
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                      _buildAllBooksGrid(data),
                    ],
                  );
                }
                return const Center(
                  child: Text(
                    'Failed to load data',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  // shimmer saat loading
  Widget _buildShimmer() {
    return Column(
      children: List.generate(3, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 220,
              color: Colors.white,
            ),
          ),
        );
      }),
    );
  }

  Widget _buildBookmarkPage() {
    return Center(
      child: Text(
        'Bookmark Page',
        style: GoogleFonts.bungee(
          color: Colors.white,
          fontSize: 24,
        ),
      ),
    );
  }

  Widget _buildProfilePage() {
    return Center(
      child: Text(
        'Profile Page',
        style: GoogleFonts.bungee(
          color: Colors.white,
          fontSize: 24,
        ),
      ),
    );
  }

  Widget _buildCurrentlyReading(MangaModel manga) {
    return Container(
      height: 182,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Container(
            width: 130,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(manga.imageUrl),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  manga.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const Text(
                  "Chapter 32",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                const Gap(12),
                const Gap(24),
                Row(
                  children: const [
                    Text(
                      "78%",
                      style: TextStyle(
                        color: Colors.orangeAccent,
                      ),
                    ),
                    Gap(12),
                    Text(
                      "20 min left",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const Gap(4),
                const LinearProgressIndicator(
                  value: .7,
                  color: Colors.amberAccent,
                ),
                const Gap(12),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.amberAccent,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Center(
                    child: Text(
                      "Continue Reading",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, {required TextStyle style}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: style,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_forward),
            color: Colors.white,
          )
        ],
      ),
    );
  }

  Widget _buildAllBooksGrid(List<MangaModel> mangas) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: mangas.length,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(mangas[index].imageUrl),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          );
        },
      ),
    );
  }
}
