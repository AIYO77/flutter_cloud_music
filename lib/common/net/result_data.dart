class ResultData {
  dynamic data;
  bool result;
  int code;
  int? total;

  ResultData(this.data, this.result, this.code, {this.total});

  @override
  String toString() {
    return '$data';
  }
}
