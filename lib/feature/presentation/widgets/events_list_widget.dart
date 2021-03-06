import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_shedule_mobile/common/app_colors.dart';
import 'package:sport_shedule_mobile/feature/domain/entities/category_entity.dart';
import 'package:sport_shedule_mobile/feature/domain/entities/event_entity.dart';
import 'package:sport_shedule_mobile/feature/presentation/bloc/events_list_cubit/events_list_cubit.dart';
import 'package:sport_shedule_mobile/feature/presentation/bloc/events_list_cubit/events_list_state.dart';
import 'package:sport_shedule_mobile/feature/presentation/widgets/event_card_widget.dart';

class EventsListWidget extends StatelessWidget{
  final CategoryEntity category;

  const EventsListWidget({required this.category});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsListCubit, EventsListState>(builder: (context, state) {
      List<EventEntity> events = [];
      if (state is EventsListLoading){
        return _loadingIndicator();
      }
      else if (state is EventsListLoaded){
        events = state.eventsList;
      }
      else if (state is EventsListError){
        return Center(
          child: Text(
            state.message,
            style: TextStyle(
              color: AppColors.errorColor,
              fontSize: 25,
            ),
          ),
        );
      }
      return ListView.separated(
        itemBuilder: (context, index){
          return EventCardWidget(event: events[index]);
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: AppColors.orange,
          );
        },
        itemCount: events.length,
      );
    }
    );
  }

  Widget _loadingIndicator(){
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(
          color: AppColors.orange,
        ),
      ),
    );
  }
}