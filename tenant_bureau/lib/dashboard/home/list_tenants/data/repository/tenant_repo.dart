
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../services/auth.dart';
import '../../../addTenant/models/tenant.dart';

class TenantRepository{
  var apiservice = Auth();

  Future<List<TenantModel>> getAllTenants () async {
    final prefs =  await SharedPreferences.getInstance();
    final String? landlorduid =  await prefs.getString('userid');
    return apiservice.getAllTenants("oavVaYkPgzXiu7mWBK0HyD9ylf23");
  }

}