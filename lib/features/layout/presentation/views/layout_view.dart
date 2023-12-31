// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:social_app/cubit/cubit.dart';
// import 'package:social_app/cubit/states.dart';
// import '../../../new_post/new_post_screen.dart';
// import '../../../../shared/components/components.dart';

// class MediaXLayout extends StatelessWidget {
//   const MediaXLayout({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<SocialCubit, SocialStates>(
//       listener: ((context, state) {
//         if (state is SocialNewPostState) {
//           navigateTo(context, NewPostScreen());
//         }
//       }),
//       builder: ((context, state) {
//         var cubit = SocialCubit.get(context);
//         return Scaffold(
//           // appBar: AppBar(
//           //   title: Text(cubit.titles[cubit.currentIndex]),
//           //   actions: [
//           //     IconButton(
//           //         onPressed: () {
//           //           AppCubit.get(context).changeAppMode();
//           //         },
//           //         icon: const Icon(Icons.brightness_4_outlined)),
//           //     IconButton(
//           //         onPressed: () {},
//           //         icon: const Icon(
//           //           Icons.search_rounded,
//           //           size: 30,
//           //         )),
//           //   ],
//           // ),
//           body: cubit.screens[cubit.currentIndex],
//           bottomNavigationBar: Container(
//             decoration: BoxDecoration(),
//             child: BottomNavigationBar(
//               currentIndex: cubit.currentIndex,
//               onTap: ((value) {
//                 cubit.changeBottomNav(value);
//               }),
//               items: const [
//                 BottomNavigationBarItem(
//                     icon: Icon(
//                       Icons.home,
//                       size: 25,
//                     ),
//                     label: 'Home'),
//                 BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
//                 BottomNavigationBarItem(
//                     icon: Icon(Icons.label_important_outlined),
//                     label: 'Services'),
//                 BottomNavigationBarItem(
//                     icon: Icon(Icons.person), label: 'Profile'),
//               ],
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/utils/app_color.dart';
import 'package:social_app/features/layout/presentation/cubit/layout_cubit.dart';
import 'package:social_app/features/layout/presentation/cubit/layout_state.dart';

class MediaXLayout extends StatelessWidget {
  const MediaXLayout({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocBuilder<LayoutCubit, LayoutState>(
      builder: (context, state) {
        return Scaffold(
          body: cubit.views()[cubit.currentIndex],
          bottomNavigationBar: bottomNavBar(cubit, context),
        );
      },
    );
  }

  BottomNavigationBar bottomNavBar(LayoutCubit cubit, BuildContext context) {
    return BottomNavigationBar(
      elevation: 20,
      selectedItemColor: AppColors.primaryColor,
      // unselectedIconTheme: const IconThemeData(color: AppColors.iconsColor),
      // unselectedLabelStyle: AppTextStyles.textStyle8Regular.copyWith(
      //   fontWeight: FontWeight.bold,
      // ),
      currentIndex: cubit.currentIndex,
      onTap: (value) {
        cubit.changeBottomNav(value, context);
      },
      showSelectedLabels: true,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: "Home",
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.message_outlined), label: "Message"),
        BottomNavigationBarItem(
            icon: Icon(Icons.label_important_outline), label: "Cart"),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined), label: "Profile"),
      ],
    );
  }
}
