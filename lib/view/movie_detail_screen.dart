import 'package:flutter/material.dart';
import '../models/movie_model.dart';

class MovieDetailScreen extends StatelessWidget {
  // Recebe o objeto do filme selecionado
  final Movie movie;

  const MovieDetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Coloca o título do filme na barra de navegação para dar contexto
        title: Text(movie.title),
      ),
      body: SingleChildScrollView( // Evitar overflow com textos longos
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
           
            children: [
              // Poster do Filme em destaque
              Center(
                child: Image.network(
                  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.movie, size: 100),
                ),
              ),
              const SizedBox(height: 24.0),

              // Título do Filme
              Text(
                movie.title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),

              Text(
                'Sinopse',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                movie.overview,
                // Sem restrição de maxLines para mostrar todo o texto
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}