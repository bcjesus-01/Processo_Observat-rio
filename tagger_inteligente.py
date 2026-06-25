import nltk
from nltk.corpus import mac_morpho

# 1. Carrega as sentenças rotuladas para o treinamento
print("Carregando o córpus MacMorpho...")
sentencas_etiquetadas = mac_morpho.tagged_sents()

# 2. Construindo a hierarquia de Taggers (Algoritmo de Backoff)
print("Treinando os modelos estatísticos (isso pode levar alguns segundos)...")
t0 = nltk.tag.DefaultTagger('N')
t1 = nltk.tag.UnigramTagger(sentencas_etiquetadas, backoff=t0)
t2 = nltk.tag.BigramTagger(sentencas_etiquetadas, backoff=t1)
t3 = nltk.tag.TrigramTagger(sentencas_etiquetadas, backoff=t2)

# 3. Testando com a mesma frase
texto_teste = "A memoria RAM conecta diretamente no barramento."
tokens = nltk.word_tokenize(texto_teste)

# 4. Executando o tagger mais avançado (t3 - Trigram)
resultado = t3.tag(tokens)

print("\nResultado do Tagger Inteligente:")
print(resultado)
