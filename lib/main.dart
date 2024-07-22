import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:crud_r/domain/use_cases/add_product_usecase.dart';
import 'package:crud_r/domain/use_cases/get_all_products_usecase.dart';
import 'package:crud_r/presentation/pages/splash_page.dart';
import 'package:crud_r/presentation/providers/basketProvider.dart';
import 'package:crud_r/presentation/providers/product_provider.dart';
import 'package:crud_r/presentation/providers/store/store_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:crud_r/presentation/providers/connectivity.dart';
import 'package:crud_r/presentation/providers/user_provider.dart';
import 'package:crud_r/infraestructure/repositories/api_product_repository.dart';
import 'package:crud_r/infraestructure/repositories/local_product_repository.dart';
import 'package:crud_r/infraestructure/repositories/product_repository_impl.dart';
import 'package:crud_r/domain/use_cases/delete_product_usecase.dart';
import 'package:crud_r/domain/use_cases/get_all_product_byStore_usecase.dart';
import 'package:crud_r/domain/use_cases/get_product_by_id_usecase.dart';
import 'package:crud_r/domain/use_cases/update_product_usecase.dart';

class ProductSyncManager {
  final LocalProductRepository _localProductRepository = LocalProductRepository();
  final ApiProductRepository _apiProductRepository = ApiProductRepository();
  final String token;

  ProductSyncManager(this.token) {
    _startPeriodicSync();
  }

  void _startPeriodicSync() {
    Timer.periodic(Duration(minutes: 5), (timer) async {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult != ConnectivityResult.none) {
        await _localProductRepository.processPendingOperations(_apiProductRepository, token);
      }
    });
  }
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  print('Stripe Publishable Key: ${dotenv.env["STRIPE_PUBLISH_KEY"]}');// Si el archivo está en la raíz, no necesitas especificar fileName
  Stripe.publishableKey = dotenv.env["STRIPE_PUBLISH_KEY"]!;
  Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  Stripe.urlScheme = 'flutterstripe';
  await Stripe.instance.applySettings();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => StoreProvider()),
        ChangeNotifierProvider(create: (_) =>  ProductProvider()),
        ChangeNotifierProvider(create: (_) => BasketProvider()),
        ChangeNotifierProvider(create: (_)=> ConnectivityService()),
        Provider(create: (_) => ApiProductRepository()),
        Provider(create: (_) => LocalProductRepository()),
        ChangeNotifierProvider<ProductRepositoryImpl>(
          create: (context) => ProductRepositoryImpl(
            ApiProductRepository(),
            LocalProductRepository(),
            context,
          ),
        ),

        ProxyProvider<ProductRepositoryImpl, GetAllProductsByStoreUseCase>(
          update: (_, productRepository, __) => GetAllProductsByStoreUseCase(productRepository),
        ),
        ProxyProvider<ProductRepositoryImpl, GetAllProductsUseCase>(
          update: (_, productRepository, __) => GetAllProductsUseCase(productRepository),
        ),
        ProxyProvider<ProductRepositoryImpl, GetProductByIdUseCase>(
          update: (_, productRepository, __) => GetProductByIdUseCase(productRepository),
        ),
        ProxyProvider<ProductRepositoryImpl, UpdateProductUseCase>(
          update: (_, productRepository, __) => UpdateProductUseCase(productRepository),
        ),
        ProxyProvider<ProductRepositoryImpl, DeleteProductUseCase>(
          update: (_, productRepository, __) => DeleteProductUseCase(productRepository),
        ),
        ProxyProvider<ProductRepositoryImpl, CreateProductUseCase>(
          update: (_, productRepository, __) => CreateProductUseCase(productRepository),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const MyInitPage(),
    );
  }
}