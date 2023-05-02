part of dashboard;

class _ProfilTile extends StatelessWidget {
  const _ProfilTile(
      {required this.data, required this.onPressedNotification, Key? key})
      : super(key: key);

  final _Profile data;
  final Function() onPressedNotification;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: CircleAvatar(backgroundImage: data.photo),
      title: Text(
        data.name,
        style: const TextStyle(fontSize: 14, color:Colors.black),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        data.email,
        style: const TextStyle(fontSize: 12, color:Colors.black),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: IconButton(
        onPressed: onPressedNotification,
        icon: const Icon(EvaIcons.bellOutline,color:Colors.black),
        tooltip: "notification",
      ),
    );
  }
}
