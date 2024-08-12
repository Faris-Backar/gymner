import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/core/resources/asset_resources.dart';
import 'package:gym/core/resources/style_resources.dart';
import 'package:gym/di/di.dart';
import 'package:gym/presentation/bloc/bottom_navigation_bar/bottom_navigation_bar_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomNavigationBarBloc = getIt<BottomNavigationBarBloc>();
    return Scaffold(
      backgroundColor: StyleResources.scaffoldBackgroundColor,
      body: BlocBuilder<BottomNavigationBarBloc, BottomNavigationState>(
        bloc: bottomNavigationBarBloc, // Ensure the correct bloc is used
        builder: (context, state) {
          log("page state => ${state.currentIndex}");
          return IndexedStack(
            index: state.currentIndex, // Specify which index to display
            children: bottomNavigationBarBloc.tabPages,
          );
        },
      ),
      bottomNavigationBar:
          BlocBuilder<BottomNavigationBarBloc, BottomNavigationState>(
        bloc: bottomNavigationBarBloc,
        builder: (context, state) {
          return Container(
            height: 8.h,
            color: StyleResources.accentColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNavItem(context, state, 0, AssetResources.homeFilled,
                    bottomNavigationBarBloc),
                _buildNavItem(context, state, 1, AssetResources.peopleFilled,
                    bottomNavigationBarBloc,
                    size: const Size(25, 25)),
                _buildNavItem(context, state, 2, AssetResources.calenderOutline,
                    bottomNavigationBarBloc),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildNavItem(
      BuildContext context,
      BottomNavigationState state,
      int index,
      String filledIcon,
      BottomNavigationBarBloc bottomNavigationBarBloc,
      {Size? size}) {
    return Expanded(
      child: InkWell(
        onTap: () {
          bottomNavigationBarBloc
              .add(BottomNavigationEvent.pageTapped(index: index));
        },
        child: SizedBox(
          height: size?.height ?? 20,
          width: size?.width ?? 20,
          child: filledIcon.endsWith(".png")
              ? Image.asset(
                  filledIcon,
                  color: state.currentIndex == index
                      ? StyleResources.primaryColor
                      : StyleResources.black,
                )
              : SvgPicture.asset(
                  filledIcon,
                  colorFilter: ColorFilter.mode(
                    state.currentIndex == index
                        ? StyleResources.primaryColor
                        : StyleResources.black,
                    BlendMode.srcIn,
                  ),
                ),
        ),
      ),
    );
  }
}
