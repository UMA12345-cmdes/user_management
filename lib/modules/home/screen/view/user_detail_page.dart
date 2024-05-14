import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_management/config/app_constant/string_constant.dart';
import 'package:user_management/modules/home/bloc/user_list/user_bloc.dart';
import 'package:user_management/widget/dialog/logout_dialog.dart';

class UserDetailPage extends StatefulWidget {
  const UserDetailPage({super.key});

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  late UserBloc userBloc;
  @override
  void initState() {
    userBloc = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(AppStringConstant.userDetail),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Align(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: CachedNetworkImage(
                  imageUrl: userBloc.user.avatar ?? '',
                  height: 100,
                  width: 100,
                  errorWidget: (_, __, ___) {
                    return const Icon(
                      Icons.error,
                      size: 100,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: <Widget>[
                userInfo(Icons.info_rounded, userBloc.user.id.toString()),
                const Divider(),
                userInfo(Icons.person, userBloc.user.name ?? ''),
                const Divider(),
                userInfo(Icons.mail, userBloc.user.email ?? ''),
                const Divider(),
                userInfo(Icons.person, userBloc.user.role ?? ''),
                const Divider(),
                userInfo(Icons.password, userBloc.user.password ?? ''),
                const SizedBox(height: 40),
                TextButton(
                  onPressed: () {
                    showLogoutDialog(context);
                  },
                  child: const Text(AppStringConstant.logout),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget userInfo(IconData icon, String label) {
    final ThemeData theme = Theme.of(context);
    return Row(
      children: <Widget>[
        Icon(icon, color: theme.colorScheme.primary),
        const SizedBox(width: 20),
        Expanded(child: Text(label)),
      ],
    );
  }
}
