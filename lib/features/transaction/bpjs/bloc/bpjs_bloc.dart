import 'package:bloc/bloc.dart';
import 'package:ppob/core/bloc/bloc_event.dart';
import 'package:ppob/core/bloc/bloc_state.dart';
import 'package:ppob/core/constant/constants.dart';
import 'package:ppob/core/extention/common_extention.dart';
import 'package:ppob/features/transaction/bpjs/repositories/bpjs_repository.dart';
import 'package:ppob/features/transaction/model/transaction_response_model.dart';

part 'bpjs_event.dart';
part 'bpjs_state.dart';

class BPJSBloc extends Bloc<BPJSEvent, BlocState> {
  final BPJSRepository repository;

  BPJSBloc(this.repository) : super(InitialState()) {
    on<InquiryBPJSEvent>((event, emit) async {
      emit(ShowLoadingState());
      try {
        var results = await repository.postInquiryBPJS(event);
        emit(HideLoadingState());
        if (results.status == Constants.RC_SUKSES || results.status == Constants.RC_R00) {
          emit(InquiryBPJSSuccessState(results.data!));
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

    on<PaymentBPJSEvent>((event, emit) async {
      emit(ShowLoadingState());
      try {
        var results = await repository.postPaymentBPJS(event);
        emit(HideLoadingState());
        if (results.status == Constants.RC_SUKSES || results.status == Constants.RC_R00) {
          emit(PaymentBPJSSuccessState(results.data!));
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

  generateDetailContent(TransactionResponseModel data) {
    List<String> col1 = data.customerData!.trim().split("_");
    // DateTime dt = col1[0].toDateTime();
    // String tgl = col1[0].substring(1, 12).formatDateTime12();
    String tgl = col1[0].formatDateTime12String();
    String total = col1[6].trim().isNotEmpty ? col1[6].trim().formatDouble() : data.billAmount!.currencyFormat();

    String s = "<tr style='font-weight: bold;'>"
            "<td>TOTAL BAYAR</td><td>\t\t:\t\t</td>"
            "<td>Rp." +
        total +
        "</td>" +
        "</tr>";

    String content = "<div style='width:100%;font-size:16px'><br/>"
            "<div style='font-size:22px;width:100%;text-align:center;'>TRANSAKSI SUKSES</div><br/><br/>"
            "<br/>Tanggal: $tgl WITA<br/>"
            "<br/><table style='width:100%;'>"
            "<tr><td style='width:80px;'>PRODUK</td><td>\t\t:\t\t</td>"
            "<td>" +
        data.produk! +
        "</td></tr>"
            "<tr><td>NO PEL</td><td>\t\t:\t\t</td><td>" +
        col1[2] +
        "</td></tr><tr><td>NAMA</td><td>\t\t:\t\t</td><td>" +
        col1[3] +
        "</td></tr><tr><td>TOTAL TAGIHAN</td><td>\t\t:\t\t</td><td>Rp." +
        (col1[4].trim() == "-" ? "0" : col1[4].trim()).formatDouble() +
        "</td></tr><tr><td>BIAYA ADMIN</td><td>\t\t:\t\t</td><td>Rp." +
        (col1[5].trim() == "-" ? "0" : col1[5].trim()).formatDouble() +
        "</td></tr> $s </table></div>";

    return content;
  }
}
