import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/app_color.dart';
import 'package:social_app/features/layout/presentation/cubit/layout_cubit.dart';

class CustomSignOutButtom extends StatelessWidget {
  const CustomSignOutButtom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(AppColors.primaryColor)),
        onPressed: () {
          BlocProvider.of<LayoutCubit>(context).signOut(context);
        },
        child: Row(
          children: [
            const Text(
              'SignOut',
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(
              width: 10,
            ),
            Icon(
              Icons.logout,
              size: 20.sp,
              color: Colors.white,
            ),
          ],
        ));
  }
}
