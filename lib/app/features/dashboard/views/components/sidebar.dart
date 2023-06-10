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
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('craftsman')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data!;
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            data['image'] == 'null'
                                ? data['gender'] == 'female'
                                    ? Image.asset('assets/images/woman.png',
                                            height: 70,
                                            width: 70,
                                            fit: BoxFit.cover)
                                        .cornerRadiusWithClipRRect(40)
                                    : Image.asset('assets/images/man.png',
                                            height: 70,
                                            width: 70,
                                            fit: BoxFit.cover)
                                        .cornerRadiusWithClipRRect(40)
                                : Image.network(data['image'],
                                        height: 70,
                                        width: 70,
                                        fit: BoxFit.cover)
                                    .cornerRadiusWithClipRRect(40),
                            16.width,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(data['name'], style: primaryTextStyle()),
                                2.height,
                                Text(data['email'],
                                    maxLines: 3, style: primaryTextStyle()),
                              ],
                            )
                          ],
                        ),
                        IconButton(
                          icon: const Icon(
                            AntDesign.edit,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfileEdit(
                                          phone: data['phone'],
                                          name: data['name'],
                                          image: data['image'],
                                          gender: data['gender'],
                                        )));
                          },
                        ).visible(true)
                      ],
                    ).paddingAll(16);
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
            const Divider(thickness: 1),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("craftsman")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('services')
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    List count = snapshot.data.docs;
                    return StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("craftsman")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection('requests')
                            .snapshots(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            List count1 = snapshot.data.docs;
                            return SelectionButton(
                              data: [
                                SelectionButtonData(
                                  activeIcon: EvaIcons.archive,
                                  icon: EvaIcons.archiveOutline,
                                  label: "Contracts",
                                  totalNotif: count1.length,
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
                                  activeIcon: EvaIcons.refresh,
                                  icon: EvaIcons.settingsOutline,
                                  label: "Change Password",
                                ),
                                SelectionButtonData(
                                  activeIcon: EvaIcons.settings,
                                  icon: EvaIcons.logOut,
                                  label: "Log Out",
                                ),
                              ],
                              onSelected: (index, value) {
                                if (index == 0) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ListOfRequested()));
                                } else if (index == 1) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Service()));
                                } else if (index == 2) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ListOfService()));
                                } else if (index == 3) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const DTChangePasswordScreen()));
                                } else if (index == 4) {
                                  _signOut().whenComplete(() =>
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginScreen())));
                                }
                              },
                            );
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        });
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
            const Divider(thickness: 1),
            const SizedBox(height: kSpacing * 2),
            UpgradePremiumCard(
              backgroundColor: Theme.of(context).canvasColor.withOpacity(1),
              onPressed: () {},
            ),
            const SizedBox(height: kSpacing),
          ],
        ),
      ),
    );
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
