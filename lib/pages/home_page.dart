import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/pages/direcciones_page.dart';
import 'package:qr_reader/pages/mapas_page.dart';
import 'package:qr_reader/providers/db_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';
import 'package:qr_reader/widgets/custom_naavigationbar.dart';
import 'package:qr_reader/widgets/scan_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentIndex = 1;
    switch (currentIndex) {
      case 0:
        break;
      case 1:
        break;
      default:
        break;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () {},
          ),
        ],
      ),
      body: const DireccionesPage(),
      bottomNavigationBar: const CustomNavigationbar(),
      floatingActionButton: const ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class HomePageBody extends StatelessWidget {
  const HomePageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final int currentIndex = uiProvider.selectedMenuOpt;

    DBProvider.db.database();
    print('s3d1f32s1d3f21');

    switch (currentIndex) {
      case 0:
        return const MapasPage();
      case 1:
        return const DireccionesPage();
      default:
        return const MapasPage();
    }
  }
}
