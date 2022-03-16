import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybook_flutter/src/blocs/notification_bloc/notification_bloc.dart';
import 'package:mybook_flutter/src/models/notification_model.dart';
import 'package:mybook_flutter/src/resources/responsitory/notification_repo.dart';
import 'package:mybook_flutter/src/ui/themes/colors.dart';
import 'package:mybook_flutter/src/ui/widgets/stateless/transparent_appbar.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationBloc(data: NotificationRepository())..add(NotificationFecthData()),
      child: Scaffold(
        appBar: TransparentAppBar("Notifications", AppColors.primary),
        extendBodyBehindAppBar: true,
        body: BlocBuilder<NotificationBloc, NotificationState>(
          builder: (context, state) {
           if (state is NotificationLoading){
             return const Center(
               child: CircularProgressIndicator()
             );
           }
           if (state is NotificationSuccess ){
             var notifications = BlocProvider.of<NotificationBloc>(context, listen: true).data.sortByTime();
             return Container(
               padding: const EdgeInsets.only(top: 80),
               child: ListView.separated(
                 padding: EdgeInsets.zero,
                 itemCount: notifications.length, 
                 separatorBuilder: (BuildContext context, int index) => const Divider(), 
                 itemBuilder: (BuildContext context, int index) => notifications[index].showNotification(),
                 
                 
               ),
             );
           } else{
             return const Center(
               child: Text("Notification error")
             );
           }

          },
        ),
      ),  
    );
  }
}
