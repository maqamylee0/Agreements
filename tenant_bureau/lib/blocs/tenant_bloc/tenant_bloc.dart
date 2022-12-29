import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../dashboard/home/Tenants.dart';
import '../../dashboard/home/addTenant/models/tenant.dart';
import '../../dashboard/home/list_tenants/data/repository/tenant_repo.dart';

part 'tenant_event.dart';
part 'tenant_state.dart';

class TenantBloc extends Bloc<TenantEvent, TenantState> {
  TenantBloc() : super(TenantState()) {
    on<LoadTenants>((event, emit) async {
      var listOfArticles = await state.getTenants();
      var newState = TenantState(listOfTenants: listOfArticles);
      emit(newState);
    });
  }
}
