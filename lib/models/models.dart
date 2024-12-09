enum Status { successful, fail }

class DBRespons {
  dynamic data;
  late Status status;

  DBRespons({required dynamic data, required Status status}) {
    this.data = data;
    this.status = status;
  }
}
