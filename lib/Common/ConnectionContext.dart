// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, file_names

import 'package:postgres/postgres.dart';
import 'package:vexa_show_do_bilionario/routes_private.dart';

class ConectionContext {
  Future<PostgreSQLConnection> OpenConnection() async {
    PostgreSQLConnection connection = PostgreSQLConnection(ipBanco, 5432, userBanco, username: userBancoPost, password: passwordBanco);
    await connection.open();
    return connection;
  }

  void CloseConnection(PostgreSQLConnection connection) {
    connection.close();
  }

  Future<PostgreSQLResult> ConsultSQLString(String sql) async {
    PostgreSQLConnection connection = await OpenConnection();
    var result;
    await connection.transaction((ctx) async {
      result = await ctx.query(sql);
    });

    CloseConnection(connection);
    return result;
  }
}
