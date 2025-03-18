import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notifications_firebase/views/home/enums/status_feature_enum.dart';

class FeatureCardWidget extends StatelessWidget {
  final String title;
  final String assetIcon;
  final String? description;
  final StatusFeatureEnum statusFeature;

  const FeatureCardWidget({
    super.key,
    required this.title,
    required this.assetIcon,
    this.statusFeature = StatusFeatureEnum.released,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 110),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: statusFeature.cardColor,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(assetIcon, width: 24),
                  Visibility(
                    visible: statusFeature != StatusFeatureEnum.released,
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: statusFeature.backgroundColor,
                        borderRadius: BorderRadius.circular(
                          5.6,
                        ),
                      ),
                      child: Row(
                        children: [
                          if (statusFeature.icon != null)
                            Padding(
                              padding: const EdgeInsets.only(right: 2.0),
                              child: SvgPicture.asset(
                                statusFeature.icon!,
                                width: 18,
                                colorFilter: const ColorFilter.mode(
                                  Colors.white,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          Text(
                            statusFeature.label ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF384553),
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
