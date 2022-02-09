import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sizer/sizer.dart';
import 'package:stackly/services/notifications_helper.dart';
import 'configs/consts.dart';
import 'features/bottom_bar/bottom_bar_cubit.dart';
import 'features/bottom_bar/bottom_bar_view.dart';
import 'features/edit_page/edit_page_bloc.dart';
import 'features/new_page/new_page_bloc.dart';
import 'features/stack_page/stack_page_bloc.dart';
import 'features/stack_page/stack_page_event.dart';
import 'features/today_page/date_row/date_row_cubit.dart';
import 'features/today_page/sups_list/sups_list_bloc.dart';
import 'features/today_page/sups_list/sups_list_events.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  NotificationsHelper.init(initScheduled: true);

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => BottomAppBarCubit(),
      ),
      BlocProvider(
        create: (_) => DateRowCubit(),
      ),
      BlocProvider(
        create: (_) => StackPageBloc()..add(StackPageEventLoad()),
      ),
      BlocProvider(
        create: (_) => SupsListBloc()..add(SupsListEventLoad(dateTime: DateTime.now())),
      ),
      BlocProvider(
        create: (_) => NewPageBloc(),
      ),
      BlocProvider(
        create: (_) => EditPageBloc(),
      ),
    ],
    child: MyApp(),
  ));

}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    listenNotifications();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Sizer(
      builder: (
        BuildContext context,
        Orientation orientation,
        DeviceType deviceType,
      ) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Stackly',
          theme: ThemeData(
            backgroundColor: kBackGroundColor,
            primarySwatch: Colors.blue,
          ),
          home: const BottomNavigatorView(),
        );
      },
    );
  }
}

void listenNotifications()=>NotificationsHelper.onNotifications.stream.listen(onClickedNotifications);
void onClickedNotifications(String? payload) => print(payload);