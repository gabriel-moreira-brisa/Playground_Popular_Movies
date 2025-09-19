import 'package:mobx/mobx.dart';
import '../api/tmdb_api.dart';
import '../models/movie_model.dart';

part 'movies_controller.g.dart';

class MoviesController = _MoviesControllerBase with _$MoviesController;

abstract class _MoviesControllerBase with Store {
  final TmdbApi _tmdbApi = TmdbApi();

  @observable
  ObservableList<Movie> movies = ObservableList<Movie>(); //observar a lista

  @observable
  bool isLoading = false; //para iniciar o aplicativo

  @action
  Future<void> fetchMovies() async {
    isLoading = true;
    final fullMovieList = await _tmdbApi.getPopularMovies();
    if (fullMovieList.isNotEmpty) {
      final limitedMovieList = fullMovieList.take(15).toList();

      movies.clear();
      movies.addAll(limitedMovieList);
    } else {
      movies.clear();
    }

    isLoading = false;
  }
}
