# Ruta de la carpeta donde se encuentran los archivos PDF
# Si es una ruta específica 
$rutaCarpeta = "carpetaPDF"
# Si hay que introducir la ruta por ser diferente en cada equipo
# $rutaCarpeta = Read-Host "Ingrese la dirección de la carpeta con los ficheros a imprimir: "

# Obtenemos la impresora por defecto
#$MYDEFAULTPRINTER = Get-CimInstance -ClassName CIM_Printer | WHERE {$_.Default -eq $True} | Select Name

# Obtener la lista de archivos PDF en la carpeta
$archivosPDF = Get-ChildItem  -Path $rutaCarpeta -Filter *.pdf
#$archivosPDF = Get-ChildItem -Path $rutaCarpeta -include *.doc, *.docx, *.xls, *.xlsx, *.ppt, *.pptx, *.odt, *.ods, *.odp -Recurse


# Verificar que haya archivos PDF en la carpeta
if ($archivosPDF.Count -eq 0) {
   Write-Output "No se encontraron archivos PDF en la carpeta especificada: $($rutaCarpeta)."
   exit
}

# Enviar cada archivo PDF a la impresora predeterminada
foreach($archivo in $archivosPDF) {
   Write-Output "Enviando a imprimir: $($archivo.FullName)"
   # Enviar los archivos a la impresora
   # Start-Process -FilePath $archivo.FullName -ArgumentList "/p /h `"$($archivo.FullName)`"" -NoNewWindow -Wait
   Start-Process -FilePath $archivo.FullName -Verb Print -PassThru -Wait
   # Pausamos para que le de tiempo a entrar en la cola de impresión el fichero
   Start-Sleep -Seconds 5
}

