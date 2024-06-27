import 'package:crud_r/domain/models/product_model.dart';
import 'package:crud_r/presentation/components/categories.dart';
import 'package:crud_r/presentation/components/search_bar.dart';
import 'package:crud_r/presentation/pages/user/components/card_search.dart';
import 'package:crud_r/presentation/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';

class SearchPage extends StatefulWidget {
  final String category;
  const SearchPage({super.key, required this.category});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late String category;

  List<ProductModel> _filteredProducts = [];
  List<ProductModel> _productsByName = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    category = widget.category;
    print('la categoria es $category');
    final token = Provider.of<UserProvider>(context, listen: false).user?.token;
    Provider.of<ProductProvider>(context, listen: false).getAllProductsByCategory(token!, category);
    super.initState();
  }

  void _filterProductByName(String query) {
    setState(() {
      _filteredProducts = _productsByName
          .where((product) =>
          product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 50, right: 20),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text(
                  'RESQBITE',
                  style: TextStyle(
                    fontSize: 26.0,
                    color: Color(0xFF464646),
                    fontWeight: FontWeight.w500,
                    fontFamily: 'FiraSansCondensed',
                    letterSpacing: 5,
                  ),
                ),
                const SizedBox(width: 50),
                InkWell(
                  onTap: () {
                    /*Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ProfileStorePage()),
                      );*/
                  },
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: SvgPicture.asset(
                      'assets/images/bag.svg',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                InkWell(
                  onTap: () {
                    /*Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ProfileStorePage()),
                      );*/
                  },
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: Image.asset(
                      'assets/images/avatar.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ]),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SearchBarComponent(
            onChanged: _filterProductByName,
            textController: _searchController,
          ),
          const SizedBox(
            height: 5,
          ),
          const Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: SizedBox(height: 100, child: CategoriesComponent()),
            ),
          ),
          Expanded(
            child: Consumer<ProductProvider>(builder: (_, controller, __) {
              if(controller.loading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                _productsByName = controller.productsFiltered;
                _filteredProducts = _searchController.text.isEmpty ? _productsByName : _filteredProducts;
                return ListView.builder(
                  itemCount: _filteredProducts.length,
                  itemBuilder: (_, index) {
                    final product = _filteredProducts[index];
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SearchCard(
                        tienda: product.name,
                        producto: product.description,
                        stock: product.stock,
                        price: product.price,
                      ),
                    );
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
