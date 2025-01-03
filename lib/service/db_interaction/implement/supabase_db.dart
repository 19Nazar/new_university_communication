import 'package:new_university_communication/service/db_interaction/db_interaction.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:new_university_communication/models/models.dart';

class SupabaseDbInteraction implements DbInteraction {
  late SupabaseClient supabase;

  SupabaseDbInteraction({required SupabaseClient client}) {
    this.supabase = client;
    this.supabase.auth;
  }

  factory SupabaseDbInteraction.defaultInstance() {
    return SupabaseDbInteraction(client: Supabase.instance.client);
  }

  @override
  Future<DBRespons> create(
      {required Map<String, dynamic> data, required String table_name}) async {
    try {
      final response = await supabase.from(table_name).insert(data).select();
      if (response.contains("error")) {
        return DBRespons(status: Status.fail, data: response);
      }
      return DBRespons(status: Status.successful, data: response);
    } catch (error) {
      throw Exception("Error create data: $error");
    }
  }

  @override
  Future<DBRespons> read({
    Object? filter,
    required String table_name,
    String? select,
    String? filterColumn,
    String? filterColumnIn,
    List<dynamic>? filterIn,
  }) async {
    select = select ?? "*";
    try {
      var query = supabase.from(table_name).select(select);

      if (filter != null && filterColumn != null) {
        query = query.eq(filterColumn, filter);
      }

      if (filterIn != null && filterColumnIn != null) {
        query = query.inFilter(filterColumnIn, filterIn);
      }

      final response = await query;
      if (response.contains("error")) {
        return DBRespons(status: Status.fail, data: response);
      }
      return DBRespons(status: Status.successful, data: response);
    } catch (error) {
      throw Exception("Error while read db: $error");
    }
  }

  @override
  Future<DBRespons> update(
      {required String table_name,
      required int id,
      required Map<String, dynamic> data}) async {
    try {
      final response =
          await supabase.from(table_name).update(data).eq('id', id).select();
      if (response.contains("error")) {
        return DBRespons(status: Status.fail, data: response);
      }
      return DBRespons(status: Status.successful, data: response);
    } catch (error) {
      throw Exception("Error while update db: $error");
    }
  }

  @override
  Future<DBRespons> delete({
    required int id,
    required String table_name,
  }) async {
    try {
      final response =
          await supabase.from(table_name).delete().eq('id', id).select();
      if (response.contains("error")) {
        return DBRespons(status: Status.fail, data: response);
      }
      return DBRespons(status: Status.successful, data: response);
    } catch (error) {
      throw Exception("Error while update db: $error");
    }
  }

  Future<DBRespons> fetchEventHistoryWithRpc({required int id}) async {
    try {
      final supabase = Supabase.instance.client;

      final response = await supabase
          .rpc('get_event_history_bigint', params: {'group_id': id}).select();

      return DBRespons(data: response, status: Status.successful);
    } catch (error) {
      throw Exception("error ${error}");
    }
  }
}
