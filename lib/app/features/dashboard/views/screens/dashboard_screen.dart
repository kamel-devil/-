library dashboard;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:project_management/app/constans/app_constants.dart';
import 'package:project_management/app/features/dashboard/views/components/project_card.dart';
import 'package:project_management/app/features/dashboard/views/components/task_card.dart';
import 'package:project_management/app/features/dashboard/views/components/upgrade_premium_card.dart';
import 'package:project_management/app/utils/helpers/app_helpers.dart';

import '../../../../login/screens/login.dart';

import '../../service/add_servecie/service.dart';
import '../../service/listofservice.dart';
import '../change_password.dart';
import '../components/responsive_builder.dart';
import '../components/selection_button.dart';
import '../components/today_text.dart';
import '../contract.dart';
import '../edit_profile.dart';

// binding
part '../../bindings/dashboard_binding.dart';

// controller
part '../../controllers/dashboard_controller.dart';

// models
part '../../models/profile.dart';

// component
part '../components/active_project_card.dart';

part '../components/header.dart';

part '../components/overview_header.dart';

part '../components/profile_tile.dart';


part '../components/sidebar.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      drawer: (ResponsiveBuilder.isDesktop(context))
          ? null
          : const Drawer(
              child: Padding(
                padding: EdgeInsets.only(top: kSpacing),
                child: _Sidebar(),
              ),
            ),
      body: SingleChildScrollView(
          child: ResponsiveBuilder(
        mobileBuilder: (context, constraints) {
          return Column(children: [
            const SizedBox(height: kSpacing * (kIsWeb ? 1 : 2)),
            _buildHeader(onPressedMenu: () => controller.openDrawer()),
            const SizedBox(height: kSpacing),
            const SizedBox(height: kSpacing * 2),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('craftsman')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('requests')
                    .where('isAccept', isEqualTo: 0)
                    .where('cancelorder', isEqualTo: false)
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    List data = snapshot.data!.docs;
                    return _buildTaskOverview(
                      data: data,
                      crossAxisCount: 6,
                      crossAxisCellCount: 6,
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),

            const SizedBox(height: kSpacing * 2),

            const SizedBox(height: kSpacing),
            // _buildRecentMessages(data: controller.getChatting()),
          ]);
        },
        tabletBuilder: (context, constraints) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: (constraints.maxWidth < 950) ? 6 : 9,
                child: Column(
                  children: [
                    const SizedBox(height: kSpacing * (kIsWeb ? 1 : 2)),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('craftsman')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection('requests')
                            .where('isAccept', isEqualTo: 0)
                            .snapshots(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            List data = snapshot.data!.docs;
                            return _buildTaskOverview(
                              data: data,
                              headerAxis: (constraints.maxWidth < 850)
                                  ? Axis.vertical
                                  : Axis.horizontal,
                              crossAxisCount: 6,
                              crossAxisCellCount: (constraints.maxWidth < 950)
                                  ? 6
                                  : (constraints.maxWidth < 1100)
                                      ? 3
                                      : 2,
                            );
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        }),
                    const SizedBox(height: kSpacing * 2),
                    const SizedBox(height: kSpacing),
                  ],
                ),
              ),
              Flexible(
                flex: 4,
                child: Column(
                  children: [
                    const SizedBox(height: kSpacing * (kIsWeb ? 0.5 : 1.5)),
                    const Divider(thickness: 1),
                    const SizedBox(height: kSpacing),
                    const Divider(thickness: 1),
                    const SizedBox(height: kSpacing),
                    // _buildRecentMessages(data: controller.getChatting()),
                  ],
                ),
              )
            ],
          );
        },
        desktopBuilder: (context, constraints) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: (constraints.maxWidth < 1360) ? 4 : 4,
                child: const ClipRRect(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(kBorderRadius),
                      bottomRight: Radius.circular(kBorderRadius),
                    ),
                    child: _Sidebar()),
              ),
              Flexible(
                flex: 9,
                child: Column(
                  children: [
                    const SizedBox(height: kSpacing * 2),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('craftsman')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection('requests')
                            .where('isAccept', isEqualTo: 0)
                            .where('cancelorder', isEqualTo: false)
                            .snapshots(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            List data = snapshot.data!.docs;
                            return _buildTaskOverview(
                              data: data,
                              crossAxisCount: 6,
                              crossAxisCellCount:
                                  (constraints.maxWidth < 1360) ? 3 : 2,
                            );
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        }),//الطلبات الي بتيجي من ال client
                    const SizedBox(height: kSpacing * 2),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("craftsman")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection('services')
                            .snapshots(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            List myService = snapshot.data.docs;
                            return _buildActiveProject(
                              data: myService,
                              crossAxisCount: 6,
                              crossAxisCellCount:
                                  (constraints.maxWidth < 1360) ? 3 : 2,
                              service: true,
                            );
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        }),//الخدمات بتاعت ال craftsman
                    const SizedBox(height: kSpacing),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("craftsman")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection('requests')
                            .snapshots(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            List myOrder = snapshot.data.docs;
                            return _buildActiveProject(
                              data: myOrder,
                              crossAxisCount: 6,
                              crossAxisCellCount:
                                  (constraints.maxWidth < 1360) ? 3 : 2,
                              service: false,
                            );
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        }),//الطلبات الي بتيجي من ال client المتوافق عليها
                    const SizedBox(height: kSpacing),
                  ],
                ),
              ),
            ],
          );
        },
      )),
    );
  }

  Widget _buildHeader({Function()? onPressedMenu}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: Row(
        children: [
          if (onPressedMenu != null)
            Padding(
              padding: const EdgeInsets.only(right: kSpacing),
              child: IconButton(
                onPressed: onPressedMenu,
                icon: const Icon(
                  EvaIcons.menu,
                  color: Colors.black,
                ),
                tooltip: "menu",
              ),
            ),
          const Expanded(child: _Header()),
        ],
      ),
    );
  }

  Widget _buildTaskOverview({
    required List data,
    int crossAxisCount = 6,
    int crossAxisCellCount = 2,
    Axis headerAxis = Axis.horizontal,
  }) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: crossAxisCount,
      itemCount: data.length + 1,
      addAutomaticKeepAlives: false,
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return (index == 0)
            ? Padding(
                padding: const EdgeInsets.only(bottom: kSpacing),
                child: _OverviewHeader(
                  axis: headerAxis,
                ),
              )
            : TaskCard(
                data: data[index - 1],
                onPressedMore: () {},
                onPressedTask: () {},
                onPressedContributors: () {},
                onPressedComments: () {},
              );
      },
      staggeredTileBuilder: (int index) =>
          StaggeredTile.fit((index == 0) ? crossAxisCount : crossAxisCellCount),
    );
  }

  Widget _buildActiveProject({
    required List data,
    required bool service,
    int crossAxisCount = 6,
    int crossAxisCellCount = 2,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: _ActiveProjectCard(
        onPressedSeeAll: () {},
        title: service ? 'My Service' : 'My Order',
        child: StaggeredGridView.countBuilder(
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          itemCount: data.length,
          addAutomaticKeepAlives: false,
          mainAxisSpacing: kSpacing,
          crossAxisSpacing: kSpacing,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ProjectCard(data: data[index], service: service);
          },
          staggeredTileBuilder: (int index) =>
              StaggeredTile.fit(crossAxisCellCount),
        ),
      ),
    );
  }
}
