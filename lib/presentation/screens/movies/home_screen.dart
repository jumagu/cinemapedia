import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavbar(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final isLoadingInitialData = ref.watch(initialLoadingProvider);

    if (isLoadingInitialData) return const FullScreenLoader();

    final slideshowMovies = ref.watch(moviesSlideshowProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppBar(),
            centerTitle: false,
            titlePadding: EdgeInsetsGeometry.zero,
          ),
        ),

        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return Column(
              children: [
                MoviesSlideshow(movies: slideshowMovies),
                MoviesHorizListview(
                  movies: nowPlayingMovies,
                  title: 'Now Playing',
                  label: 'Monday 20',
                  loadNextMovies: () => {
                    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
                  },
                ),
                MoviesHorizListview(
                  movies: upcomingMovies,
                  title: 'Coming Soon',
                  label: 'This Month',
                  loadNextMovies: () => {
                    ref.read(upcomingMoviesProvider.notifier).loadNextPage(),
                  },
                ),
                MoviesHorizListview(
                  movies: popularMovies,
                  title: 'Popular',
                  loadNextMovies: () => {
                    ref.read(popularMoviesProvider.notifier).loadNextPage(),
                  },
                ),
                MoviesHorizListview(
                  movies: topRatedMovies,
                  title: 'Top Rated',
                  label: 'Of all time',
                  loadNextMovies: () => {
                    ref.read(topRatedMoviesProvider.notifier).loadNextPage(),
                  },
                ),
              ],
            );
          }, childCount: 1),
        ),
      ],
    );
  }
}
