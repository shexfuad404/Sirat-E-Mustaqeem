import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'ayat_card.dart';
import 'collection_card.dart';
import 'hadees_card.dart';

class HomeSliverList extends StatelessWidget {
  const HomeSliverList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          CollectionCard(),
          AyatCard(),
          HadessCard(),
          SizedBox(height: 112.h),
        ],
      ),
    );
  }
}
