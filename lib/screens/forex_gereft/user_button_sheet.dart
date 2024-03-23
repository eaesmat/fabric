import 'package:fabricproject/controller/forex_gereft_controller.dart';
import 'package:fabricproject/controller/user_controller.dart';
import 'package:fabricproject/helper/helper_methods.dart';
import 'package:fabricproject/widgets/custom_refresh_indicator.dart';
import 'package:fabricproject/widgets/no_data_found.widget.dart';
import 'package:flutter/material.dart';
import 'package:fabricproject/theme/pallete.dart';
import 'package:fabricproject/widgets/custom_text_filed_with_controller.dart';
import 'package:fabricproject/widgets/list_tile_widget.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class UserListBottomSheet extends StatefulWidget {
  const UserListBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<UserListBottomSheet> createState() => _UserListBottomSheetState();
}

class _UserListBottomSheetState extends State<UserListBottomSheet> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Reset search filter after the build cycle is complete
      Provider.of<UserController>(context, listen: false).resetSearchFilter();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context);
    final forexGereftController = Provider.of<ForexGereftController>(context);

    return CustomRefreshIndicator(
      onRefresh: () async {
        // Implement your refresh logic here
        await Provider.of<UserController>(context, listen: false).getAllUsers();
      },
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: Container(
          margin: EdgeInsets.zero,
          height: MediaQuery.of(context).size.height * 0.9,
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
          color: Pallete.whiteColor,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: CustomTextFieldWithController(
                  iconBtn: IconButton(
                    icon: const Icon(
                      Icons.add_box,
                      color: Pallete.blueColor,
                    ),
                    onPressed: () {
                      // colorsController.navigateToColorCreate();
                    },
                  ),
                  lblText: const LocaleText('search'),
                  onChanged: (value) {
                    userController.searchUsersMethod(value);
                  },
                ),
              ),
              Expanded(
                child: userController.searchUsers.isEmpty
                    ? const NoDataFoundWidget() // Show NoDataFoundWidget if the list is empty
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: userController.searchUsers.length,
                        itemBuilder: (context, index) {
                          final reversedList =
                              userController.searchUsers.reversed.toList();
                          final data = reversedList[index];

                          return ListTileWidget(
                            onTap: () {
                              forexGereftController.selectedUserIdController
                                  .text = data.userId.toString();
                              forexGereftController.selectedUserNameController
                                  .text = data.name.toString();
                              Navigator.pop(context);
                            },
                            lead: CircleAvatar(
                              backgroundColor:
                                  getColorFromName(data.userImage.toString()),
                            ),
                            tileTitle: Row(
                              children: [
                                Text(data.name ?? ''),
                                const Spacer(),
                                Text(data.surname ?? ''),
                              ],
                            ),
                            tileSubTitle: Text(
                              data.address?.toString() ?? '',
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
