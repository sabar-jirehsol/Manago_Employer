
import 'Status.dart';

class Resource<T> {
  STATUS? status;
  T? data;
  String? message;

  Resource({this.status, this.data, this.message});

  static Resource success({data}) => Resource(status: STATUS.SUCCESS, data: data, message: null);
  static Resource error({data,message}) => Resource(status: STATUS.ERROR, data: data, message: message);
  static Resource loading({data}) => Resource(status: STATUS.LOADING, data: data, message: null);


  @override
  String toString() {
    return 'Resource{status: $status, data: $data, message: $message}';
  }

  Resource copyWith({STATUS? status, T? data, String? messege}){
    return Resource(status: status??this.status,data: data??this.data,message: messege??this.message);
  }

}


