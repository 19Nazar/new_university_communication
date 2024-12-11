enum Status { successful, fail }

class DBRespons {
  late List<Map<String, dynamic>> data;
  late Status status;

  DBRespons(
      {required List<Map<String, dynamic>> data, required Status status}) {
    this.data = data;
    this.status = status;
  }
}
