import 'package:crud_r/domain/models/product_model.dart';
import 'package:crud_r/presentation/components/categories.dart';
import 'package:crud_r/presentation/components/search_bar.dart';
import 'package:crud_r/presentation/pages/user/components/card_search.dart';
import 'package:crud_r/presentation/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';
import '../splash_page.dart';
import 'components/header.dart';
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
    super.initState();
    category = widget.category;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final token = Provider.of<UserProvider>(context, listen: false).user?.token;
      Provider.of<ProductProvider>(context, listen: false).getAllProductsByCategory(token!, category);
    });
  }

  void _filterProductByName(String query) {
    setState(() {
      _filteredProducts = _productsByName
          .where((product) => product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const HeaderComponent(),
          const SizedBox(height: 10),
          Expanded(
            child: Consumer<ProductProvider>(
              builder: (_, controller, __) {
                if (controller.loading) {
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
                          tienda: product.storeName ?? 'Cargando...',
                          producto: product.name,
                          stock: product.stock,
                          price: product.price,
                          imageProvider: product.imageProvider,
                          id: product.id,
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
