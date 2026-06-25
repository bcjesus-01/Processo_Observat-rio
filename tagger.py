import nltk
from nltk.corpus import mac_morpho

# Garante que os pacotes necessários do NLTK estão baixados
nltk.download('mac_morpho')
nltk.download('punkt')
nltk.download('punkt_tab') # Garantia extra para versões mais recentes do NLTK

# 1. Carrega as sentenças rotuladas do Corpus MacMorpho
sentencas_etiquetadas = mac_morpho.tagged_sents()

# 2. Descobre qual é a etiqueta (tag) mais frequente em todo o córpus
tags = [tag for (word, tag) in mac_morpho.tagged_words()]
tag_mais_comum = nltk.FreqDist(tags).max()

print(f"A tag mais comum no português é: '{tag_mais_comum}'")

# 3. Cria o tagger padrão (DefaultTagger) usando a tag mais comum ('N')
etiqPadrao = nltk.tag.DefaultTagger(tag_mais_comum)

# 4. Criando uma frase de teste com um contexto de arquitetura de computadores para gerar os tokens
texto_teste = "A memoria RAM conecta diretamente no barramento."
tokens = nltk.word_tokenize(texto_teste)

# 5. Executando o tagger
resultado = etiqPadrao.tag(tokens)
print(resultado)
