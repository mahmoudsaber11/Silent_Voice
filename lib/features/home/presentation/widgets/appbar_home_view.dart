import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/routes/routes.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/core/utils/app_text_style.dart';

class AppbarHomeView extends StatelessWidget {
  const AppbarHomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          Text(
            "Media X",
            style: AppTextStyles.textStyle25,
          ),
          Spacer(),
          IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                context.navigateTo(routeName: Routes.postViewRoute);
              },
              icon: Icon(
                Icons.add,
                size: 28,
              )),
          IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              icon: Icon(
                Icons.notifications_none_outlined,
                size: 28,
              )),
        ],
      ),
    );
  }
}
