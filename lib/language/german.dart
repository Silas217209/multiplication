// ignore_for_file: non_constant_identifier_names
class German {
  String appbar = "Multiplikation";
  String einstellungenlabel = "Einstellungen";
  String statistikenlabel = "Statistiken";
  String Uben = "Üben";
  String Testen = "Testen";
  String sterne5 = "Sehr gut, du hast";
  String sterne4 = "Gut, du hast";
  String sterne3 = "Nicht verzweifeln! Du hast immerhin";
  String sterne2 = "Da musst du aber noch üben, denn du hast erst";
  String sterne1 = "Uups, da musst du aber nochmal üben, denn du hast erst";
  String Einmaleins2 = "Einmaleins mit 2";
  String Einmaleins3 = "Einmaleins mit 3";
  String Einmaleins4 = "Einmaleins mit 4";
  String Einmaleins5 = "Einmaleins mit 5";
  String Einmaleins6 = "Einmaleins mit 6";
  String Einmaleins7 = "Einmaleins mit 7";
  String Einmaleins8 = "Einmaleins mit 8";
  String Einmaleins9 = "Einmaleins mit 9";
  String Einmaleins10 = "Einmaleins mit 10";
  String Einmaleinsalles = "Einmaleins mit allen Zahlen";
  String Statistiken_loschen_title = "Achtung";
  String Statistiken_loschen_body =
      "Bist du dir sicher, dass du die Statistiken zurücksetzen möchtest?";
  String Statistiken_text_einstellungen = "Statistiken zurücksetzen";
  String Statistiken_zeit_loschen_title = "Achtung";
  String Statistiken_zeit_loschen_body =
      "Bist du dir sicher, dass du die Zeiten löschen möchtest?";
  String Statistiken_zeit_text_einstellungen = "Zeiten löschen";
  String ifzerowrong = "0 falsche Ergebnisse";
  String Ja = "Ja";
  String Nein = "Nein";
  String nochmal = "nochmal";
  String Testvorkommen = "Was soll im Test vorkommen?";
  String Los_gehts = "Los geht's";
  String ifzeroright = "0 richtige Ergebnisse";
  String durchschnitt = 'Dein Durchschnitt';
  String zeit = 'Zeiten';
  String aktuelle_zeit = 'Zeit';
  String bestzeit = 'Beste Zeit';

  String falsch(falsch) => "falsch: $falsch";
  String richtig(richtig) => "richtig: $richtig";
  String aufgabe(testfirst, testsecond, ergebnis) =>
      "$testfirst ⋅ $testsecond = $ergebnis";
  String anzahl_richtig_falsch(richtig, falsch) => "$richtig und $falsch";
  String getrightsingular(value) => "$value richtiges";
  String getrightplural(value) => "$value richtige";
  String getwrongsingular(value) => "$value falsches Ergebnis";
  String getwrongplural(value) => "$value falsche Ergebnisse";
  String einmaleinsmit(reihe) => "Einmaleins mit $reihe";
  String SterneErreicht(rating) => "$rating Sterne erreicht";
  String SternErreicht(rating) => "$rating Stern erreicht";
  String dialogaufgabe(first, second) => "$first · $second";
}