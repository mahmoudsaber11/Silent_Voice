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
    return SizedBox(
      height: 55.h,
      width: MediaQuery.of(context).size.width * .9,
      child: ElevatedButton(
          style: const ButtonStyle(
              backgroundColor:
                  MaterialStatePropertyAll(AppColors.primaryColor)),
          onPressed: () {
            BlocProvider.of<LayoutCubit>(context).signOut(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.logout,
                size: 25.sp,
                color: Colors.white,
              ),
              SizedBox(
                width: 15.w,
              ),
              const Text(
                'Log out',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          )),
    );
  }
}
