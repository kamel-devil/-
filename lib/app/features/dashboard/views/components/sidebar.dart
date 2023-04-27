part of dashboard;

class _Sidebar extends StatelessWidget {
  const _Sidebar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      child: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          children: [
            const Divider(thickness: 1),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("craftsman")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('services')
                    .snapshots(),
                builder: (context,AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    List count = snapshot.data.docs;
                    return SelectionButton(
                      data: [
                        SelectionButtonData(
                          activeIcon: EvaIcons.grid,
                          icon: EvaIcons.gridOutline,
                          label: "Dashboard",
                        ),
                        SelectionButtonData(
                          activeIcon: EvaIcons.archive,
                          icon: EvaIcons.archiveOutline,
                          label: "Reports",
                        ),
                        SelectionButtonData(
                          activeIcon: EvaIcons.calendar,
                          icon: Icons.add,
                          label: "Add Service",
                        ),
                        SelectionButtonData(
                          activeIcon: EvaIcons.email,
                          icon: EvaIcons.emailOutline,
                          label: "Services",
                          totalNotif: count.length,
                        ),
                        SelectionButtonData(
                          activeIcon: EvaIcons.person,
                          icon: EvaIcons.personOutline,
                          label: "Profil",
                        ),
                        SelectionButtonData(
                          activeIcon: EvaIcons.settings,
                          icon: EvaIcons.settingsOutline,
                          label: "Setting",
                        ),
                        SelectionButtonData(
                          activeIcon: EvaIcons.settings,
                          icon: EvaIcons.settingsOutline,
                          label: "Log Out",
                        ),
                      ],
                      onSelected: (index, value) {
                        if (index == 2) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Category()));
                        } else if (index == 3) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ListOfCategory()));
                        } else if (index == 4) {
                        } else if (index == 5) {
                        } else if (index == 6) {}
                      },
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
            const Divider(thickness: 1),
            const SizedBox(height: kSpacing * 2),
            UpgradePremiumCard(
              backgroundColor: Theme.of(context).canvasColor.withOpacity(.4),
              onPressed: () {},
            ),
            const SizedBox(height: kSpacing),
          ],
        ),
      ),
    );
  }

}
