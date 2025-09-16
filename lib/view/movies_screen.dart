import 'package:flutter/material.dart';
import 'package:flutter_application_filmes/view/movie_detail_screen.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/movies_controller.dart';

import 'login_screen.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  _MoviesScreenState createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  final MoviesController _controller = MoviesController();


  @override
  void initState() {
    super.initState();
    _controller.fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filmes Populares", style: GoogleFonts.orbitron(),),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      
      body: Observer(
        
        builder: (_) {
          if (_controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
    itemCount: _controller.movies.length,
    itemBuilder: (context, index) {
      final movie = _controller.movies[index];
      return ListTile(
        leading: Image.network(
          'https://image.tmdb.org/t/p/w200${movie.posterPath}',
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.movie),
        ),
        title: Text(movie.title),
        subtitle: Text(
          movie.overview,
          maxLines: 3, 
          overflow: TextOverflow.ellipsis,
        ),
       
        onTap: () {
          
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetailScreen(movie: movie),
            ),
          );
        },
      );
    },
  );
        },
      ),
    );
    
  }
}