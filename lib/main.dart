import 'package:amval/src/config/storage/constants.dart';
import 'package:amval/src/presentation/logic/cubit/staff/edit_staff_cubit.dart';
import 'package:camera/camera.dart';

import 'package:flutter/material.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/config/route_generator.dart';
import 'src/data/repositories/assignment_api.dart';
import 'src/data/repositories/category_api.dart';
import 'src/data/repositories/instrument_api.dart';
import 'src/data/repositories/instrument_pieces_api.dart';
import 'src/data/repositories/login_api.dart';
import 'src/data/repositories/staff_api.dart';
import 'src/data/repositories/unit_api.dart';
import 'src/presentation/logic/cubit/assignment/assignment_cubit.dart';
import 'src/presentation/logic/cubit/assignment/create_assignment_cubit.dart';
import 'src/presentation/logic/cubit/category/category_cubit.dart';
import 'src/presentation/logic/cubit/category/create_category_cubit.dart';
import 'src/presentation/logic/cubit/instrument/add_instrument_cubit.dart';
import 'src/presentation/logic/cubit/instrument/instrument_cubit.dart';
import 'src/presentation/logic/cubit/instrument/set_capture_cubit.dart';
import 'src/presentation/logic/cubit/instrument/set_category_add_instrument_cubit.dart';
import 'src/presentation/logic/cubit/instrument/set_unit_add_instrument_cubit.dart';
import 'src/presentation/logic/cubit/instrument_pieces/instrument_pieces_cubit.dart';
import 'src/presentation/logic/cubit/login_cubit.dart';
import 'src/presentation/logic/cubit/staff/add_staff_cubit.dart';
import 'src/presentation/logic/cubit/staff/retrieve_staff_cubit.dart';
import 'src/presentation/logic/cubit/staff/staff_cubit.dart';
import 'src/presentation/logic/cubit/unit/create_unit_cubit.dart';
import 'src/presentation/logic/cubit/unit/unit_cubit.dart';


void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late List cameras ;
  @override
  void initState() {
    super.initState();
    getCameras();
  }

  Future<void> getCameras() async {
    cameras = await availableCameras();
    camera = cameras.first;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(repository: APILogin()),
        ),
        BlocProvider(
          create: (context) => CategoryCubit(repository: APICategory()),
        ),
        BlocProvider(
          create: (context) => CreateCategoryCubit(repository: APICategory()),
        ),
        BlocProvider(
          create: (context) => AddStaffCubit(repository: APIStaff()),
        ),
        BlocProvider(
          create: (context) => UnitCubit(repository: APIUnit()),
        ),
        BlocProvider(
          create: (context) => AddInstrumentCubit(repository: APIInstrument()),
        ),
        BlocProvider(
          create: (context) => CreateUnitCubit(repository: APIUnit()),
        ),
        BlocProvider(
          create: (context) => InstrumentCubit(repository: APIInstrument()),
        ),
        BlocProvider(
          create: (context) => SetUnitAddInstrumentCubit(repository: APIUnit()),
        ),
        BlocProvider(
          create: (context) => SetCategoryAddInstrumentCubit(repository: APICategory()),
        ),
        BlocProvider(
          create: (context) => StaffCubit(repository: APIStaff()),
        ),
        BlocProvider(
          create: (context) => AssignmentCubit(repository: APIassignment()),
        ),
        BlocProvider(
          create:  (context) => SetCaptureCubit(),
        ),
        BlocProvider(
          create:  (context) => InstrumentPiecesCubit(repository: APIInstrumentPieces()),
        ),
        BlocProvider(
          create:  (context) => RetrieveStaffCubit(repository: APIStaff()),
        ),
        BlocProvider(
          create:  (context) => CreateAssignmentCubit(repository: APIassignment()),
        ),
        BlocProvider(
          create:  (context) => EditStaffCubit(repository: APIStaff()),
        ),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, widget) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: SafeArea(child: widget!),
          );
        },
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.indigo,
          ).copyWith(
            secondary: const Color.fromRGBO(	154, 103, 234,1),
          ),
          textTheme: PersianFonts.sahelTextTheme,
          backgroundColor: const Color.fromRGBO(95,95,196,1),
          scaffoldBackgroundColor: const Color.fromRGBO(
              232, 232, 232, 1.0),
        ),
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
