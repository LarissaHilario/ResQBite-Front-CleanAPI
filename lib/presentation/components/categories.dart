import 'package:crud_r/domain/use_cases/get_all_products_usecase.dart';
import 'package:crud_r/presentation/pages/user/search_page.dart';
import 'package:crud_r/presentation/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class CategoriesComponent extends StatefulWidget {
  const CategoriesComponent({super.key});

  @override
  State<CategoriesComponent> createState() => _CategoriesComponentState();
}

class _CategoriesComponentState extends State<CategoriesComponent> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CategoryItem(
            label: 'COMIDA',
            imagePath: 'assets/images/food.png',
            onTap: () {
              const category = 'COMIDA';
              print('voy para la search page');
              Navigator.push(context, MaterialPageRoute(
                    builder: (context) => const SearchPage(
                      category: category,)));

            },
          ),
          const SizedBox(width: 6),
          CategoryItem(
            label: 'PASTELERIA',
            imagePath: 'assets/images/cake.png',
            onTap: () {
              const category = 'PASTELERIA';
              print('voy para la search page');
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const SearchPage(
                    category: category,)));

            },
          ),
          const SizedBox(width: 6),
          CategoryItem(
            label: 'PANADERIA',
            imagePath: 'assets/images/concha.png',
            onTap: () {
              const category = 'PANADERIA';
              print('voy para la search page');
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const SearchPage(
                    category: category,)));

            },
          ),
          const SizedBox(width: 6),
          CategoryItem(
            label: 'LACTEOS',
            imagePath: 'assets/images/leche.png',
            onTap: () {
              const category = 'LACTEOS';
              print('voy para la search page');
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const SearchPage(
                    category: category,)));

            },
          ),
        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String label;
  final String imagePath;
  void Function()? onTap;

  CategoryItem({
    super.key,
    required this.label,
    required this.imagePath,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 70,
        height: 75,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xFF88B04F).withOpacity(.25),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 12.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'FiraSansCondensed',
              ),
            ),
            Image.asset(
              imagePath,
              width: 40,
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
