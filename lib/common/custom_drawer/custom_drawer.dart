import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_drawer/drawer_title.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // ignore: prefer_const_literals_to_create_immutables
        children: <Widget>[
          DrawerTitle(
            iconData: Icons.home,
            title: 'Inicio',
            page: 0,
          ),
          DrawerTitle(
            iconData: Icons.list,
            title: 'Produtos',
            page: 1,
          ),
          DrawerTitle(
            iconData: Icons.playlist_add_check,
            title: 'Meus Pedidos',
            page: 2,
          ),
          DrawerTitle(
            iconData: Icons.location_on,
            title: 'Lojas',
            page: 3,
          ),
        ],
      ),
    );
  }
}
