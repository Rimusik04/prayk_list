import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/models/item_mod.dart';
import 'dart:convert';                   
import 'package:flutter/services.dart';  // ← ДОБАВИЛ: для rootBundle
// import 'item_mod.dart';     
import 'package:prayk_list/main.dart';
import 'package:carousel_slider/carousel_slider.dart';


class Store extends StatefulWidget {
  const Store({super.key});

  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> {
  int _selectedIndex = 0;
  
  int _currentIndex = 0;

  final List<String> _banners = [
    'assets/images/Banner.jpg',
    'assets/images/Banner1.png',
    'assets/images/Banner2.png',
  ];

  // final List<Company> products = [
    
  // ];
  late Future<List<Company>> productsFuture; // ← ДОБАВИЛ: Future для загрузки
  @override
  void initState() {
    super.initState();
    productsFuture = loadProducts();   // ← Я ДОБАВИЛ: теперь Future инициализирован
  }

  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
     
    });

    if (index == 1) {
    } 
    else if (index == 2) {
    }
  }

  Future<List<Company>> loadProducts() async {     
    final jsonString = 
        await rootBundle.loadString('assets/JSON_s/company_json.json'); // ← ЧТЕНИЕ JSON

    final List data = json.decode(jsonString);              // ← Парсинг

    return data.map((e) => Company.fromJson(e)).toList();   // ← Преобразование
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        automaticallyImplyLeading: false, // убирает стрелку "назад"
        backgroundColor: Colors.white,
        centerTitle: true, // выравнивает по центру
        title: SvgPicture.asset(
          'assets/logo/logo.svg',
          height: 30,
        ),
      ),

      body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height:10),
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
              SizedBox(height:10),Container(
                height: 36,
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
              SizedBox(height:10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: 


                  FutureBuilder<List<Company>>(           // ← ДОБАВИЛ FutureBuilder
                    future: productsFuture,
                    builder: (context, snapshot) {
                      
                      
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return Center(child: Text("Ошибка: ${snapshot.error}"));
                      }

                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text("Нет данных"));
                      }

                      final company = snapshot.data!;

                        return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(), 
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // 2 товара в строке
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.7, // пропорции карточек
                        ),
                        itemCount: company.length,
                        itemBuilder: (context, index) {
                          return _buildProductCard(company[index]);
                        },
                      );
                    },
                  )
              ),            
            ],
          ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavItem(Icons.home_outlined, Icons.home, 1),
              _buildNavItem(Icons.storefront_outlined, Icons.storefront_rounded, 0),
              _buildNavItem(Icons.add_circle_outline, Icons.add_circle_rounded, 2),
              _buildNavItem(Icons.message_outlined, Icons.message_rounded, 3),
              _buildNavItem(Icons.account_circle_outlined, Icons.account_circle, 4),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildProductCard(Company product) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: const Color(0xFFFBFAFA),
      boxShadow: [
        BoxShadow(
          color: Colors.white,
        ),
      ],
    ),
    child: Column(
      children: [
        Expanded(
          child: Center(
            child:Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(product.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: 
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/svg/Star.svg', height: 20),               
              SvgPicture.asset('assets/svg/Star.svg', height: 20),               
              SvgPicture.asset('assets/svg/Star.svg', height: 20),               
              SvgPicture.asset('assets/svg/Star.svg', height: 20),               
              SvgPicture.asset('assets/svg/Star.svg', height: 20),       
            ]        
          )
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            product.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            
          ),
        ),
        SizedBox(height: 10,)
      ],
    ),
  );
}

  Widget _buildNavItem(IconData icon,IconData selectedIcon ,int index) {
    bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () {
        _onNavTapped(index);

        if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePage ()),
          );
        }
        else if (index == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Store()),
          );
        }
        else if (index == 3) {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const Store()),
          // );
        }
        else  {
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
              size: 28, 
            ),
            const SizedBox(height: 4),
            
          ],
        )
      )
    );
  }
}
