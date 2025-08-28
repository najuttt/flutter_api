import 'package:flutter/material.dart';
import 'package:laravel_api/models/product_model.dart';
import 'package:laravel_api/screens/product/detail_product.dart';
import 'package:laravel_api/services/product_service.dart';

class ListProduct extends StatefulWidget {
  const ListProduct({super.key});

  @override
  State<ListProduct> createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {
  late Future<ProductModel> _futureProducts;

  @override
  void initState() {
    super.initState();
    _futureProducts = ProductService.listProduct();
  }

  void _refreshProducts() {
    setState(() {
      _futureProducts = ProductService.listProduct();
    });
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            onPressed: _refreshProducts,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder<ProductModel>(
        future: _futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final products = snapshot.data?.data ?? [];
          if (products.isEmpty) {
            return const Center(child: Text('No products found'));
          }

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: ListTile(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailScreen(product: product),
                      ),
                    );
                    if (result == true) _refreshProducts();
                  },
                  leading: product.foto != null && product.foto!.isNotEmpty
                      ? Image.network(
                          'http://127.0.0.1:8000/storage/${product.foto!}',
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              const Icon(Icons.broken_image),
                        )
                      : const Icon(Icons.shopping_bag),
                  title: Text(product.nama ?? 'No Name'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (product.deskripsi != null &&
                          product.deskripsi!.isNotEmpty)
                        Text(
                          product.deskripsi!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      Text(
                        'Price: \$${product.harga ?? 0} • Stock: ${product.stok ?? 0}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      if (product.kategori != null)
                        Text(
                          'Category: ${product.kategori!.nama}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.blueGrey,
                          ),
                        ),
                      Text(
                        'Created: ${_formatDate(product.createdAt)}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  trailing: Text('#${product.id}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
