import 'package:flutter/material.dart';
import 'package:notifications_firebase/views/home/enums/status_feature_enum.dart';
import 'package:notifications_firebase/views/home/enums/status_screen_enum.dart';
import 'package:notifications_firebase/views/home/models/item_feature_card_model.dart';
import 'package:notifications_firebase/views/home/views/home_page.dart';
import 'package:notifications_firebase/views/home/widgets/feature_card_widget.dart';
import 'package:notifications_firebase/views/home/widgets/feature_cards_loading_widget.dart';

class FeatureCards extends StatelessWidget {
  final StatusScreenEnum screenEnum;

  const FeatureCards({super.key, required this.screenEnum});

  @override
  Widget build(BuildContext context) {
    final featureList = _getFeatures();
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: featureList.length,
      itemBuilder: (context, index) {
        final feature = featureList[index];
        switch (statusScreen) {
          case StatusScreenEnum.loading:
            return const FeatureCardsLoadingWidget();
          default:
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
        }
      },
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
