import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies/api/endpoints.dart';
import 'package:flutter_movies/modal_class/function.dart';
import 'package:flutter_movies/modal_class/genres.dart';
import 'package:flutter_movies/modal_class/movie.dart';
import 'package:flutter_movies/screens/movie_detail.dart';
import 'package:flutter_movies/screens/search_view.dart';
import 'package:flutter_movies/screens/settings.dart';
import 'package:flutter_movies/screens/widgets.dart';
import 'package:flutter_movies/theme/theme_state.dart';
import 'package:provider/provider.dart';
import 'package:flutter_movies/login.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeState>(
      create: (_) => ThemeState(),
      child: MaterialApp(
        title: 'Películas',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.blue, canvasColor: Colors.transparent),
        home: MainPage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Genres> _genres = [];
  @override
  void initState() {
    super.initState();
    fetchGenres().then((value) {
      _genres = value.genres ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ThemeState>(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: state.themeData.colorScheme.secondary,
          ),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        centerTitle: true,
        title: Text(
          'Películas',
          style: state.themeData.textTheme.headline5,
        ),
        backgroundColor: state.themeData.primaryColor,
        actions: <Widget>[
          IconButton(
            color: state.themeData.colorScheme.secondary,
            icon: Icon(Icons.search),
            onPressed: () async {
              final Movie? result = await showSearch<Movie?>(
                  context: context,
                  delegate:
                  MovieSearch(themeData: state.themeData, genres: _genres));
              if (result != null) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MovieDetailPage(
                            movie: result,
                            themeData: state.themeData,
                            genres: _genres,
                            heroId: '${result.id}search')));
              }
            },
          )
        ],
      ),
      drawer: Drawer(
        child: SettingsPage(),
      ),
      body: Container(
        color: state.themeData.primaryColor,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            DiscoverMovies(
              themeData: state.themeData,
              genres: _genres,
            ),
            ScrollingMovies(
              themeData: state.themeData,
              title: 'Mejores clasificados',
              api: Endpoints.topRatedUrl(1),
              genres: _genres,
            ),
            ScrollingMovies(
              themeData: state.themeData,
              title: 'En Cartelera',
              api: Endpoints.nowPlayingMoviesUrl(2),
              genres: _genres,
            ),
            // ScrollingMovies(
            //   themeData: state.themeData,
            //   title: 'Proximamente',
            //   api: Endpoints.upcomingMoviesUrl(1),
            //   genres: _genres,
            // ),
            ScrollingMovies(
              themeData: state.themeData,
              title: 'Populares',
              api: Endpoints.popularMoviesUrl(1),
              genres: _genres,
            ),
          ],
        ),
      ),
    );
  }
}