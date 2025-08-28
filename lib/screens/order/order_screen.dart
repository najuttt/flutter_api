import 'package:flutter/material.dart';
import 'package:laravel_api/models/order_model.dart';
import 'package:laravel_api/services/order_service.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late Future<List<DataOrder>> _ordersFuture;

  @override
  void initState() {
    super.initState();
    _ordersFuture = OrderService.listOrder();
  }

  void _refreshOrders() {
    setState(() {
      _ordersFuture = OrderService.listOrder();
    });
  }

  Future<void> _updateOrder(int orderId, int productId, int jumlah) async {
    try {
      final success = await OrderService.updateOrder(
        orderId: orderId,
        productId: productId,
        jumlah: jumlah,
      );
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pesanan berhasil diperbarui')),
        );
        _refreshOrders();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal memperbarui pesanan')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    }
  }

  Future<void> _deleteOrder(int orderId) async {
    try {
      final success = await OrderService.deleteOrder(orderId);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pesanan berhasil dihapus')),
        );
        _refreshOrders();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal menghapus pesanan')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  Future<void> _showUpdateDialog(DataOrder order) async {
    final productNameController = TextEditingController(
      text: order.productName,
    );
    final jumlahController = TextEditingController(
      text: order.jumlah.toString(),
    );

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Perbarui Pesanan'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: productNameController,
              decoration: const InputDecoration(labelText: 'Nama Produk'),
              enabled: false,
            ),
            TextField(
              controller: jumlahController,
              decoration: const InputDecoration(labelText: 'Jumlah'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              final jumlah = int.tryParse(jumlahController.text);
              if (jumlah != null && jumlah > 0) {
                _updateOrder(order.id, order.productId, jumlah);
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Jumlah harus lebih dari 0')),
                );
              }
            },
            child: const Text('Perbarui'),
          ),
        ],
      ),
    );
  }

  String _formatTotalHarga(DataOrder order) {
    if (order.harga == null) return 'Harga tidak tersedia';
    final totalHarga = order.jumlah * order.harga!;
    return 'Rp ${totalHarga.toStringAsFixed(0)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Pesanan')),
      body: FutureBuilder<List<DataOrder>>(
        future: _ordersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ada pesanan ditemukan'));
          }

          final orders = snapshot.data!;
          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return ListTile(
                title: Text('Pesanan ID: ${order.id}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Produk: ${order.productName}'),
                    Text('Jumlah: ${order.jumlah}'),
                    Text('Total Harga: ${_formatTotalHarga(order)}'),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      tooltip: 'Perbarui',
                      onPressed: () => _showUpdateDialog(order),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      tooltip: 'Hapus',
                      onPressed: () => _deleteOrder(order.id),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
