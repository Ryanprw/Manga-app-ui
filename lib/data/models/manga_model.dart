class MangaModel {
  final String title;
  final String imageUrl;
  final String chapter;
  final String description;
  final double rating;

  MangaModel({
    required this.title,
    required this.imageUrl,
    required this.chapter,
    required this.description,
    required this.rating,
  });

  factory MangaModel.fromJson(Map<String, dynamic> json) {
    return MangaModel(
      title: json['title'] ?? 'Unknown Title',
      imageUrl: json['images']['jpg']['image_url'] ?? '',
      chapter: json['chapters']?.toString() ?? 'N/A',
      description: json['synopsis'] ?? 'No description available.',
      rating: (json['score'] != null && json['score'] is num)
          ? (json['score'] as num).toDouble()
          : 0.0,
    );
  }
}
