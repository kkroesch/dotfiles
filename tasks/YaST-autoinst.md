


## Erstellen der Konfiguration
Die einfachste Möglichkeit, ein AutoYaST-Profil zu erstellen, ist, ein vorhandenes SUSE Linux Enterprise Server-System als Vorlage zu nutzen. Starte auf einem bereits installierten System YaST 'Verschiedenes' Autoinstallationskonfiguration. Wähle dann Werkzeuge 'Referenzprofil erstellen' aus dem Menü. Wähle die Systemkomponenten aus, die du in das Profil aufnehmen möchtest. Alternativ kannst du ein Profil mit der vollständigen Systemkonfiguration erstellen, indem du YaST 'Verschiedenes' Autoinstallation Cloning System startest oder sudo yast clone_system von der Kommandozeile aus ausführst.

Bei beiden Methoden wird die Datei /root/autoinst.xml erstellt. Das geklonte Profil kann verwendet werden, um einen identischen Klon des Systems einzurichten, von dem es erstellt wurde. In der Regel möchtest du die Datei jedoch anpassen, um die Installation mehrerer ähnlicher, aber nicht identischer Rechner zu ermöglichen. Dazu kannst du das Profil mit deinem bevorzugten Text/XML-Editor anpassen.

## Automatisierte Anpassung
Mit dem Werkzeug `XML Starlet` kann man die autoinst.xml einfach bearbeiten und anpassen.

Um in der Datei `autoinst_template.xml` einen Textknoten zu ersetzen, führe den folgenden Befehl in der Kommandozeile aus:

```bash
xmlstarlet ed -u "//group[gid='462']/userlist" -v "neuer_wert" autoinst_template.xml > autoinst_template_modified.xml
```

 - ed steht für Edit und gibt an, dass du das XML-Dokument bearbeiten möchtest.
 - -u steht für Update und gibt den XPath-Ausdruck an, der den Textknoten auswählt, den du ersetzen möchtest. In diesem Fall suchst du nach einem group-Element, das ein gid-Element mit dem Wert 462 hat. Dann wählst du das Geschwister-Element userlist aus.
 - -v steht für Value und gibt den neuen Wert an, den du für den ausgewählten Textknoten festlegen möchtest. Ersetze "neuer_wert" durch den gewünschten Wert.
 - `autoinst_template.xml` ist der Name der Eingabe-XML-Datei, die du bearbeiten möchtest.
 - `autoinst_template_modified.xml` ist der Name der Ausgabe-XML-Datei, in die das bearbeitete XML-Dokument geschrieben werden soll.

## Überprüfen der XML-Datei
Wenn du die Steuerdatei manuell bearbeitest, stelle sicher, dass sie eine gültige Syntax hat. Um die Syntax zu überprüfen, verwende die bereits in der Distribution vorhandenen Werkzeuge. Um beispielsweise zu überprüfen, ob die Datei wohlgeformt ist (eine gültige XML-Struktur hat), nutze das Dienstprogramm xmllint, das mit dem Paket libxml2 verfügbar ist:

    xmllint <Kontrolldatei>

Wenn die Kontrolldatei nicht wohlgeformt ist, z. B. wenn ein Tag nicht geschlossen ist, meldet xmllint die Fehler.

Um die Steuerdatei zu validieren, verwende das Tool `jing` aus dem gleichnamigen Paket. Bei der Validierung werden falsch platzierte oder fehlende Tags und Attribute sowie falsche Attributwerte erkannt. Das jing-Paket wird mit dem SUSE Software Development Kit bereitgestellt.

    jing /usr/share/YaST2/schema/autoyast/rng/profile.rng <Kontrolldatei>

`/usr/share/YaST2/schema/autoyast/rng/profile.rng` wird durch das Paket yast2-schema bereitgestellt. Diese Datei beschreibt die Syntax und die Klassen eines AutoYaST-Profils.

## Auswahl des richtigen Bootmediums
Für das Booten des Clients gibt es verschiedene Methoden. Der Computer kann von seiner Netzwerkkarte (NIC) booten, um die Boot-Images über DHCP oder TFTP zu empfangen. Alternativ kann ein geeignetes Kernel- und initrd-Image von einer Flash-Disk (z. B. einem USB-Stick) oder einer bootfähigen DVD-ROM geladen werden.

YaST sucht beim Start nach der Datei autoinst.xml im Hauptverzeichnis des Boot-Mediums oder der initrd und schaltet auf eine automatische Installation um, wenn sie gefunden wurde. Falls die Steuerdatei anders benannt ist oder sich an einem anderen Ort befindet, gib ihren Speicherort in der Kernel-Kommandozeile mit dem Parameter AutoYaST=URL an.

Alternativ kannst du die Datei autoinst.xml auf einem Gerät ablegen, das entweder physisch oder virtuell gemountet ist und die Bezeichnung OEMDRV trägt. In diesem Fall musst du den Speicherort der Datei autoinst.xml nicht in der Kernel-Befehlszeile angeben. Die Datei autoinst.xml muss sich im Stammverzeichnis des Geräts befinden.

## Booten von einem SUSE Linux Enterprise-Installationsmedium

Du kannst das SUSE Linux Enterprise-Installationsmedium (`SLE-15-SP3-Online-ARCH-GM-media1.iso` oder `SLE-15-SP3-Full-ARCH-GM-media1.iso`) in Kombination mit anderen Medien verwenden. Die Steuerdatei kann beispielsweise über eine Flash-Disk oder einen bestimmten Speicherort im Netzwerk bereitgestellt werden. Alternativ kannst du auch ein benutzerdefiniertes Installationsmedium erstellen, das die Steuerdatei enthält.

## Modifiziertes ISO-Images
Um ein ISO-Image unter Linux zu mounten, es zu bearbeiten und anschließend die Änderungen zu speichern, führe die folgenden Schritte aus:

Installiere die erforderlichen Pakete:

    sudo apt-get install -y genisoimage p7zip-full  # Ubuntu/Debian
    sudo yum install -y genisoimage p7zip          # CentOS/RHEL

Extrahiere das ISO-Image in einen Arbeitsordner:

    mkdir iso_original iso_modified
    7z x -oiso_original path/to/your/image.iso
    cp -R iso_original/* iso_modified/

Bearbeite die Dateien im Ordner iso_modified, wie gewünscht.

Nachdem du die Änderungen vorgenommen hast, erstelle ein neues ISO-Image:

    cd iso_modified
    mkisofs -o ../new_image.iso -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -J -R -V "New ISO Label" .

Ersetze "New ISO Label" mit dem gewünschten Namen für dein neues ISO-Image.

Wechsle zurück in das übergeordnete Verzeichnis und entferne die Arbeitsordner:

    cd ..
    rm -rf iso_original iso_modified

Nun hast du ein neues ISO-Image new_image.iso mit den vorgenommenen Änderungen erstellt.