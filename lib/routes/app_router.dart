import 'package:go_router/go_router.dart';
import '../views/home_view.dart';
import '../views/list_view.dart';
import '../views/detail_view.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => HomeView(),
    ),
    GoRoute(
      path: '/list/:endpoint',
      name: 'list',
      builder: (context, state) {
        final endpoint = state.pathParameters['endpoint']!;
        return ListViewScreen(endpoint: endpoint);
      },
    ),
    GoRoute(
      path: '/detail',
      name: 'detail',
      builder: (context, state) {
        final data = state.extra;
        return DetailView(data: data);
      },
    ),
  ],
);