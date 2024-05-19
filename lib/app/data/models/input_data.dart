class InputDataModel {
    final int? idKel;
    final String? namaLing;
    final int? idKec;
    final int? jRw;
    final int? jRt;
    final int? jDasawisma;
    final int? jKrt;
    final int? jKk;
    final int? jATotalL;
    final int? jATotalP;
    final int? jABalitaL;
    final int? jABalitaP;
    final int? jAPus;
    final int? jAWus;
    final int? jAHamil;
    final int? jASusui;
    final int? jALansia;
    final int? jABlaki;
    final int? jABcwe;
    final int? jABb;
    final int? krSehat;
    final int? krTdkSehat;
    final int? jrTsampah;
    final int? jrSpal;
    final int? jrJamban;
    final int? jrStiker;
    final int? sakPdam;
    final int? sakSumur;
    final int? sakSungai;
    final int? sakDll;
    final int? mpBeras;
    final int? mpNonberas;
    final int? jkkTabung;
    final int? kUpk;
    final int? kpTernak;
    final int? kpIkan;
    final int? kpWarung;
    final int? kpLumbung;
    final int? kpToga;
    final int? kpTanaman;
    final int? iPangan;
    final int? iSandang;
    final int? iJasa;
    final int? kesLing;
    final String? ket;

    InputDataModel({
        required this.idKel,
        required this.namaLing,
        required this.idKec,
        required this.jRw,
        required this.jRt,
        required this.jDasawisma,
        required this.jKrt,
        required this.jKk,
        required this.jATotalL,
        required this.jATotalP,
        required this.jABalitaL,
        required this.jABalitaP,
        required this.jAPus,
        required this.jAWus,
        required this.jAHamil,
        required this.jASusui,
        required this.jALansia,
        required this.jABlaki,
        required this.jABcwe,
        required this.jABb,
        required this.krSehat,
        required this.krTdkSehat,
        required this.jrTsampah,
        required this.jrSpal,
        required this.jrJamban,
        required this.jrStiker,
        required this.sakPdam,
        required this.sakSumur,
        required this.sakSungai,
        required this.sakDll,
        required this.mpBeras,
        required this.mpNonberas,
        required this.jkkTabung,
        required this.kUpk,
        required this.kpTernak,
        required this.kpIkan,
        required this.kpWarung,
        required this.kpLumbung,
        required this.kpToga,
        required this.kpTanaman,
        required this.iPangan,
        required this.iSandang,
        required this.iJasa,
        required this.kesLing,
        required this.ket,
    });

    factory InputDataModel.fromJson(Map<String, dynamic> json) => InputDataModel(
        idKel: json["id_kel"],
        namaLing: json["nama_ling"],
        idKec: json["id_kec"],
        jRw: json["j_rw"],
        jRt: json["j_rt"],
        jDasawisma: json["j_dasawisma"],
        jKrt: json["j_krt"],
        jKk: json["j_kk"],
        jATotalL: json["j_a_total_l"],
        jATotalP: json["j_a_total_p"],
        jABalitaL: json["j_a_balita_l"],
        jABalitaP: json["j_a_balita_p"],
        jAPus: json["j_a_pus"],
        jAWus: json["j_a_wus"],
        jAHamil: json["j_a_hamil"],
        jASusui: json["j_a_susui"],
        jALansia: json["j_a_lansia"],
        jABlaki: json["j_a_blaki"],
        jABcwe: json["j_a_bcwe"],
        jABb: json["j_a_bb"],
        krSehat: json["kr_sehat"],
        krTdkSehat: json["kr_tdk_sehat"],
        jrTsampah: json["jr_tsampah"],
        jrSpal: json["jr_spal"],
        jrJamban: json["jr_jamban"],
        jrStiker: json["jr_stiker"],
        sakPdam: json["sak_pdam"],
        sakSumur: json["sak_sumur"],
        sakSungai: json["sak_sungai"],
        sakDll: json["sak_dll"],
        mpBeras: json["mp_beras"],
        mpNonberas: json["mp_nonberas"],
        jkkTabung: json["jkk_tabung"],
        kUpk: json["k_upk"],
        kpTernak: json["kp_ternak"],
        kpIkan: json["kp_ikan"],
        kpWarung: json["kp_warung"],
        kpLumbung: json["kp_lumbung"],
        kpToga: json["kp_toga"],
        kpTanaman: json["kp_tanaman"],
        iPangan: json["i_pangan"],
        iSandang: json["i_sandang"],
        iJasa: json["i_jasa"],
        kesLing: json["kes_ling"],
        ket: json["ket"],
    );

    Map<String, dynamic> toJson() => {
        "id_kel": idKel,
        "nama_ling": namaLing,
        "id_kec": idKec,
        "j_rw": jRw,
        "j_rt": jRt,
        "j_dasawisma": jDasawisma,
        "j_krt": jKrt,
        "j_kk": jKk,
        "j_a_total_l": jATotalL,
        "j_a_total_p": jATotalP,
        "j_a_balita_l": jABalitaL,
        "j_a_balita_p": jABalitaP,
        "j_a_pus": jAPus,
        "j_a_wus": jAWus,
        "j_a_hamil": jAHamil,
        "j_a_susui": jASusui,
        "j_a_lansia": jALansia,
        "j_a_blaki": jABlaki,
        "j_a_bcwe": jABcwe,
        "j_a_bb": jABb,
        "kr_sehat": krSehat,
        "kr_tdk_sehat": krTdkSehat,
        "jr_tsampah": jrTsampah,
        "jr_spal": jrSpal,
        "jr_jamban": jrJamban,
        "jr_stiker": jrStiker,
        "sak_pdam": sakPdam,
        "sak_sumur": sakSumur,
        "sak_sungai": sakSungai,
        "sak_dll": sakDll,
        "mp_beras": mpBeras,
        "mp_nonberas": mpNonberas,
        "jkk_tabung": jkkTabung,
        "k_upk": kUpk,
        "kp_ternak": kpTernak,
        "kp_ikan": kpIkan,
        "kp_warung": kpWarung,
        "kp_lumbung": kpLumbung,
        "kp_toga": kpToga,
        "kp_tanaman": kpTanaman,
        "i_pangan": iPangan,
        "i_sandang": iSandang,
        "i_jasa": iJasa,
        "kes_ling": kesLing,
        "ket": ket,
    };
}
