import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../routes/routes.dart';
import '../../../core/util/bloc/database/database_bloc.dart';
import '../../../core/util/constants.dart';

class SplashScaffold extends StatelessWidget {
  const SplashScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<DatabaseBloc, DatabaseState>(
      listener: (context, state) async {
        await Future.delayed(Duration(milliseconds: 750));
        if (state is DatabaseLoaded) {
          final locationPermission = await Permission.location.status;
          final notificationPermission = await Permission.notification.status;

          if (!locationPermission.isGranted) {
            Navigator.of(context)
                .pushReplacementNamed(RouteGenerator.locationPermission);
          } else if (!notificationPermission.isGranted) {
            Navigator.of(context)
                .pushReplacementNamed(RouteGenerator.notificationPermission);
          } else {
            Navigator.of(context).pushReplacementNamed(RouteGenerator.tabScreen);
          }
        } else if (state is DatabaseFailed) {
          Navigator.of(context)
              .pushReplacementNamed(RouteGenerator.databaseError);
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        // extendBodyBehindAppBar: true,
        // extendBody: true,
        // appBar: AppBar(
        //   // backgroundColor: Colors.black,
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        //   toolbarHeight: 0,
        //   systemOverlayStyle: Theme.of(context).appBarTheme.systemOverlayStyle,
        // ),
        body: Center(
          child: ClipRRect(
            borderRadius: kAppIconBorderRadius,
            child: SvgPicture.asset(
              'assets/images/core/svg/splash.svg',
              height: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
