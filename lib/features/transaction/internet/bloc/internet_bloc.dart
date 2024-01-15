import 'package:bloc/bloc.dart';
import 'package:ppob/core/bloc/bloc_event.dart';
import 'package:ppob/core/bloc/bloc_state.dart';
import 'package:ppob/core/constant/constants.dart';
import 'package:ppob/core/extention/common_extention.dart';
import 'package:ppob/features/transaction/internet/repositories/internet_repository.dart';
import 'package:ppob/features/transaction/model/transaction_response_model.dart';

part 'internet_event.dart';
part 'internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, BlocState> {
  final InternetRepository repository;

  InternetBloc(this.repository) : super(InitialState()) {
    on<InquiryInternetEvent>((event, emit) async {
      emit(ShowLoadingState());
      try {
        var results = await repository.inquiryInternet(event);
        emit(HideLoadingState());

        if (results.status == Constants.RC_SUKSES || results.status == Constants.RC_R00) {
          emit(InquiryInternetSuccessState(results.data!));
        } else if (results.status == Constants.RC_07 || results.status == Constants.RC_09) {
          emit(SessionExpiredState(results.description));
        } else {
          emit(ErrorState(message: results.description!.replaceAll("|", "\n\n")));
        }
      } catch (e) {
        emit(HideLoadingState());
        emit(ErrorState(message: e.toString()));
      }
    });

    on<PaymentInternetEvent>((event, emit) async {
      emit(ShowLoadingState());
      try {
        var results = await repository.paymentInternet(event);
        emit(HideLoadingState());

        if (results.status == Constants.RC_SUKSES || results.status == Constants.RC_R00) {
          emit(PaymentInternetSuccessState(results.data!));
        } else if (results.status == Constants.RC_07 || results.status == Constants.RC_09) {
          emit(SessionExpiredState(results.description));
        } else {
          emit(ErrorState(message: results.description!.replaceAll("|", "\n\n")));
        }
      } catch (e) {
        emit(HideLoadingState());
        emit(ErrorState(message: e.toString()));
      }
    });
  }

  // String fileName = "";
  generatePaymentIndiHomeContent(TransactionResponseModel data) {

    List<String> col1 = data.customerData!.replaceAll("\$", "").replaceAll("'", "").trim().split("_");
    // List<String> col1 = "231122131357 _TELEPON_02175910000_DUM""MY TELKOM IPN-01_JPA            :_-___JAN 2014-      46.35500____46355_3000__'49355_".replaceAll("\$", "").replaceAll("'", "").trim().split("_");
    // List<String> col1 = "221122174344 _TELEPON_02175910000_DUM""MY TELKOM IPN-01_JPA            :_-___JAN 2014-      46.35500____46355_3000__'49355_".replaceAll("\$", "").replaceAll("'", "").trim().split("_");
    // print("data2 "+col1[0]+" "+col1[1]+" "+" "+col1[2]+" "+" "+col1[3]+" "+" "+col1[4]+" "+" "+col1[5]+" "+" "+col1[6]+" "+" "+col1[7]+" "+" "+col1[8]+" "+" "+col1[9]+" ");

    //hereppob
    // String tgl = col1[0].formatDateTime12String();
    List<String> tgl = col1[0].formatDateTime12String().split(" ");

    // fileName = col1[10];
    // List<String> tgl2 = tgl.split(" ");
    String content = "<div style='width:100%;font-size:16px; padding:5px;'><br/>"
            "<div style='font-size:22px;width:100%;text-align:center; padding-bottom:10px;'>TRANSAKSI SUKSES</div>"
        "<br/>"
        //hereppob
        // "<br/>Tanggal: $tgl WITA<br/>"
        "<div style='text-align:center;'>"
        "<br/>Tanggal: ${tgl[0]}<br/>"
        "Jam: ${tgl[1]} WITA<br/></div>"
        "<br/>" +
        col1[10] +
        "" +
        "<table style='width:100%;font-size:14px'>" +
        "<tr><td style='width:80px;'>JENIS TRX</td><td>\t\t:\t\t</td>" +
        "<td>" +
        col1[1] +
        "</td></tr>" +
        "<tr><td>NO. PEL</td><td>\t\t:\t\t</td><td>" +
        col1[2] +
        "</td></tr>" +
        "<tr><td>NAMA</td><td>\t\t:\t\t</td><td>" +
        col1[3] +
        "</td></tr>" +
        "<tr><td>" +
        "DETAIL TAGIHAN" +
        "</td></tr>" +
        "<tr><td style='padding-left:7px;'>- " +
        col1[8] +
        "</td></tr>" +
        "<tr><td style='padding-left:7px;'>- " +
        col1[7] +
        "</td></tr>" +
        "<tr><td style='padding-left:7px;'>- " +
        col1[6] +
        "</td></tr>" +
        "<tr><td>TOTAL TAGIHAN</td><td>\t\t:\t\t</td><td>Rp." +
        col1[12].trim().formatDouble() +
        "</td></tr>" +
        "<tr><td>BIAYA ADMIN</td><td>\t\t:\t\t</td><td>Rp." +
        col1[13].trim().formatDouble() +
        "</td></tr>" +
        "<tr style='font-weight: bold;'>" +
        "<td>TOTAL BAYAR</td><td>\t\t:\t\t</td><td>" +
        "Rp." +
        col1[15].trim().formatDouble() +
        "</td></tr>" +
        "</table></div>";

    return content;
  }

  generatePaymentFirstMediaContent(TransactionResponseModel data) {
    List<String> col1 = data.customerData!.replaceAll("\$", "").replaceAll("'", "").trim().split("_");
    print("data.customerData! "+data.customerData!);
    print("col1[14].trim() "+col1[14].trim());
    print("col1[14].trim() "+col1[14].trim());
    String admin = col1[13].trim();
    if(col1[13]==null || col1[13]==""){
      admin = "0";
    }
    String totalbayar = col1[15].trim();
    if(col1[15]==null || col1[15]==""){
      totalbayar = "0";
    }

    //hereppob
    // String tgl = col1[0].formatDateTime12String();
    List<String> tgl = col1[0].formatDateTime12String().split(" ");

    String content = "<div style='width:100%;font-size:16px;padding:5px;'><br/>"
            "<div style='font-size:22px;width:100%;text-align:center;padding-bottom:10px;'>TRANSAKSI SUKSES</div>"
        "<br/>"
        //hereppob
        // "<br/>Tanggal: $tgl WITA<br/>"
        "<div style='text-align:center;'>"
        "<br/>Tanggal: ${tgl[0]}<br/>"
        "Jam: ${tgl[1]} WITA<br/></div>"
        "<br/>REF: " +
        col1[10] +

        "<br/><table style='width:100%;font-size:14px'>" +
        "<tr><td style='width:80px;'>JENIS TRX</td><td>\t\t:\t\t</td>" +
        "<td>" +
        col1[1] +
        "</td></tr>" +
        "<tr><td>NO. PEL</td><td>\t\t:\t\t</td><td>" +
        col1[2] +
        "</td></tr>" +
        "<tr><td>NAMA</td><td>\t\t:\t\t</td><td>" +
        col1[3] +
        "</td></tr>" +
        "<tr><td>DETAIL TAGIHAN</td>" +
        "</tr>" +
        "<tr><td style='padding-left:7px;'>- " +
        col1[8] +
        "</td></tr>" +
        "<tr><td style='padding-left:7px;'>- " +
        col1[7] +
        "</td></tr>" +
        "<tr><td style='padding-left:7px;'>- " +
        col1[6] +
        "</td></tr>" +
        "<tr><td>TOTAL TAGIHAN</td><td>\t\t:\t\t</td><td>Rp." +
        col1[12].trim().formatDouble() +
        "</td></tr>" +
        "<tr><td>BIAYA ADMIN</td><td>\t\t:\t\t</td><td>Rp." +
        admin.formatDouble() +
        "</td></tr>" +
        "<tr style='font-weight: bold;'>" +
        "<td>TOTAL BAYAR</td><td>\t\t:\t\t</td><td>" +
        "Rp." +
        totalbayar.formatDouble() +
        "</td></tr>" +
        "</table></div>";

    return content;
  }
}
