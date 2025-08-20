import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salesdoc_clone/bloc/app_bloc.dart';
import 'package:salesdoc_clone/bloc/app_state.dart';
import 'package:salesdoc_clone/pages/main/dashbord_page.dart';
import 'package:salesdoc_clone/utils/app_layout/app_layout.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => AppBloc())],
      child: MaterialApp(
        title: 'SalesDoc Clone',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const AppContainer(),
      ),
    );
  }
}

class AppContainer extends StatelessWidget {
  const AppContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        if (state is AppStateWithPage) {
          Widget currentPage;
          switch (state.activePage) {
            case 'Dashboard':
              currentPage = const DashbordPage();
              break;
            case 'Documents':
              // Bu yerga Documents sahifasi keladi
              currentPage = Center(child: Text('Documents'));
              break;
            case 'Clients':
              // Bu yerga Clients sahifasi keladi
              currentPage = Center(child: Text('Documents'));
              {}
              break;
            default:
              currentPage = const DashbordPage();
              break;
          }
          // AppLayout widgetini qaytaramiz va unga o'zgaruvchan kontentni beramiz
          return AppLayout(content: currentPage);
        }
        return const AppLayout(content: DashbordPage());
      },
    );
  }
}
