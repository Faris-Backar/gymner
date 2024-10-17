import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/core/resources/asset_resources.dart';
import 'package:gym/core/resources/style_resources.dart';
import 'package:gym/di/di.dart';
import 'package:gym/presentation/bloc/bottom_navigation_bar/bottom_navigation_bar_bloc.dart';
import 'package:gym/presentation/bloc/members/members_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final bottomNavigationBarBloc = getIt<BottomNavigationBarBloc>();
    getIt<MembersBloc>().add(GetMembersEvent());
    return Scaffold(
      backgroundColor: StyleResources.scaffoldBackgroundColor,
      body: BlocBuilder<BottomNavigationBarBloc, BottomNavigationState>(
        bloc: bottomNavigationBarBloc,
        builder: (context, state) {
          log("page state => ${state.currentIndex}");
          return PageView(
            controller: _pageController,
            onPageChanged: (index) {
              bottomNavigationBarBloc
                  .add(BottomNavigationEvent.pageTapped(index: index));
            },
            physics: const NeverScrollableScrollPhysics(),
            children: bottomNavigationBarBloc.tabPages, // Disable swipe
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
                _buildNavItem(context, state, 0, AssetResources.home,
                    bottomNavigationBarBloc),
                _buildNavItem(context, state, 1, AssetResources.member,
                    bottomNavigationBarBloc,
                    size: const Size(25, 25)),
                _buildNavItem(context, state, 2, AssetResources.transactions,
                    bottomNavigationBarBloc),
                _buildNavItem(context, state, 3, AssetResources.settings,
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
          _pageController.jumpToPage(index); // Jump to tapped page
          bottomNavigationBarBloc
              .add(BottomNavigationEvent.pageTapped(index: index));
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
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
