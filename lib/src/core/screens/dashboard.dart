
import 'package:amval/src/presentation/logic/cubit/category/category_cubit.dart';
import 'package:amval/src/presentation/logic/cubit/instrument/instrument_cubit.dart';
import 'package:amval/src/presentation/logic/cubit/staff/staff_cubit.dart';
import 'package:amval/src/presentation/logic/cubit/unit/unit_cubit.dart';
import 'package:amval/src/presentation/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'category/category.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("داشبورد"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Button(
                    icon: Icons.devices_rounded,
                    label: "وسایل",
                    onTap: () {
                      Navigator.pushNamed(context, "/instrument");
                      context.read<InstrumentCubit>().getList();
                    }),
                const SizedBox(width: 20,),
                Button(
                  icon: Icons.device_hub_rounded,
                  label: "دسته‌بندی‌ها",
                  onTap: () {
                    Navigator.pushNamed(context, "/category");
                    address = "/";
                    context.read<CategoryCubit>().getCategories(null);
                  },
                ),
              ],
            ),
            const SizedBox(height: 26,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Button(
                  onTap: () {
                    Navigator.pushNamed(context, "/unit");
                    context.read<UnitCubit>().getList();
                  },
                  icon: Icons.border_all,
                  label: "واحد‌ها",
                ),
                const SizedBox(width: 20,),
                Button(
                    onTap: () {
                      Navigator.pushNamed(context, "/staff");
                      context.read<StaffCubit>().getList();
                    },
                    icon: Icons.group,
                    label: "کارکنان"),
              ],
            ),
            const SizedBox(height: 125,)
          ],
        ),
      ),
    );
  }
}
