#!/bin/bash
set -e
echo "🚀 Iniciando construcción..."

# Instalar JDK
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install java 17.0.11-librca
source "$HOME/.sdkman/bin/sdkman-init.sh"

# Compilar
mvn clean package -DskipTests

# Crear PDFs
mkdir -p target/pdfs
echo -e "Generador de compuestos V01\nDesarrollado por: hadit arquitectos s.l.p.\n\nGuía para Windows\n1. Ejecuta el .exe\n2. Sigue la configuración" > target/pdfs/Guia_Instalacion_WINDOWS.txt
echo -e "Generador de compuestos V01\nDesarrollado por: hadit arquitectos s.l.p.\n\nGuía para macOS\n1. Abre el .dmg\n2. Arrastra a Applications" > target/pdfs/Guia_Instalacion_MAC.txt

# Convertir a PDF
for f in target/pdfs/*.txt; do
  ps2pdf <(cat "$f") "${f%.txt}.pdf"
done

# Generar instaladores
jpackage --input target --main-jar generador-compuestos-v01-1.0.jar --main-class es.hadit.generador.App --name "Generador de compuestos V01" --type dmg --dest target/installers
jpackage --input target --main-jar generador-compuestos-v01-1.0.jar --main-class es.hadit.generador.App --name "Generador_de_compuestos_V01" --type app-image --dest target/installers/windows

# Comprimir Windows
cd target/installers/windows && zip -r "../Generador_de_compuestos_V01_Windows.zip" "Generador_de_compuestos_V01" && cd ../../..

# Crear ZIPs finales
zip -j "Generador_de_compuestos_V01_Mac_Paquete.zip" target/installers/Generador\ de\ compuestos\ V01.dmg target/pdfs/Guia_Instalacion_MAC.pdf
zip -j "Generador_de_compuestos_V01_Windows_Paquete.zip" target/installers/Generador_de_compuestos_V01_Windows.zip target/pdfs/Guia_Instalacion_WINDOWS.pdf

echo "✅ ¡Listo! Descarga los ZIPs desde el panel izquierdo."
