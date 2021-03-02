import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual/common/empty_card.dart';
import 'package:loja_virtual/common/login_cart.dart';
import 'package:loja_virtual/models/orders_manager.dart';
import 'package:loja_virtual/screens/orders/components/order_title.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text('Meus Pedidos'),
        centerTitle: true,
      ),
      body: Consumer<OrdersManager>(
        builder: (_, ordersManager, __) {
          if (ordersManager.user == null) return LoginCard();
          if (ordersManager.orders.isEmpty) {
            return const EmptyCard(
              title: 'Nenhuma Compra encontrada',
              iconData: Icons.border_clear,
            );
          }
          return ListView.builder(
            itemCount: ordersManager.orders.length,
            itemBuilder: (_, index) {
              return OrderTitle(ordersManager.orders.reversed.toList()[index]);
            },
          );
        },
      ),
    );
  }
}
