library dashboard;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:project_management/app/constans/app_constants.dart';
import 'package:project_management/app/shared_components/chatting_card.dart';
import 'package:project_management/app/shared_components/get_premium_card.dart';
import 'package:project_management/app/shared_components/progress_card.dart';
import 'package:project_management/app/shared_components/progress_report_card.dart';
import 'package:project_management/app/shared_components/responsive_builder.dart';
import 'package:project_management/app/shared_components/upgrade_premium_card.dart';
import 'package:project_management/app/shared_components/project_card.dart';
import 'package:project_management/app/shared_components/search_field.dart';
import 'package:project_management/app/shared_components/selection_button.dart';
import 'package:project_management/app/shared_components/task_card.dart';
import 'package:project_management/app/shared_components/today_text.dart';
import 'package:project_management/app/utils/helpers/app_helpers.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../../../../login/screens/login.dart';
import '../../add_servecie/category.dart';
import '../../add_servecie/listofcategory.dart';

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
part '../components/recent_messages.dart';
part '../components/sidebar.dart';
part '../components/team_member.dart';

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
            const SizedBox(height: kSpacing / 2),
            const Divider(),
            _buildProfile(data: controller.getProfil()),
            const SizedBox(height: kSpacing),
            _buildProgress(axis: Axis.vertical),
            const SizedBox(height: kSpacing),
            // _buildTeamMember(data: controller.getMember()),
            const SizedBox(height: kSpacing),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kSpacing),
              child: GetPremiumCard(onPressed: () {}),
            ),
            const SizedBox(height: kSpacing * 2),
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
                      crossAxisCount: 6,
                      crossAxisCellCount:6,
                    );
                  } else {
                    return const Center(
                        child: CircularProgressIndicator());
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
                    _buildHeader(onPressedMenu: () => controller.openDrawer()),
                    const SizedBox(height: kSpacing * 2),
                    _buildProgress(
                      axis: (constraints.maxWidth < 950)
                          ? Axis.vertical
                          : Axis.horizontal,
                    ),
                    const SizedBox(height: kSpacing * 2),
                    _buildTaskOverview(
                      data: controller.getAllTask(),
                      headerAxis: (constraints.maxWidth < 850)
                          ? Axis.vertical
                          : Axis.horizontal,
                      crossAxisCount: 6,
                      crossAxisCellCount: (constraints.maxWidth < 950)
                          ? 6
                          : (constraints.maxWidth < 1100)
                              ? 3
                              : 2,
                    ),
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
                    _buildProfile(data: controller.getProfil()),
                    const Divider(thickness: 1),
                    const SizedBox(height: kSpacing),
                    // _buildTeamMember(data: controller.getMember()),
                    const SizedBox(height: kSpacing),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
                      child: GetPremiumCard(onPressed: () {}),
                    ),
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
                flex: (constraints.maxWidth < 1360) ? 4 : 3,
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
                    const SizedBox(height: kSpacing),
                    _buildHeader(),
                    const SizedBox(height: kSpacing * 2),
                    _buildProgress(),
                    const SizedBox(height: kSpacing * 2),
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
                              crossAxisCount: 6,
                              crossAxisCellCount:
                                  (constraints.maxWidth < 1360) ? 3 : 2,
                            );
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        }),
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
                        }),
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
                        }),
                    const SizedBox(height: kSpacing),
                  ],
                ),
              ),
              // Flexible(
              //   flex: 4,
              //   child: Column(
              //     children: [
              //       const SizedBox(height: kSpacing / 2),
              //       FutureBuilder(
              //         future: getInfoProfile(),
              //         builder: (context,snapshot) {
              //           if(snapshot.hasData){
              //             List infoPro =snapshot.data as List;
              //             return _buildProfile(data: controller.getProfil());
              //
              //           }else{
              //             return const Center(child: CircularProgressIndicator());
              //           }
              //         }
              //       ),
              //       const Divider(thickness: 1),
              //       const SizedBox(height: kSpacing),
              //       // _buildTeamMember(data: controller.getMember()),
              //       const SizedBox(height: kSpacing),
              //       Padding(
              //         padding: const EdgeInsets.symmetric(horizontal: kSpacing),
              //         child: GetPremiumCard(onPressed: () {}),
              //       ),
              //       const SizedBox(height: kSpacing),
              //       const Divider(thickness: 1),
              //       const SizedBox(height: kSpacing),
              //       // _buildRecentMessages(data: controller.getChatting()),
              //     ],
              //   ),
              // )
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
                icon: const Icon(EvaIcons.menu),
                tooltip: "menu",
              ),
            ),
          const Expanded(child: _Header()),
        ],
      ),
    );
  }

  Widget _buildProgress({Axis axis = Axis.horizontal}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: (axis == Axis.horizontal)
          ? FutureBuilder(
              future: getServices(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List count = snapshot.data as List;
                  return Row(
                    children: [
                      Flexible(
                        flex: 5,
                        child: ProgressCard(
                          data: ProgressCardData(
                            totalUndone: count.length,
                            totalTaskInProress: 2,
                          ),
                          onPressedCheck: () {},
                        ),
                      ),
                      const SizedBox(width: kSpacing / 2),
                      Flexible(
                        flex: 4,
                        child: ProgressReportCard(
                          data: ProgressReportCardData(
                            title: "All Order",
                            doneTask: 5,
                            percent: .3,
                            task: count.length,
                            undoneTask: 2,
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              })
          : Column(
              children: [
                ProgressCard(
                  data: const ProgressCardData(
                    totalUndone: 10,
                    totalTaskInProress: 2,
                  ),
                  onPressedCheck: () {},
                ),
                const SizedBox(height: kSpacing / 2),
                const ProgressReportCard(
                  data: ProgressReportCardData(
                    title: "1st Sprint",
                    doneTask: 5,
                    percent: .3,
                    task: 3,
                    undoneTask: 2,
                  ),
                ),
              ],
            ),
    );
  }

  Future getServices() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore
        .collection("craftsman")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('services')
        .get();
    return qn.docs;
  }
  Future getInfoProfile() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore
        .collection("craftsman")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('services')
        .get();
    return qn.docs;
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
                  onSelected: (task) {},
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

  Future getMyServices() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore
        .collection("craftsman")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('services')
        .get();
    return qn.docs;
  }

  Widget _buildProfile({required _Profile data}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: _ProfilTile(
        data: data,
        onPressedNotification: () {},
      ),
    );
  }
}
