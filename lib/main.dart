import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() => runApp(const AppBarApp());

class AppBarApp extends StatelessWidget {
  const AppBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AppBarExample(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AppBarExample extends StatelessWidget {
  const AppBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 🔹 Боковое меню
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(color: Color.fromARGB(135, 35, 35, 35)),
              child: Text('Меню',
                  style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Главная'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Настройки'),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Выход'),
            ),
          ],
        ),
      ),

      // 🔹 Кастомный верхний блок (заменяет AppBar)
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 10),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.white,
                ),
              ],
            ),
            child: Column(
              children: [
                // 🔸 Логотип сверху
                SvgPicture.asset(
                  'assets/logo/logo.svg',
                  height: 30,
                ),
                const SizedBox(height: 12),

                // 🔸 Нижняя панель
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Builder(
                      builder: (context) => IconButton(
                        icon: const Icon(Icons.menu, color: Colors.black),
                        onPressed: () => Scaffold.of(context).openDrawer(),
                      ),
                    ),
                    // Поле поиска
                    Expanded(
                      child: Container(
                        height: 36,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color.fromARGB(255, 212, 211, 211), // 🔸 цвет рамки
                            width: 1.5,         // 🔸 толщина рамки
                          ),
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: "Search...",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.search, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    // Профиль
                    SvgPicture.asset(
                      'assets/logo/notific.svg',
                      height: 30,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 🔹 Основное содержимое
          const Expanded(
            child: Center(
              child: Text(
                'Главная страница',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
