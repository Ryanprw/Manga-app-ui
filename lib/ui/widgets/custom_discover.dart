import 'package:flutter/material.dart';
import 'package:komik_gang/data/models/manga_model.dart';
import 'package:komik_gang/data/repositories/manga_repository.dart';
import 'package:komik_gang/ui/pages/detail/detail_pages.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  final MangaRepository _mangaRepository = MangaRepository();
  late Future<List<MangaModel>> _mangaList;
  String selectedGenre = 'Mystery';
  String selectedSort = 'Popularity';

  @override
  void initState() {
    super.initState();
    _fetchMangaList();
  }

  void _fetchMangaList() {
    setState(() {
      _mangaList =
          _mangaRepository.fetchMangaByGenre(_getGenreId(selectedGenre));
    });
  }

  int _getGenreId(String genre) {
    switch (genre) {
      case 'Mystery':
        return 1;
      case 'Thriller':
        return 2;
      case 'Drama':
        return 3;
      case 'Fantasy':
        return 4;
      default:
        return 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'All Books',
                  style: TextStyle(
                    fontFamily: 'GangofThree',
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                DropdownButton<String>(
                  dropdownColor: Colors.grey[900],
                  value: selectedSort,
                  underline: Container(),
                  icon: const Icon(Icons.keyboard_arrow_down,
                      color: Colors.white),
                  items: ['Popularity', 'Rating', 'Newest']
                      .map((filter) => DropdownMenuItem(
                            value: filter,
                            child: Text(
                              filter,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedSort = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ['Mystery', 'Thriller', 'Drama', 'Fantasy']
                    .map(
                      (genre) => Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: genre == selectedGenre
                                ? const Color(0xFFF9CB55)
                                : const Color.fromARGB(255, 48, 48, 48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              selectedGenre = genre;
                              _fetchMangaList();
                            });
                          },
                          child: Text(
                            genre,
                            style: TextStyle(
                              color: genre == selectedGenre
                                  ? Colors.black
                                  : Colors.white,
                              fontFamily: 'GangofThree',
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                FutureBuilder<List<MangaModel>>(
                  future: _mangaList,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text(
                        'Loading...',
                        style: TextStyle(color: Colors.grey),
                      );
                    } else if (snapshot.hasError) {
                      return Text(
                        'Error',
                        style: const TextStyle(color: Colors.grey),
                      );
                    } else if (snapshot.hasData) {
                      return Text(
                        '${snapshot.data!.length} books',
                        style: const TextStyle(color: Colors.grey),
                      );
                    } else {
                      return const Text(
                        'No data',
                        style: TextStyle(color: Colors.grey),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<MangaModel>>(
              future: _mangaList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      'No Manga Found',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                } else {
                  final mangaList = snapshot.data!;
                  return ListView.builder(
                    itemCount: mangaList.length,
                    itemBuilder: (context, index) {
                      final manga = mangaList[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MangaDetailPage(manga: manga),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  manga.imageUrl,
                                  width: 90,
                                  height: 130,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 16.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      manga.title,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 4.0),
                                    Text(
                                      'Rating: ${manga.rating.toStringAsFixed(1)}',
                                      style: const TextStyle(
                                        color: Colors.amber,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(height: 4.0),
                                    Text(
                                      'Chapters: ${manga.chapter}',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Text(
                                      manga.description,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.bookmark_border,
                                  color: Colors.white,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
