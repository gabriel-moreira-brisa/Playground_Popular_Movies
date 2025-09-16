import 'package:mobx/mobx.dart';
import '../api/tmdb_api.dart';
import '../models/movie_model.dart';

part 'movies_controller.g.dart';

class MoviesController = _MoviesControllerBase with _$MoviesController;

abstract class _MoviesControllerBase with Store {
  final TmdbApi _tmdbApi = TmdbApi();

  @observable
  ObservableList<Movie> movies = ObservableList<Movie>();//observar a lista

  @observable
  bool isLoading = false; //para iniciar o aplicativo

  @action
  Future<void> fetchMovies() async {
    isLoading = true;//inicia
    final movieList = await _tmdbApi.getPopularMovies();
    movies.clear();
    movies.addAll(movieList);// adicionar os filmes na lista
    isLoading = false;
  }
}