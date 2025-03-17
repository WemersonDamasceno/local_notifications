import 'package:flutter/material.dart';
import 'package:notifications_firebase/views/home/widgets/feature_card_widget.dart';
import 'package:notifications_firebase/views/home/widgets/hearder_home_page.dart';
import 'package:notifications_firebase/views/home/widgets/home_app_bar.dart';
import 'package:notifications_firebase/views/score/widgets/score_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xff77127b),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: HomeAppBar(),
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Stack(
          children: [
            Background(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  HearderHomePage(),
                  ScoreCard(score: 820),
                  SizedBox(height: 16),
                  FeatureCards(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.29,
          color: const Color(0xff77127b),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.80,
          width: double.infinity,
          color: const Color(0xFFf8f9f9),
        ),
      ],
    );
  }
}

class FeatureCards extends StatelessWidget {
  const FeatureCards({super.key});

  @override
  Widget build(BuildContext context) {
    final features = [
      ItemFeatureCard(
          title: 'Consultar um CPF ou CNPJ',
          image: 'assets/images/search_icon.png',
          onTap: () {}),
      ItemFeatureCard(
          title: 'Melhorar a gestão do seu negócio',
          image: 'assets/images/search_icon.png',
          onTap: () {}),
      ItemFeatureCard(
          title: 'Cobrar clientes devedores',
          image: 'assets/images/search_icon.png',
          onTap: () {}),
      ItemFeatureCard(
          title: 'Monitorar clientes e fornecedores',
          image: 'assets/images/search_icon.png',
          onTap: () {}),
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: features.length,
      itemBuilder: (context, index) {
        final feature = features[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: GestureDetector(
            onTap: feature.onTap,
            child: FeatureCardWidget(
              title: feature.title,
              assetIcon: feature.image,
            ),
          ),
        );
      },
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
