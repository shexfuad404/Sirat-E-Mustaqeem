import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sirat_e_mustaqeem/src/core/util/constants.dart';

import '../../../core/util/bloc/juz/juz_bloc.dart';
import '../../../core/util/bloc/surah/surah_bloc.dart';
import '../../bottom_tab/bloc/tab/tab_bloc.dart' as btb;
import '../bloc/tab/tab_bloc.dart' as qtb;
import '../cubit/quran_cubit.dart';
import 'juz_card.dart';
import 'quran_tab.dart';
import 'surah_card.dart';

class QuranScaffold extends StatelessWidget {
  const QuranScaffold();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Theme.of(context).textTheme.bodyMedium!.color,
        ),
        title: Text(
          'Al-Quran',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.bold, fontSize: 24.sp),
        ),
        centerTitle: false,
        actions: [
          GestureDetector(
            onTap: () {
              if (!BlocProvider.of<QuranCubit>(context).state.fromNav)
                Navigator.of(context).pop();
              BlocProvider.of<btb.TabBloc>(context).add(btb.SetTab(3));
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
              ),
              child: SvgPicture.asset(
                'assets/images/navigation_icon/svg/bookmark_nfill.svg',
                width: 24.w,
                color: Theme.of(context).textTheme.bodyMedium!.color,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (!BlocProvider.of<QuranCubit>(context).state.fromNav)
                Navigator.of(context).pop();
              BlocProvider.of<btb.TabBloc>(context).add(btb.SetTab(1));
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
              ),
              child: SvgPicture.asset(
                'assets/images/navigation_icon/svg/search.svg',
                width: 24.w,
                color: Theme.of(context).textTheme.bodyMedium!.color,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8.h,
            ),
            // Padding(
            //   padding: EdgeInsets.only(left: 32.w),
            //   child: Text(
            //     'Al-Qur\'an',
            //     style: Theme.of(context).textTheme.displayMedium!.copyWith(
            //           fontWeight: FontWeight.bold,
            //         ),
            //   ),
            // ),
            // SizedBox(
            //   height: 16.h,
            // ),
            QuranTab(),
            GestureDetector(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 12.h,
                  vertical: 10.h,
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 12.h,
                  horizontal: 10.h,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withValues(
                        alpha: 0.15,
                      ),
                  borderRadius: kAppIconBorderRadius,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Continue Reading Surah Al-Baqara",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Theme.of(context).primaryColor,
                    )
                  ],
                ),
              ),
            ),
            BlocBuilder<qtb.TabBloc, qtb.TabState>(
              builder: (context, tabState) {
                return Expanded(
                  child: PageView.builder(
                      controller: tabState.controller,
                      itemCount: 2,
                      onPageChanged: (index) {
                        BlocProvider.of<qtb.TabBloc>(context)
                            .add(qtb.ToggleTab(index == 0));
                      },
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return BlocBuilder<SurahBloc, SurahState>(
                            builder: (context, state) {
                              return ListView.builder(
                                  itemCount: state.surahs.surahs.length,
                                  itemBuilder: (context, index) {
                                    return SurahCard(
                                      state.surahs,
                                      index,
                                    );
                                  });
                            },
                          );
                        } else {
                          return BlocBuilder<JuzBloc, JuzState>(
                            builder: (context, state) {
                              return ListView.builder(
                                  itemCount: state.juzs.juzs.length,
                                  itemBuilder: (context, index) {
                                    return JuzCard(
                                      state.juzs,
                                      index,
                                    );
                                  });
                            },
                          );
                        }
                      }),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
