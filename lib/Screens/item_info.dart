import 'package:flutter/material.dart';
import '/models/product.dart';
import 'package:flutter_svg/flutter_svg.dart';


class ItemInfo extends StatefulWidget {
  final Product product;  // передаем продукт через конструктор

  const ItemInfo({super.key, required this.product});

  @override
  State<ItemInfo> createState() => _ItemInfoState();
}

class _ItemInfoState extends State<ItemInfo> {
  @override
  
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    final product = widget.product;

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Column(children:[
            Text("Arytan Soyuducu"),
            Text(
                "Posted: ${product.time}",
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
          ]),
        ),
        actions: [
          PopupMenuButton<String>(
            color: Colors.red,
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
      body: 
      SingleChildScrollView(
        child: Column(
          children: [Column(
              children: [
                SizedBox(
                  height: 250,
                  child: PageView(
                    children: product.images.map((img) {
                      return Image.asset(
                        img,
                        fit: BoxFit.cover,
                      );
                    }).toList(),
                  ),
                ),
              ]
            ),
            Container(
              padding: EdgeInsets.all(20),
              child:Column(
                children:[
                  const SizedBox(height: 8),
                  Container(height: 1,width: screenWidth ,decoration: BoxDecoration(color:  const Color.fromARGB(255, 212, 211, 211),),),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children:[
                    Row(
                      children:[
                        Image.asset('assets/images/history.jpg',height: 60,),
                        Column(children: [
                          Container(width:200,child:Text(product.description)),
                          Row(children: [
                            SvgPicture.asset('assets/svg/Star.svg', height: 30),               
                            SvgPicture.asset('assets/svg/Star.svg', height: 30),               
                            SvgPicture.asset('assets/svg/Star.svg', height: 30),               
                            SvgPicture.asset('assets/svg/Star.svg', height: 30),               
                            SvgPicture.asset('assets/svg/Star.svg', height: 30),               
                          ],)
                        ],)
                      ]
                    ),
                    ElevatedButton(
                      onPressed: () async {

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        foregroundColor: Colors.black,
                        elevation: 0,
                        side: const BorderSide(color: Colors.grey, width: 0.1),
                      ),
                      child: Text('Sell'),
                    ),
                  ]),
                  const SizedBox(height: 8),
                  Container(height: 1,width: screenWidth ,decoration: BoxDecoration(color:  const Color.fromARGB(255, 212, 211, 211),),),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${product.price} KZT",
                            style: const TextStyle(
                                fontSize: 16, color: Colors.redAccent, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "${product.decount} KZT",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough
                            ),
                          ),
                        ],
                      ),
                      Text("See this content 38 users")
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () async {

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.black,
                      elevation: 0,
                      side: const BorderSide(color: Colors.grey, width: 0.1),
                    ),
                    child: Text('Create something'),
                  ),
                ]
              ),
            )
          ],
        ),
      ),
    );
  }
}
