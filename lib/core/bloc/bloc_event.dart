import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:ppob/core/base/build_config.dart';
import 'package:ppob/core/constant/constants.dart';

class BlocEvent extends Equatable {
  final String cid = "002";
  final String regNo = Constants.NO_REKENING;
  final String cif = GetIt.I<PPOBBuildConfig>().cif;
  final String secretKey = GetIt.I<PPOBBuildConfig>().secretKey;

  @override
  List<Object?> get props => [cid, regNo, cif, secretKey];
}
