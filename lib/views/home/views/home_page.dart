import 'package:flutter/material.dart';
import 'package:notifications_firebase/views/home/widgets/feature_card_widget.dart';
import 'package:notifications_firebase/views/home/widgets/hearder_home_page.dart';
import 'package:notifications_firebase/views/home/widgets/home_app_bar.dart';
import 'package:notifications_firebase/views/score/widgets/score_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF71207a),
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, kToolbarHeight),
        child: HomeAppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            const SizedBox(height: 130),
            _buildFeatureCards(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        const HearderHomePage(),
        Positioned(
          top: size.height * 0.27,
          child: Container(
            height: size.height,
            width: size.width,
            color: Colors.white,
          ),
        ),
        const Positioned(
          left: 16.0,
          right: 16.0,
          bottom: -110,
          child: ScoreCard(score: 820),
        ),
      ],
    );
  }

  Widget _buildFeatureCards() {
    final List<ItemFeatureCard> features = [
      ItemFeatureCard(
        title: 'Consultar um CPF ou CNPJ',
        image: 'assets/images/search_icon.png',
        onTap: () {},
      ),
      ItemFeatureCard(
        title: 'Melhorar a gestão do seu negócio',
        image: 'assets/images/search_icon.png',
        onTap: () {},
      ),
      ItemFeatureCard(
        title: 'Cobrar clientes devedores',
        image: 'assets/images/search_icon.png',
        onTap: () {},
      ),
      ItemFeatureCard(
        title: 'Monitorar clientes e fornecedores',
        image: 'assets/images/search_icon.png',
        onTap: () {},
      ),
    ];
    return Column(
      children: features
          .map((feature) => GestureDetector(
                onTap: feature.onTap,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: FeatureCardWidget(
                    title: feature.title,
                    assetIcon: feature.image,
                  ),
                ),
              ))
          .toList(),
    );
  }
}

class ItemFeatureCard {
  final String title;
  final String? description;
  final String image;
  final VoidCallback onTap;

  ItemFeatureCard({
    required this.title,
    required this.image,
    required this.onTap,
    this.description,
  });
}
