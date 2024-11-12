import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:perfection/perfection/presentation/manager/resources/color_manager.dart';
import 'package:perfection/perfection/presentation/manager/resources/styles_manager.dart';
import 'package:perfection/perfection/presentation/pages/home/view/user_details_view.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../data/models/user_list_model.dart';
import '../../../../data/repositories/user_list_provider.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  UserListScreenState createState() => UserListScreenState();
}

class UserListScreenState extends State<UserListScreen> {
  final List<User> _users = [];
  int page = 1;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchUsers(); // Initial fetch for page 1
  }

  Future<void> _fetchUsers() async {
    if (isLoading) return; // Prevent multiple requests at once
    setState(() {
      isLoading = true;
    });

    try {
      List<User> users = await ApiService.fetchUsers(page);
      setState(() {
        _users.clear(); // Clear the list to show only the current page's users
        _users.addAll(users);
      });
    } catch (e) {
      print("Failed to fetch users: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _nextPage() {
    setState(() {
      page++;
    });
    _fetchUsers();
  }

  void _previousPage() {
    if (page > 1) {
      setState(() {
        page--;
      });
      _fetchUsers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('userList'.tr(), style: AppTextStyles.largeTitle20),
        actions: [
          IconButton(
            onPressed: () {
              showMenu(
                context: context,
                position: context.locale == const Locale('en')
                    ? RelativeRect.fromSize(
                    const Rect.fromLTRB(300, 80, 10, 5), Size.infinite)
                    : RelativeRect.fromSize(
                    const Rect.fromLTRB(10, 80, 100, 5), Size.infinite),
                color: ColorManager.grey1,
                items: [
                  const PopupMenuItem(
                    value: Locale('en'),
                    child: Text('English'),
                  ),
                  const PopupMenuItem(
                    value: Locale('ar'),
                    child: Text('العربية'),
                  ),
                ],
              ).then((Locale? locale) {
                if (locale != null) {
                  context.setLocale(locale);
                }
              });
            },
            icon: const Icon(
              Icons.language,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "chooseUser".tr(),
              style: AppTextStyles.largeTitle18,
            ),
            const SizedBox(height: 18),
            Expanded(
              child: ListView.separated(
                itemCount: _users.length + (isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == _users.length) {
                    return Center(
                      child: SpinKitRotatingCircle(
                        color: ColorManager.primary,
                        size: 50.0,
                      ),
                    );
                  }
                  final user = _users[index];
                  return Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26),
                        color: ColorManager.grey),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user.avatar),
                      ),
                      title: Text(
                        '${user.firstName} ${user.lastName}',
                        style: AppTextStyles.mediumTitle14,
                      ),
                      trailing: Icon(Icons.arrow_forward_ios,
                          color: ColorManager.primary),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              UserDetailsScreen(userId: user.id),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: _previousPage,
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: page > 1 ? ColorManager.primary : Colors.grey,
                  ),
                ),
                const SizedBox(width: 15),
                Text(
                  page.toString(),
                  style: AppTextStyles.largeTitle18,
                ),
                const SizedBox(width: 20),
                InkWell(
                  onTap: _nextPage,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: ColorManager.primary,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

