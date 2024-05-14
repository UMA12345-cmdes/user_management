import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:user_management/config/routes/routes.dart';
import 'package:user_management/data/model/response_modal/user_detail_response.dart';
import 'package:user_management/modules/home/bloc/user_list/user_bloc.dart';

class UserDetail extends StatelessWidget {
  const UserDetail({super.key, required this.data});
  final List<UserDetailResponse> data;
  @override
  Widget build(BuildContext context) {
    return userLoadedWidget(data, context);
  }

  Widget userLoadedWidget(
      List<UserDetailResponse> userList, BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        },
        shrinkWrap: true,
        itemCount: userList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () {
              BlocProvider.of<UserBloc>(context).user = userList[index];
              context.pushNamed(AppRoute.userDetail);
            },
            subtitle: Text(userList[index].email ?? '',
                style: theme.textTheme.bodySmall
                    ?.copyWith(color: theme.colorScheme.primary)),
            title: Text(userList[index].name ?? '',
                style: theme.textTheme.bodyLarge
                    ?.copyWith(color: theme.colorScheme.secondary)),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: userList[index].avatar ?? '',
                height: 45,
                width: 45,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) {
                  return const Icon(Icons.error, size: 45);
                },
              ),
            ),
          );
        });
  }
}
