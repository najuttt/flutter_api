import 'package:flutter/material.dart';
import 'package:laravel_api/models/product_model.dart';
import 'package:laravel_api/services/order_service.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int jumlah = 1;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    return Scaffold(
      appBar: AppBar(title: Text(product.nama ?? 'Produk')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (product.foto != null && product.foto!.isNotEmpty)
              Center(
                child: Image.network(
                  'http://127.0.0.1:8000/storage/${product.foto}',
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.broken_image, size: 100),
                ),
              ),
            const SizedBox(height: 16),
            Text(
              product.nama ?? 'Tanpa Nama',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Harga: Rp ${product.harga ?? 0}',
              style: const TextStyle(fontSize: 18, color: Colors.green),
            ),
            if (product.kategori != null)
              Text(
                'Kategori: ${product.kategori?.nama ?? "-"}',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            const SizedBox(height: 16),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    if (jumlah > 1) setState(() => jumlah--);
                  },
                ),
                Text('$jumlah', style: const TextStyle(fontSize: 18)),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => setState(() => jumlah++),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        setState(() => isLoading = true);
                        try {
                          final success = await OrderService.createOrder(
                            productId: product.id ?? 0,
                            jumlah: jumlah,
                          );
                          if (success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Order berhasil dibuat'),
                              ),
                            );
                            Navigator.pop(context, true);
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Gagal membuat order: $e')),
                          );
                        } finally {
                          setState(() => isLoading = false);
                        }
                      },
                      child: const Text('Pesan Sekarang'),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
