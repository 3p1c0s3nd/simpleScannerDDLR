import 'package:get/get.dart';
import 'package:scanyourpage/class/ClassCrawler.dart';
import 'package:scanyourpage/class/ClassScanner.dart';

class HomeController extends GetxController {
  RxList<String> processedUrls = <String>[].obs;
  RxList<String> sqliUrls = <String>[].obs;
  final RxBool isLoading = false.obs; // Estado de carga
  final bool checkSubdomain = false;
  final int depth = 2;

  void comienza(String url) async {
    isLoading.value = true;
    try {
      final dominio = Uri.parse(url).host;
      final webCrawler = WebCrawler(depth, dominio, checkSubdomain);
      final List<String> urls = await webCrawler.crawl(url);
      processedUrls.value = urls;

      final scanner = ClassScanner(urls: urls);
      final urlsWithSqli = await scanner.scan();
      sqliUrls.value = urlsWithSqli;
    } catch (e) {
      Get.snackbar('Error', 'No se pudo procesar la URL');
    } finally {
      isLoading.value = false;
    }
  }
}
