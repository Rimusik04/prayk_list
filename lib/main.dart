import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:prayk_list/Screens/authori.dart';
import 'package:prayk_list/Screens/store.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/product.dart';
import 'dart:convert';
import 'Screens/item_info.dart';

import 'package:flutter/services.dart' show rootBundle;

final List<Product> products =  [];
   
Future<List<Product>> loadProducts() async {
  final String jsonString =
      await rootBundle.loadString('assets/JSON_s/product_json.json');

  final List<dynamic> jsonData = json.decode(jsonString);

  return jsonData.map((item) => Product.fromJson(item)).toList();
}

void main() => runApp(const AppBarApp());

class AppBarApp extends StatelessWidget {
  const AppBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  int _currentIndex = 0;
  bool isPressed = false;
  bool isPressed1 = false;

  late Future<List<Product>> productsFuture;

  @override
  void initState() {
    super.initState();
    productsFuture = loadProducts();
  }
  
  final List<String> _banners = [
    'assets/images/Banner.jpg',
    'assets/images/Banner1.png',
    'assets/images/Banner2.png',
  ];

  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
    
  
 
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    
   
    
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
  
      drawer: Drawer(
        child: ListView(
          
          padding: EdgeInsets.zero,
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(color: Color.fromARGB(135, 35, 35, 35)),
              child: Text('Меню',
              style:  TextStyle( fontWeight: FontWeight.bold,color: Colors.white, fontSize: 24)),
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

      body: SingleChildScrollView(
        
        child: Column(
          children: [
            // 🔹 Верхний блок с логотипом и поиском
            Container(
              padding: const EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 10),
              decoration: const BoxDecoration(color: Colors.white),
              child: Column(
                children: [
                  SvgPicture.asset('assets/logo/logo.svg', height: 30),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Builder(
                        builder: (context) => IconButton(
                          icon: const Icon(Icons.menu, color: Colors.black),
                          onPressed: () => Scaffold.of(context).openDrawer(),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 32,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color.fromARGB(255, 212, 211, 211),
                              width: 1,
                            ),
                          ),
                          child: const TextField(
                            decoration: InputDecoration(
                              hintText: "Search",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.search, color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                      SvgPicture.asset('assets/logo/notific.svg', height: 30),
                    ],
                  ),
                ],
              ),
            ),
            // SizedBox(width: 16,),
            // 🔹 Горизонтальная полоса с иконками
            SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 10, left: 16,right: 16),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  8,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Image.asset('assets/images/history.jpg',
                        width: 70, height: 70),
                  ),
                ),
              ),
            ),
            Stack(
              alignment: Alignment.bottomCenter,children: [            
                CarouselSlider.builder(
                  itemCount: _banners.length,
                  itemBuilder: (context, index, realIndex) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        _banners[index],
                        width: screenWidth,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: 100,
                    autoPlay: true,
                    viewportFraction: 0.9, // немного отступов по бокам
                    enlargeCenterPage: true, // выделяет активный баннер
                    autoPlayInterval: const Duration(seconds: 3),
                    onPageChanged: (index, reason) {
                      setState(() => _currentIndex = index);
                    },
                  ),
                ),

                Positioned(
                  bottom: 14, 
                  child: Row(                  
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _banners.asMap().entries.map((entry) {
                      return Container(
                        width: 4,
                        height: 4,
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentIndex == entry.key
                              ? Colors.white
                              : Colors.grey.shade500,
                        ),
                      );
                    }).toList(),
                  ),
                )
              ]
            ),
            SizedBox(height: 10,),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () async {
                      showModalBottomSheet(   
                        context: context,
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                        ),
                        builder: (BuildContext context) {
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min, 
                              children: [
                                const Text(
                                  'ALL',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10),
                                ListTile(
                                  title: const Text('Buy'),
                                  onTap: () {
                                    Navigator.pop(context); 
                                  },
                                ),
                                ListTile(
                                  title: const Text('Sell'),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  title: const Text('Give free'),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  title: const Text('Market'),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  title: const Text('service'),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                Container(
                                  height: 10,
                                  width: screenWidth,
                                  color: Colors.amber                 
                                  ),
                                ListTile(
                                  title: const Text('Close', style: TextStyle(color: Colors.red)),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      elevation: 0,
                      side: const BorderSide(color: Colors.grey, width: 1),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children:[
                        Row(
                          children: [
                            Text("All  "),    
                            SvgPicture.asset('assets/svg/Down.svg', height: 30),              
                          ], 
                        )
                      ],
                    ),
                  ),

                  SizedBox(width: 5),
                  
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(   
                        context: context,
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                        ),
                        builder: (BuildContext context) {
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min, 
                              children: [
                                const Text(
                                  'Condition',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10),
                                ListTile(
                                  title: const Text('Color'),
                                  onTap: () {
                                    Navigator.pop(context); 
                                  },
                                ),
                                ListTile(
                                  title: const Text('Sound'),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  title: const Text('Variable'),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  title: const Text('shape'),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                Container(
                                  height: 10,
                                  width: screenWidth,
                                  color: Colors.amber                 
                                  ),
                                ListTile(
                                  title: const Text('Close', style: TextStyle(color: Colors.red)),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      elevation: 0,
                      side: const BorderSide(color: Colors.grey, width: 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Text("Condition  "),
                            SvgPicture.asset('assets/svg/Down.svg', height: 30),  
                          ], 
                          )
                      ],
                    ),
                  ),
                  const SizedBox(width: 5),
                                    
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isPressed = !isPressed;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      elevation: 0,
                      side:isPressed ? BorderSide(color: Colors.red, width: 1):BorderSide(color: Colors.grey, width: 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(isPressed ? "Kredit   X" : "Kredit", style: TextStyle(color: isPressed ? Colors.red:Colors.black),),
                  ),

                  const SizedBox(width: 5),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isPressed1 = !isPressed1;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      side: isPressed1 ? BorderSide(color: Colors.red, width: 1): BorderSide(color: Colors.grey, width: 1),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children:  [
                        Text(isPressed1 ? "Delivery   X": "Delivery", style: TextStyle(color: isPressed1 ? Colors.red : Colors.black), ),
                        SizedBox(width: 5),
                        
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),

            const SizedBox(height: 10),

            FutureBuilder<List<Product>>(
              future: productsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text("Ошибка загрузки данных"));
                }

                final products = snapshot.data!; // здесь теперь есть данные

                return GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.65,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ItemInfo(product: product),
                          ),
                        );
                      },
                      child: ProductCard(product: product),
                    );
                  },
                );
              },
            )

                    ],
                  ),
                ),
                bottomNavigationBar: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 6,
                        offset: const Offset(0, -3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildNavItem(Icons.home_outlined, Icons.home, 0),
                        _buildNavItem(Icons.storefront_outlined, Icons.storefront_rounded, 1,),
                        _buildNavItem(Icons.add_circle_outline, Icons.add_circle_rounded, 2),
                        _buildNavItem(Icons.message_outlined, Icons.message_rounded, 3),
                        _buildNavItem(Icons.account_circle_outlined, Icons.account_circle, 4),
                      ],
                    ),
                  ),
                ),
              );
            }

            // 🔸 Отдельный метод для создания кнопок навигации
            Widget _buildNavItem(IconData icon,IconData selectedIcon ,int index) {
              bool isSelected = _selectedIndex == index;

              return GestureDetector(
                onTap: () {
                  _onNavTapped(index);

                  if (index == 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  }
                  else if (index == 1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Store()),
                    );
                  }
                  else if (index == 3) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  Authori()),
                    );
                  }
                  else {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => const Store()),
                    // );
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    // color: isSelected ? const Color.fromARGB(255, 193, 25, 10) : Colors.transparent,// цвет вокруг иконки
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isSelected ? selectedIcon : icon, // 🔹 вот тут главное изменение
                        color: isSelected ? Colors.black : Colors.black,
                        size: 28, // (добавил чуть больше размер)
                      ),
                      const SizedBox(height: 4),
                      
                    ],
                  )
                )
              );
              
  }
  
}

                

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300, width: 1), 
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              // 1️⃣ Основное изображение
              ClipRRect(
                borderRadius:  BorderRadius.circular(12),
                child: Image.asset(
                  product.images[1],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 165,
                ),
              ),

              // 2️⃣ Первый блок (сверху-слева)
              Positioned(
                bottom: 10,
                left: 10,
                height: 30,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF0600),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    "Sells",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.only(right: 4,left: 4,top: 1,bottom:1),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.35),
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.remove_red_eye_outlined ,color: Colors.white ,size: 17,),
                      // Text(,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold ),),
                    ] 
                  )
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // 🔹 всё влево
                    children:  [
                      SizedBox(height: 5),
                      Text(product.time?? "unknown"),
                      Row(children:[Text(
                        product.price.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),
                      ),
                      SizedBox(width:10),
                      Text(
                        product.decount.toString(),
                        style: TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),]),
                      SizedBox(height: 6),
                      Text(
                        product.description,
                        maxLines: 2,               
                        overflow: TextOverflow.ellipsis, 
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  color: Colors.white,
                  onSelected: (value) {
                    print("You choise: $value");
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(value: 'edit', child: Text('Редактировать')),
                    const PopupMenuItem(value: 'delete', child: Text('Удалить')),
                    const PopupMenuItem(value: 'share', child: Text('Поделиться')),
                    const PopupMenuItem(value: 'Add in Favorite', child: Text('Добавить в избранные')),
                    const PopupMenuItem(value: 'Hide', child: Text('Скрыть')),
                  ],
                  child: const Icon(Icons.more_vert), 
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}


