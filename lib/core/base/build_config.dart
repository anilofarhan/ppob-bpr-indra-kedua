class PPOBBuildConfig {
  String baseUrl;
  String rsaKey;
  String secretKey;
  String sessionId;
  String cif;
  bool debug;

  PPOBBuildConfig(
      {required this.baseUrl,
      required this.rsaKey,
      required this.secretKey,
      required this.sessionId,
      required this.cif,
      this.debug = true});
}
