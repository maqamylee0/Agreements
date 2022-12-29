part of 'tenant_bloc.dart';


 class TenantState {
   List<TenantModel> listOfTenants;
  TenantState({this.listOfTenants = const []});

   Future<List<TenantModel>> getTenants() async {
     var repo = TenantRepository();

     return await repo.getAllTenants();
   }
 }


