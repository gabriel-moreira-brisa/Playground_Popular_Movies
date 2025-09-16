
class Movie {
  final int id; //id disponível na api
  final String title; //nome do filme
  final String overview; //sobre o filme
  final String posterPath;// poster do filme

  Movie({ // preciso de tudo
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      posterPath: json['poster_path'],
    );
  }
}