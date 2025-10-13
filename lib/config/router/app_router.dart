import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:cinemapedia/presentation/views/views.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    // ? Nested navigation preserving the state
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          HomeScreen(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/', builder: (context, state) => const HomeView()),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/categories',
              builder: (context, state) => const CategoriesView(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/favorites',
              builder: (context, state) => const FavoritesView(),
            ),
          ],
        ),
      ],
    ),

    GoRoute(
      path: '/movie/:id',
      name: MovieScreen.routeName,
      builder: (context, state) {
        final movieId = state.pathParameters['id'] ?? 'no-id';
        return MovieScreen(movieId: movieId);
      },
    ),

    // ? Normal navigation
    // GoRoute(
    //   path: '/',
    //   name: HomeScreen.routeName,
    //   builder: (context, state) => const HomeScreen(childView: FavoritesView()),
    //   routes: [
    //     GoRoute(
    //       path: 'movie/:id',
    //       name: MovieScreen.routeName,
    //       builder: (context, state) {
    //         final movieId = state.pathParameters['id'] ?? 'no-id';
    //         return MovieScreen(movieId: movieId);
    //       },
    //     ),
    //   ],
    // ),
  ],
);
