import 'package:flutter/material.dart';
import 'package:notifications_firebase/views/home/enums/status_feature_enum.dart';
import 'package:notifications_firebase/views/home/enums/status_screen_enum.dart';
import 'package:notifications_firebase/views/home/models/item_feature_card_model.dart';
import 'package:notifications_firebase/views/home/widgets/background_widget.dart';
import 'package:notifications_firebase/views/home/widgets/feature_card_widget.dart';
import 'package:notifications_firebase/views/home/widgets/hearder_home_page.dart';
import 'package:notifications_firebase/views/home/widgets/home_app_bar.dart';
import 'package:notifications_firebase/views/score/widgets/score_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff77127b),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: HomeAppBar(),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Stack(
          children: [
            const BackgroundWidget(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Builder(builder: (context) {
                    return const HearderHomePage(
                      screenEnum: StatusScreenEnum.loading,
                    );
                  }),
                  Builder(builder: (context) {
                    return const ScoreCard(
                      score: 820,
                      statusScreen: StatusScreenEnum.loading,
                    );
                  }),
                  const SizedBox(height: 16),
                  Builder(builder: (context) {
                    return FeatureCards(features: _getFeatures());
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<ItemFeatureCardModel> _getFeatures() {
    return [
      ItemFeatureCardModel(
        title: 'Consultar um CPF ou CNPJ',
        image: 'assets/images/search_icon.svg',
        onTap: () {},
      ),
      ItemFeatureCardModel(
        title: 'Melhorar a gestão do seu negócio',
        image: 'assets/images/health_icon.svg',
        onTap: () {},
      ),
      ItemFeatureCardModel(
        title: 'Cobrar clientes devedores',
        image: 'assets/images/hands_icon.svg',
        statusFeature: StatusFeatureEnum.inComming,
        onTap: () {},
      ),
      ItemFeatureCardModel(
        title: 'Monitorar clientes e fornecedores',
        image: 'assets/images/radar_icon.svg',
        statusFeature: StatusFeatureEnum.inComming,
        onTap: () {},
      ),
    ];
  }
}

class FeatureCards extends StatelessWidget {
  final List<ItemFeatureCardModel> features;

  const FeatureCards({super.key, required this.features});

  @override
  Widget build(BuildContext context) {
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
              statusFeature: feature.statusFeature,
            ),
          ),
        );
      },
    );
  }
}
