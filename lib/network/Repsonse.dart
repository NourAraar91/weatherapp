class Response<T> {
  Response.loading(this.message) : status = Status.LOADING;
  Response.completed(this.data) : status = Status.COMPLETED;
  Response.error(this.message) : status = Status.ERROR;

  Status status;
  T data;
  String message;

  @override
  String toString() {
    return 'Status : $status \n Message : $message \n Data : $data';
  }
}

enum Status { LOADING, COMPLETED, ERROR }
