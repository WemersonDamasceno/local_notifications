import 'package:flutter/material.dart';
import 'package:notifications_firebase/views/home/enums/status_feature_enum.dart';
import 'package:notifications_firebase/views/home/enums/status_screen_enum.dart';
import 'package:notifications_firebase/views/home/models/item_feature_card_model.dart';
import 'package:notifications_firebase/views/home/widgets/background_widget.dart';
import 'package:notifications_firebase/views/home/widgets/feature_card_widget.dart';
import 'package:notifications_firebase/views/home/widgets/hearder_home_page.dart';
import 'package:notifications_firebase/views/home/widgets/home_app_bar.dart';
import 'package:notifications_firebase/views/home/widgets/shimmer_base.dart';
import 'package:notifications_firebase/views/score/widgets/score_card.dart';

//SOMENTE PARA TESTES
StatusScreenEnum statusScreen = StatusScreenEnum.loading;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 1500)).then((_) {
      setState(() {
        statusScreen = StatusScreenEnum.success;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();

    statusScreen = StatusScreenEnum.loading;
  }

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
                    return HearderHomePage(
                      screenEnum: statusScreen,
                    );
                  }),
                  Builder(builder: (context) {
                    return ScoreCard(
                      score: 820,
                      statusScreen: statusScreen,
                    );
                  }),
                  const SizedBox(height: 16),
                  Builder(builder: (context) {
                    return FeatureCards(
                      features: _getFeatures(),
                      statusScreen: statusScreen,
                    );
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
  final StatusScreenEnum statusScreen;

  const FeatureCards({
    super.key,
    required this.features,
    required this.statusScreen,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: features.length,
      itemBuilder: (context, index) {
        final feature = features[index];
        switch (statusScreen) {
          case StatusScreenEnum.success:
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
          default:
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                constraints: const BoxConstraints(minHeight: 110),
                child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShimmerItem.secondaryColor(width: 30, height: 30),
                          const SizedBox(height: 8),
                          ShimmerItem.secondaryColor(width: 265, height: 25)
                        ],
                      ),
                    )),
              ),
            );
        }
      },
    );
  }
}
