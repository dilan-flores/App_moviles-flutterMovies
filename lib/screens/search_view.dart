import 'package:flutter/material.dart';
import 'package:flutter_movies/modal_class/genres.dart';
import 'package:flutter_movies/modal_class/movie.dart';
import 'package:flutter_movies/screens/widgets.dart';

class MovieSearch extends SearchDelegate<Movie?> {
  final ThemeData? themeData;
  final List<Genres>? genres;
  MovieSearch({this.themeData, this.genres});

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = themeData!.copyWith(
        hintColor: themeData!.colorScheme.secondary,
        primaryColor: themeData!.primaryColor,
        textTheme: const TextTheme(
          titleLarge: TextStyle(color: Color.fromRGBO(0, 0, 255, 0.8)),
        ));
    return theme;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
          color: themeData!.colorScheme.secondary,
        ),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: themeData!.colorScheme.secondary,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchMovieWidget(
      genres: genres,
      themeData: themeData,
      query: query,
      onTap: (movie) {
        close(context, movie);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      color: themeData!.primaryColor,
      child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 50,
                height: 50,
                child: Icon(
                  Icons.search,
                  size: 50,
                  color: themeData!.colorScheme.secondary,
                ),
              ),
              Text('Ingresa una película para buscar.',
                  style: themeData!.textTheme.bodyText1)
            ],
          )),
    );
  }
}
