## Datenschutzbedingungen

#### §1 Die Lösung

1.  Diese Datenschutzbedingungen gelten für Softwareprodukte, -bausteine, -bibliotheken, -applikationen, Webseiten, Dienste oder Produkte - nachfolgend "Lösung" bzw. "Lösungen" genannt - der j&s-soft GmbH, Max-Jarecki-Str. 21, D-69115 Heidelberg.
2.  Als Beispiele gelten die aktuell ausgeführte Applikation "enmeshed App", der Dienst "enmeshed Backbone" und das Produkt "enmeshed Connector" genannt.
3.  Die j&s-soft GmbH ist der Ersteller, Herausgeber und Rechteinhaber der Lösung.
4.  Die Lösung, dessen Inhalt und die Nutzung der Lösung unterliegen dem deutschen Urheberrecht.
5.  Sämtliche Formulierungen innerhalb der Lösungen von j&s-soft GmbH umfassen grundsätzlich alle Geschlechter. Aus Gründen der besseren Lesbarkeit wird meistens das generische Maskulinum benutzt.
6.  Wir glauben fest daran, dass diese Lösung den Datenschutz, die Sicherheit und die Benutzererfahrung der digitalen Welt verbessert. Die Lösung basiert auf einem sogenannten Least-Knowledge Prinzip, d.h. es wird versucht so wenig Daten wie möglich zentral zu speichern.
7.  Jedwede Fragen und Kommentare zu der Lösung können an [info@js-soft.com](mailto:info@js-soft.com) gestellt werden.

#### §2 Verantwortlicher im Sinne des Datenschutzgesetzes

1.  Die j&s-soft GmbH mit Sitz in der Max-Jarecki-Str. 21, D-69115 Heidelberg, ist Verantwortlicher im Sinne des Datenschutzgesetzes.
2.  Der Datenschutzbeauftragte der j&s-soft GmbH kann unter folgender E-Mail Adresse erreicht werden [datenschutz@js-soft.com](mailto:datenschutz@js-soft.com).

#### §3 Betroffenenrechte

1.  Unter den oben angegebenen Kontaktdaten können Sie jederzeit Ihre datenschutzrelevanten Rechte ausüben. Dies sind z.B. Auskunft, Berichtigung oder Löschung der von Ihnen bei uns gespeicherten Daten.
2.  Sofern Sie uns eine Einwilligung zur personenbezogenen Nutzung Ihrer Daten erteilt haben, können Sie jederzeit diese Einwilligung mit zukünftiger Wirkung widerrufen.
3.  Es steht Ihnen jederzeit frei eine Beschwerde an die zuständige Aufsichtsbehörde zu stellen.

#### §4 Änderung der Bedingungen

1.  Die j&s-soft GmbH behält sich vor, diese Datenschutzbedingungen abzuändern.

#### §5 Benutzung von personenbezogene Daten im lokalen Teil

1.  Der lokale Teil bezieht sich auf den Teil der Lösung, der lokal auf den Geräten der Anwender läuft, also zum Beispiel die aktuell ausgeführte Applikation oder auch der enmeshed Connector, der meistens auf Organisationsseite zur Integration verwendet wird.
2.  Soweit hier nicht anders erwähnt werden personenbezogene Daten - wie auch private und geheime Schlüssel - nur innerhalb des lokalen Teils der Lösung im Klartext verarbeitet bzw. gespeichert.
3.  Daten des lokalen Teils können seitens der j&s-soft GmbH oder ihrer Dienstleister nicht eingelesen oder verarbeitet werden und verbleiben auf dem jeweiligen Endgerät.
4.  Daten des lokalen Teils können seitens Dritter nicht eingelesen oder verarbeitet werden, es sei denn, dass der Nutzer diese Daten manuell über die Lösung teilt.

#### §6 Prozessierung und Speicherung von personenbezogenen Daten im zentralen Teil

1.  Der zentrale Teil der Lösung bezieht sich auf den im Internet zur Verfügung stehenden Dienst "enmeshed Backbone", über den die Kommunikation, die Datenspeicherung und die Synchronisierung zwischen Geräten der Anwender erfolgt.
2.  Soweit hier nicht anders erwähnt, werden Daten aus dem lokalen Teil nur Ende-zu-Ende verschlüsselt an den zentralen Teil übertragen bzw. über den zentralen Teil übermittelt. Die Ende-zu-Ende Verschlüsselung erfolgt zwischen den Geräten einer Identität oder zwischen zwei Identitäten, jedoch nicht mit dem zentralen Teil. Dies hat zur Folge, dass der zentrale Teil diese Verschlüsselung nicht aufbrechen kann und so auf keinerlei Klartextdaten des lokalen Teils zugreifen kann, sondern nur die verschlüsselten Inhalte prozessiert und speichert.
3.  Zum Betrieb der Lösung speichert und prozessiert der zentrale Teil jedoch technische Metadaten, die als personenbezogen anzusehen sind:
    *   Die vom zentralen Teil zufallsgenerierte ClientId und das dazugehörige zufallsgenerierte ClientSecret pro Organisation bzw. eine Kombination ClientId & ClientSecret für alle Benutzer einer Applikation.
    *   Die vom Gerät erzeugte zufallsgenerierte DeviceId und das dazugehörige zufallsgenerierte DevicePassword des jeweiligen Gerätes.
    *   Das Betriebssystem bzw. die Plattform des Gerätes, sowie das dazugehörige Push Notification Token, damit der zentrale Teil an den lokalen Teil Änderungen mitteilen kann.
    *   Der vom Gerät erzeugte zufallsgenerierte öffentliche Schlüssel der digitalen Identität, sowie die davon abgeleitete enmeshed Adresse.
    *   Die Zuordnung zwischen DeviceId und ClientId, sowie die Zuordnung zwischen DeviceId und enmeshed Adresse.
    *   Zufallsgenerierte Identifizierungen für alle Datensätze die ein Benutzer auf dem zentralen Teil erstellen kann, z.B. Nachrichten, Tokens oder Dateien.
    *   Der Zeitstempel wann Datensätze erstellt, geändert oder gelöscht wurden.
    *   Die enmeshed Adresse die einen Datensatz erstellt, geändert oder gelöscht hat.
    *   Die DeviceId die einen Datensatz erstellt, geändert oder gelöscht hat.
    *   Die Zuordnung welche enmeshed Adresse mit welcher anderen enmeshed Adresse kommunizieren darf.
    *   Die Zuordnung welche Nachricht an welche enmeshed Adresse zugestellt werden soll (recipients).
    *   Welche DeviceId einer enmeshed Adresse wann genau eine Nachricht im Empfang genommen hat (receivedAt Datum und receivedByDevice der Nachricht).
    *   Die Zuordnung welche Datei-Id in welcher Nachricht als Anhang verschickt wurde.
    *   Die verschiedenen Versionsstände der Lösung des jeweiligen Gerätes.
    *   Die IP Adresse im Internet, mit dem der zentrale Teil der Lösung von dem Gerät angesprochen wird.
    *   Eine zufallsgenerierte Identifikationsnummer pro Anfrage an den zentralen Teil der Lösung, die zur Protokollierung und Fehlerbehebung benutzt wird.
    *   Eine technische Benutzerkennung, ein sogenanntes Java Web Token, die Teile der oben aufgeführten personenbezogenen Daten beinhalten kann.
4.  Sollten weitere personenbezogene Daten an die j&s-soft GmbH gelangen, werden diese schnellstmöglich vernichtet.

#### §7 Benutzung von personenbezogenen Daten im zentralen Teil

1.  Die in §6 genannten personenbezogenen Daten ermöglichen es der j&s-soft GmbH, die Benutzer, deren Geräte, deren Beziehungen zu anderen Benutzern und deren Verhalten zu analysieren bzw. auszuwerten, eine sogenannte Metadatenanalyse.
2.  Diese Auswertung wird dafür benutzt, eine Eingrenzung von Datennutzung pro Nutzer bzw. Organisation (sogenannte Quota), eine Eingrenzung von Zugriffsrechten (z.B. Zugriff auf verschlüsselten Daten), allgemeine Verbesserungen der Lösung zu entwickeln und eine Abrechnung für unser Organisationen zu ermöglichen.
3.  Mit den §6 genannten personenbezogenen Daten ist es der j&s-soft GmbH jedoch nicht ohne weiteres möglich, die erhobenen Daten auf echte natürliche Personen einzugrenzen. Eine solche Eingrenzung wird seitens der j&s-soft GmbH auch nicht versucht.

#### §8 Weitergabe von personenbezogenen Daten seitens der j&s-soft GmbH

1.  Die erhobenen Daten werden mit IT-Zulieferern für sogenanntes Cloud-Hosting geteilt, um den Betrieb sicherzustellen.
2.  Der Betrieb erfolgt wo möglich innerhalb der Europäischen Union.
3.  Um den Betrieb der Lösung sicherzustellen, müssen Dienste von Dritten in Anspruch genommen werden, die ggf. außerhalb der Euroäischen Union betrieben werden bzw. deren Daten nicht zweifelsfrei in der Europäischen Union bleiben:
    *   Apple Push Notification Service, um sogenannte Push Notifications an iOS Geräte zu übermitteln.
    *   Firebase Push Service, um sogenannte Push Notifications an Android Geräte zu übermitteln.
4.  Eine - über den Betrieb hinausgehende - Weitergabe von personenbezogenen Daten des zentralen Teils an Dritte erfolgt nicht.

#### §9 Weitergabe von personenbezogenen Daten seitens des Nutzers

1.  Über die Lösung können personenbezogene Daten an andere Teilnehmer der Lösung geteilt bzw. freigegeben werden.
2.  Die Weitergabe von personenbezogenen Daten mithilfe der Lösung erfolgt stets freiwillig seitens des jeweiligen Nutzers bzw. Dateneigentümers.
3.  Die Weitergabe dieser Daten erfolgt meist durch manuelles Zutun des Nutzers, kann aber auch automatisiert geschehen, sofern der Nutzer dem zustimmt.

#### §10 Datenschutzbedingungen von Dritten

1.  Der Empfang oder der Versand von personenbezogenen Daten über diese Lösung impliziert eine Kontaktanfrage mit einer dritten Partei, wie z.B. Organisationen oder andere Personen. Schon während der Kontaktanfrage ist es üblich und erwünscht, dass diese dritte Partei die eigenen Datenschutzbedingungen dem Benutzer aufzeigt.
2.  Der Inhalt und das Einhalten dieser Datenschutzbedingungen obliegt dieser dritten Partei. Die j&s-soft GmbH hat keinen Einfluss auf die Verarbeitung von personenbezogenen Daten bei den jeweiligen Drittparteien, noch weiß die j&s-soft GmbH um wen es sich bei der dritten Partei handelt.
3.  Die j&s-soft GmbH empfiehlt das genaue Lesen der Datenschutzbedingungen der jeweiligen Partei. Ebenso wird empfohlen, die Datenschutzbedingungen so früh wie möglich abzuklären, bestenfalls noch bevor die Kontaktanfrage angenommen wird, da bis zur Annahme einer Kontaktanfrage keine personenbezogenen Daten an die dritte Partei geteilt werden.
4.  Die Annahme einer Kontaktanfrage impliziert meist die Zustimmung der Datenschutzbedingungen dieser Partei, was auch so innerhalb der Kontaktanfrage seitens der dritten Partei aufgezeigt werden sollte. Falls keine personenbezogenen Daten zu den Bedingungen geteilt werden sollen, kann die Kontaktanfrage ignoriert bzw. auch direkt gelöscht werden.

#### §11 Sonstiges

1.  An die Stelle der unwirksamen oder undurchführbaren Bestimmung soll diejenige wirksame und durchführbare Regelung treten, deren Wirkungen der wirtschaftlichen Zielsetzung möglichst nahe kommen, die die Vertragsparteien mit der unwirksamen beziehungsweise undurchführbaren Bestimmung verfolgt haben.