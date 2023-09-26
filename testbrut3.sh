

dominio_alvo="vulnweb.com"
arquivo_wordlist="wordl.txt"
arquivo_saida="cuk.txt"


verificar_subdominio() {
    subdominio="$1"
    resultado=$(nslookup "$subdominio.$dominio_alvo" | grep -E "Name:.*$dominio_alvo")

    if [[ -n "$resultado" ]]; then
        ip=$(echo "$resultado" | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b")
        echo "Subdomínio: $subdominio.$dominio_alvo " >> "$arquivo_saida"
    fi
}


while IFS= read -r palavra; do
    verificar_subdominio "$palavra"
    sleep 1
done < "$arquivo_wordlist"

echo "Subdomínios encontrados foram salvos no $arquivo_saida."
