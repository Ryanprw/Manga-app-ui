import 'package:flutter/material.dart';
import 'package:komik_gang/data/models/manga_model.dart';
import 'package:komik_gang/data/repositories/manga_repository.dart';
import 'package:komik_gang/ui/widgets/custom_mangalist.dart';

class MangaSearchDelegate extends SearchDelegate {
  final MangaRepository mangaRepository;

  MangaSearchDelegate(this.mangaRepository);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<MangaModel>>(
      future: mangaRepository.searchManga(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          return MangaListWidget(
            mangaList: [],
          );
        }
        return const Center(
          child: Text(
            'No results found',
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
