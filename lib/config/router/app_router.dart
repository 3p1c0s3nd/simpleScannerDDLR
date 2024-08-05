import 'package:get/get.dart';
import 'package:scanyourpage/home/pages/home_page.dart';

abstract class Routes {
  static const INITIAL = '/';
  static const HOME = '/home';
  static const LOGIN = '/login';
  static const CADASTRO = '/cadastro';
}

class AppRouter {
  List<GetPage<dynamic>>? getPages() {
    return [
      GetPage(
        name: Routes.HOME,
        page: () => HomePage(),
      ),
    ];
  }
}
