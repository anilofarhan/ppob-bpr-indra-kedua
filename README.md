# ppob

## Getting Started


- Tambahkan code berikut di file pubspec.yaml

       ppob:
         git:
           url: https://robycohen@github.com/robycohen/ppob-bpr-indra.git
           ref: master
      
- Initial terlebih dahulu cukup sekali saja, informasi yg dibutuhkan sudah di dapat dari response api login 
    
       PPOBModule.init(
        buildConfig: () => PPOBBuildConfig(
          baseUrl: baseUrl,
          rsaKey: RSA_KEY,
          secretKey: secretKey,
          sessionId: sessionId,
          cif: cif,
          debug: true),
        );
          
- Setelah initial, untuk call menu screen ppob seperti berikut dibawah ini, biasanya di panggil di dlm fungsi button/menu item. (No rekening => dari select no rekening bpr indra):
     
      MenuPPOBScreen(noRekening: "no rekening")
      
  
- Catatan:
<br />Untuk icon/image sebaiknya gunakan widget ImageAsset, agar terbaca path assets (images/icons) pada saat rendering:
<br />[ImageAsset](../master/lib/core/component/my_widget.dart)

- Sample app:
[test-app-ppob](https://github.com/robycohen/test-app-ppob)



