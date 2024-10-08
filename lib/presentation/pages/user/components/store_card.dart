import 'package:crud_r/presentation/pages/user/about_store_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/store/store_provider.dart';
import '../../../providers/user_provider.dart';

class CardStoreComponent extends StatefulWidget {
  const CardStoreComponent({Key? key}) : super(key: key);

  @override
  State<CardStoreComponent> createState() => _CardStoreComponentState();
}

class _CardStoreComponentState extends State<CardStoreComponent> {
  @override
  void initState() {
    super.initState();
    final token = Provider.of<UserProvider>(context, listen: false).user?.token;
    if (token != null) {
      Provider.of<StoreProvider>(context, listen: false).getAllStores(token);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 35, top: 15),
                child: Text(
                  'Tiendas',
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Color(0xFF464646),
                    fontWeight: FontWeight.w500,
                    fontFamily: 'FiraSansCondensed',
                    letterSpacing: 3,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Consumer<StoreProvider>(
                builder: (_, controller, __) {
                  if (controller.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    final stores = controller.stores;
                    return Padding(
                      padding: const EdgeInsets.only(left: 35, right: 20),
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          childAspectRatio: 1.0,
                        ),
                        itemCount: stores.length,
                        itemBuilder: (_, index) {
                          final store = stores[index];
                          return Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => StoreUserPage(storeId: store.id),
                                  ),
                                );
                              },
                              child: Container(
                                width: 140,
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: const Color(0xFF88B04F).withOpacity(.85),
                                ),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                      child: Image(
                                        image: store.imageProvider,
                                        width: double.infinity,
                                        height: 70,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 30,
                                      left: 10,
                                      right: 0,
                                      child: Text(
                                        store.name,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 2.5,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 5, top: 2),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => StoreUserPage(storeId: store.id),
                                              ),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(50),
                                            ),
                                            minimumSize: const Size(8, 20),
                                          ),
                                          child: const Text(
                                            'Ver más',
                                            style: TextStyle(
                                              fontSize: 13.0,
                                              color: Color(0xFF88B04F),
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'FiraSansCondensed',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
