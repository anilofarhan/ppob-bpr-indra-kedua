import 'package:bloc/bloc.dart';
import 'package:ppob/core/bloc/bloc_event.dart';
import 'package:ppob/core/bloc/bloc_state.dart';
import 'package:ppob/core/constant/constants.dart';
import 'package:ppob/core/constant/proccesing_code.dart';
import 'package:ppob/core/extention/common_extention.dart';
import 'package:ppob/features/transaction/model/transaction_response_model.dart';
import 'package:ppob/features/transaction/pln/token/model/harga_token_model.dart';
import 'package:ppob/features/transaction/pln/token/repositories/token_pln_repository.dart';

part 'token_pln_event.dart';
part 'token_pln_state.dart';

class HargaTokenPlnBloc extends Bloc<HargaTokenPlnEvent, BlocState> {
  final TokenPlnRepository repository;

  HargaTokenPlnBloc(this.repository) : super(InitialState()) {
    on<HargaTokenPlnEvent>((event, emit) async {
      emit(ShowLoadingState());
      try {
        var results = await repository.getHargaTokenPln(event);

        if (results.status == Constants.RC_SUKSES) {
          emit(HargaTokenSuccessState(results.data!));
          emit(HideLoadingState());
        } else {
          emit(HargaNotFoundState(results.description));
        }
      } catch (e) {
        emit(HideLoadingState());
        emit(ErrorState(message: e.toString()));
      }
    });
  }
}

class PaymentTokenPlnBloc extends Bloc<PaymentTokenPlnEvent, BlocState> {
  final TokenPlnRepository repository;

  PaymentTokenPlnBloc(this.repository) : super(InitialState()) {
    on<PaymentTokenPlnEvent>((event, emit) async {
      emit(PaymentTokenPlnShowLoadingState());
      try {
        var results = await repository.postPaymentTokenPln(event);
        emit(PaymentTokenPlnHideLoadingState());
        if (results.status == Constants.RC_SUKSES) {
          if (event.procCode == ProccesingCode.TRX_PLN_PREPAID_INQ) {
            emit(InquiryTokenSuccessState(results.data!));
          } else {
            emit(PaymentTokenSuccessState(results.data!));
          }
        } else {
          emit(ErrorState(message: results.description!.replaceAll("|", "\n\n")));
        }
      } catch (e) {
        emit(PaymentTokenPlnHideLoadingState());
        emit(ErrorState(message: e.toString()));
      }
    });
  }

  generateDetailContent(TransactionResponseModel data) {
    List<String> col1 = data.customerData!.trim().split("_");
    print("_ "+data.customerData!);
    // DateTime dt = col1[0].toDateTime();
    String tgl = col1[0].formatDateTime12String();
    String total = col1[24].trim().isNotEmpty ? col1[24].trim().formatDouble() : data.billAmount!.currencyFormat();

    String s = col1.length > 24
        ? "<tr style='font-weight: bold;'>"
                "<td>TOTAL BAYAR</td><td>\t\t:\t\t</td>"
                "<td>Rp." +
            total +
            "</td>" +
            "</tr>"
        : "";

    String content = "<div style='width:100%;font-size:16px; padding:5px;'><br/>"
            "<div style='font-size:22px;width:100%;text-align:center;'>TRANSAKSI SUKSES</div>"
            "<br/><br/>Tanggal: $tgl WITA<br/><br/>" +
        col1[8] +
        "<br/>" +
        col1[9] +
        "<br/></br><table style='width:100%;font-size:14px'><tr><td style='width:50px;'>" +
        "NO. METER</td><td> :</td><td>" +
        col1[4] +
        "</td></tr><tr>" +
        "<td>NO. PEL</td><td>\t\t:\t\t</td><td>" +
        col1[5] +
        "</td></tr>" +
        "<tr><td>NAMA</td><td>\t\t:\t\t</td><td>" +
        col1[6] +
        "</td></tr><tr>" +
        "<td>TARIF/DAYA</td><td>\t\t:\t\t</td><td>" +
        col1[7] +
        "</td></tr>" +
        "<tr><td>MATERAI</td><td>\t\t:\t\t</td><td>Rp." +
        col1[12].trim().formatDouble() +
        "</td></tr><tr><td>PPn</td><td>\t\t:\t\t</td><td>Rp." +
        col1[13].trim().formatDouble() +
        "</td></tr><tr><td>PPj</td>" +
        "<td>\t\t:\t\t</td><td>Rp." +
        col1[14].trim().formatDouble() +
        "</td>" +
        "</tr><tr><td>ANGSURAN</td><td>\t\t:\t\t</td><td>Rp." +
        col1[15].trim().formatDouble() +
        "</td></tr><tr>" +
        "<td>BIAYA ADMIN</td><td>\t\t:\t\t</td>" +
        "<td>Rp." +
        col1[11].trim().formatDouble() +
        "</td>" +
        "</tr>" +
        "<tr>" +
        "<td>Rp BAYAR</td><td>\t\t:\t\t</td>" +
        "<td>Rp." +
        col1[10].trim().formatDouble() +
        "</td>" +
        "</tr>" +
        s +
        "<tr><td>Rp STROOM/TOKEN</td><td>\t\t:\t\t</td><td>Rp " +
        col1[16].trim().formatDouble() +
        "</td></tr><tr><td>Jml KWH</td><td>\t\t:\t\t</td><td>" +
        col1[17] +
        "</td></tr><tr><td>STROOM/TOKEN</td><td>\t\t:\t\t</td><td></td></tr><tr><td colspan='3'>" +
        col1[19].replaceAll("#", "") +
        "</td></tr></table></div><br/><br/><br/><div style='text-align: center;'>"+
        "Informasi hubungi PLN Call Center 123"+
        "<br/>____***____"+
        "</div></div>";;

    return content;
  }
}
