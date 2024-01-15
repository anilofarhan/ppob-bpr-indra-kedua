import 'package:bloc/bloc.dart';
import 'package:ppob/core/bloc/bloc_event.dart';
import 'package:ppob/core/bloc/bloc_state.dart';
import 'package:ppob/core/constant/constants.dart';
import 'package:ppob/core/extention/common_extention.dart';
import 'package:ppob/features/transaction/model/transaction_response_model.dart';
import 'package:ppob/features/transaction/pln/tagihan/repositories/tagihan_pln_repository.dart';

part 'tagihan_pln_event.dart';
part 'tagihan_pln_state.dart';

class TagihanPlnBloc extends Bloc<TagihanPlnEvent, BlocState> {
  final TagihanPlnRepository repository;

  TagihanPlnBloc(this.repository) : super(InitialState()) {
    on<InquiryTagihanPlnEvent>((event, emit) async {
      emit(ShowLoadingState());
      try {
        var results = await repository.inquiryTagihanPln(event);
        emit(HideLoadingState());

        if (results.status == Constants.RC_SUKSES || results.status == Constants.RC_R00) {
          emit(InquiryTagihanPlnSuccessState(results.data!));
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

    on<PaymentTagihanPlnEvent>((event, emit) async {
      emit(ShowLoadingState());
      try {
        var results = await repository.paymentTagihanPln(event);
        emit(HideLoadingState());

        if (results.status == Constants.RC_SUKSES || results.status == Constants.RC_R00) {
          emit(PaymentTagihanPlnSuccessState(results.data!));
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

    on<InquiryPlnNontaglisEvent>((event, emit) async {
      emit(ShowLoadingState());
      try {
        var results = await repository.inquiryPlnNonTaglis(event);
        emit(HideLoadingState());

        if (results.status == Constants.RC_SUKSES || results.status == Constants.RC_R00) {
          emit(InquiryPlnNontaglisSuccessState(results.data!));
        } else if (results.status == Constants.RC_07 || results.status == Constants.RC_09) {
          emit(SessionExpiredState(results.description));
        } else {
          emit(ErrorState(message: results.description!.replaceAll("|", "\n\n").replaceAll("_", "\n")));
        }
      } catch (e) {
        emit(HideLoadingState());
        emit(ErrorState(message: e.toString()));
      }
    });

    on<PaymentPlnNontaglisEvent>((event, emit) async {
      emit(ShowLoadingState());
      try {
        var results = await repository.paymentPlnNonTaglis(event);
        emit(HideLoadingState());

        if (results.status == Constants.RC_SUKSES || results.status == Constants.RC_R00) {
          emit(PaymentPlnNontaglisSuccessState(results.data!));
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

  generatePaymentTagihanContent(TransactionResponseModel data) {
    List<String> col1 = data.customerData!.trim().split("_");
    // DateTime dt = col1[0].toDateTime();

    //hereppob
    // String tgl = col1[0].formatDateTime12();
    List<String> tgl = col1[0].formatDateTime12String().split(" ");

    // String total = col1[24].trim().isNotEmpty ? col1[24].trim().formatDouble() : data.hargaAnipay!.currencyFormat();

    String content = "<div style='width:100%;font-size:16px;padding:5px;'><br/>"
            "<div style='font-size:22px;width:100%;text-align:center;'>TRANSAKSI SUKSES</div>"
            "<br/>"
        //hereppob
        // "<br/>Tanggal: $tgl WITA<br/>"
        "<div style='text-align:center;'>"
        "<br/>Tanggal: ${tgl[0]}<br/>"
        "Jam: ${tgl[1]} WITA<br/></div>"
        "<br/>" +
        col1[10] +
        "<br/><br/>" +
        "<table style='width:100%;font-size:14px'>" +
        "<tr><td style='width:80px;'>NO. METER</td><td>\t\t:\t\t</td>" +
        "<td>" +
        col1[8] +
        "</td></tr>" +
        "<tr><td>NO. PEL</td><td>\t\t:\t\t</td><td>" +
        col1[4] +
        "</td></tr>" +
        "<tr><td>NAMA</td><td>\t\t:\t\t</td><td>" +
        col1[5] +
        "</td></tr>" +
        "<tr><td>TARIF/DAYA</td><td>\t\t:\t\t</td><td>" +
        col1[6] +
        "</td></tr>" +
        "<tr><td>BL/TH</td><td>\t\t:\t\t</td><td>" +
        col1[7] +
        "</td></tr>" +
        "<tr><td>TOTAL TAGIHAN</td><td>\t\t:\t\t</td><td>Rp." +
        col1[9].trim().formatDouble() +
        "</td></tr>" +
        "<tr><td>BIAYA ADMIN</td><td>\t\t:\t\t</td><td>Rp." +
        col1[16].trim().formatDouble() +
        "</td></tr>" +
        "<tr style='font-weight: bold;'>" +
        "<td>Rp Bayar</td><td>\t\t:\t\t</td><td>" +
        "Rp." +
        col1[17].trim().formatDouble() +
        "</td></tr>" +
        "</table></div><br/><br/><br/><div style='text-align: center;'>"+
        "Informasi hubungi PLN Call Center 123"+
        "<br/>____***____"+
        "</div></div>"; //.hideUangBayar(true);

    return content;
  }

  generatePaymentNontaglisContent(TransactionResponseModel data) {
    List<String> col1 = data.customerData!.trim().split("_");
    // DateTime dt = col1[0].toDateTime();
    // String tgl = col1[0].formatDateTime12();
    // String total = col1[24].trim().isNotEmpty ? col1[24].trim().formatDouble() : data.hargaAnipay!.currencyFormat();

    String content = "<div style='width:100%;font-size:16px;padding:5px;'><br/>"
            "<div style='font-size:22px;width:100%;text-align:center;'>TRANSAKSI SUKSES</div>"
            "<br/><br/>"
            "<table style='width:100%;font-size:14px'>"
            "<tr><td style='width:80px;'>NO. REGISTRASI</td><td>\t\t:\t\t</td>"
            "<td>" +
        col1[1] +
        "</td></tr>" +
        "<tr><td>NAMA</td><td>\t\t:\t\t</td><td>" +
        col1[3] +
        "</td></tr>" +
        "<tr valign='top'><td style='vertical-align:top'>JENIS TRANSAKSI</td><td>\t\t:\t\t</td>" +
        "<td style='vertical-align:top'>" +
        col1[5] +
        "</td></tr>" +
        "<tr><td>TGL REGISTRASI</td><td>\t\t:\t\t</td><td>" +
        col1[7] +
        "</td></tr>" +
        "<tr><td>BIAYA PLN</td><td>\t\t:\t\t</td><td>Rp." +
        col1[9].trim().formatDouble() +
        "</td></tr>" +
        "<tr><td>BIAYA ADMIN</td><td>\t\t:\t\t</td><td>Rp." +
        col1[11].trim().formatDouble() +
        "</td></tr>" +
        "<tr style='font-weight: bold;'>" +
        "<td>TOTAL</td><td>\t\t:\t\t</td><td>" +
        "Rp." +
        col1[13].trim().formatDouble() +
        "</td></tr>" +
        "</table></div><br/><br/><br/><div style='text-align: center;'>"+
        "Informasi hubungi PLN Call Center 123"+
        "<br/>____***____"+
        "</div></div>"; //.hideUangBayar(true);

    return content;
  }
}
