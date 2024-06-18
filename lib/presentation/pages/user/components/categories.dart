import 'package:flutter/material.dart';

class CategoriesComponent extends StatefulWidget {
  const CategoriesComponent({Key? key}) : super(key: key);

  @override
  State<CategoriesComponent> createState() => _CategoriesComponentState();
}

class _CategoriesComponentState extends State<CategoriesComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center, // Align items in the center
        children: [
          CategoryItem(
            label: 'Comidsa',
            imagePath: 'assets/images/food.png',
          ),
          SizedBox(width: 20), // Add space between categories
          CategoryItem(
            label: 'Pastelería',
            imagePath: 'assets/images/cake.png',
          ),
          SizedBox(width: 20),
          CategoryItem(
            label: 'Panadería',
            imagePath: 'assets/images/concha.png',
          ),
          SizedBox(width: 20),
          CategoryItem(
            label: 'Lácsteos',
            imagePath: 'assets/images/leche.png',
          ),
        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String label;
  final String imagePath;

  const CategoryItem({
    Key? key,
    required this.label,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
