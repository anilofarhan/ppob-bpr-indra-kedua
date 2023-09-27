import 'package:ppob/core/model/response.dart';
import 'package:ppob/features/transaction/internet/bloc/internet_bloc.dart';
import 'package:ppob/features/transaction/model/transaction_response_model.dart';

abstract class InternetRepository {
  Future<BaseResponse<List<TransactionResponseModel>>> inquiryInternet(InquiryInternetEvent event);
  Future<BaseResponse<List<TransactionResponseModel>>> paymentInternet(PaymentInternetEvent event);
}
