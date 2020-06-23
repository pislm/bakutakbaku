class KataBaku{
  String kataBenar;
  String kataSalah;

  KataBaku(String kataBenar, String kataSalah){
    this.kataBenar = kataBenar;
    this.kataSalah = kataSalah;
  }

  String getBenar() {
    return kataBenar;
  }

  String getSalah(){
    return kataSalah;
  }
}