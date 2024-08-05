import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:scanyourpage/home/structures/controller/home_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final TextEditingController textController = TextEditingController();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFF171819),
        appBar: AppBar(
          backgroundColor: const Color(0xFF171819),
          title: Image.asset(
            "./assets/images/DDLR-Cybersecurity.png",
            fit: BoxFit.contain,
            height: 32, // Ajusta el tamaño de la imagen según sea necesario
          ),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 3.0,
            labelStyle: TextStyle(fontSize: 18),
            unselectedLabelStyle: TextStyle(fontSize: 16),
            labelColor: Colors.white,
            tabs: [
              Tab(
                text: 'URLs Encontradas',
                icon: Icon(Icons.search),
              ),
              Tab(text: 'URLs con SQLi', icon: Icon(Icons.security)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Pantalla para URLs encontradas
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text("Ingrese la URL: ",
                          style: TextStyle(color: Colors.white)),
                      Expanded(
                        child: TextField(
                          controller: textController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Escribe la URL aquí',
                            hintStyle: TextStyle(color: Colors.white),
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          homeController.comienza(textController.text);
                        },
                        child: const Text("Scan"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Obx(
                      () {
                        if (homeController.isLoading.value) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return ListView.builder(
                          itemCount: homeController.processedUrls.length,
                          itemBuilder: (context, index) {
                            final url = homeController.processedUrls[index];
                            return ListTile(
                              title: Text(url,
                                  style: const TextStyle(color: Colors.white)),
                              onTap: () {
                                Clipboard.setData(ClipboardData(text: url));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('URL copiada al portapapeles'),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Pantalla para URLs con SQLi
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Obx(
                () {
                  if (homeController.isLoading.value) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    itemCount: homeController.sqliUrls.length,
                    itemBuilder: (context, index) {
                      final url = homeController.sqliUrls[index];
                      return ListTile(
                        title: Text(url,
                            style: const TextStyle(color: Colors.red)),
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: url));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('URL copiada al portapapeles'),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
