import 'package:flutter/material.dart';
import '../../data/models/manga_model.dart';

class MangaListWidget extends StatelessWidget {
  final List<MangaModel> mangaList;

  const MangaListWidget({Key? key, required this.mangaList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: mangaList.length,
        itemBuilder: (context, index) {
          final manga = mangaList[index];
          return Card(
            color: const Color(0xFF2D2D44),
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  manga.imageUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                manga.title,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }
}
