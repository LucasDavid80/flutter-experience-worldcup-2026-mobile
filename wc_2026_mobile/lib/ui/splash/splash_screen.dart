import 'package:flutter_svg/svg.dart';
import 'package:material_ui/material_ui.dart';
import 'package:wc_2026_mobile/ui/core/share/app_assets.dart';
import 'package:wc_2026_mobile/ui/core/share/licensed_badge.dart';
import 'package:wc_2026_mobile/ui/core/share/logo_card.dart';
import 'package:wc_2026_mobile/ui/core/theme/app_colors.dart';

class const SplashScreen({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: .expand,
        children: [
          SvgPicture.asset(AppAssets.patterns.paniniArcSplashSvg, fit: .cover),
          ColoredBox(color: AppColors.cream.withValues(alpha: .35)),
          Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: .center,
                  children: [
                    LicensedBadge(),
                    SizedBox(height: 40),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 290,
                        maxHeight: 380,
                      ),
                      child: LogoCard(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
