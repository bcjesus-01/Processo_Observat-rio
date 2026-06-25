# 🧠 NLP POS-Tagging com NLTK e MacMorpho

Este repositório contém a implementação de algoritmos de Processamento de Linguagem Natural (PLN) focados na tarefa de **Part-of-Speech (POS) Tagging** (Etiquetagem Morfossintática) para a língua portuguesa.

O projeto foi desenvolvido como parte de um desafio técnico para um processo seletivo, demonstrando a construção desde uma linha de base estatística simples até um modelo hierárquico inteligente baseado em contexto.

## 🛠️ Tecnologias Utilizadas
* **Linguagem:** Python 3
* **Biblioteca Principal:** NLTK (Natural Language Toolkit)
* **Córpus de Treinamento:** MacMorpho (estruturado pelo NILC/USP com mais de 1 milhão de palavras etiquetadas).

## 🚀 Arquitetura do Projeto

O repositório é composto por dois scripts principais que demonstram a evolução do modelo:

### 1. Modelo de Linha de Base (`tagger.py`)
Estabelece o *baseline* do projeto. O script faz uma varredura estatística no córpus MacMorpho para descobrir a classe gramatical predominante na língua portuguesa (Substantivo - 'N') e utiliza o `DefaultTagger` para classificar todas as palavras de forma indiscriminada. Ideal para garantir a robustez do sistema ao lidar com vocabulário desconhecido (Out-Of-Vocabulary).

### 2. Modelo N-Gram com Backoff (`tagger_inteligente.py`)
Implementa uma hierarquia inteligente de etiquetadores baseados no contexto das palavras vizinhas. Utiliza o algoritmo de **Backoff** na seguinte ordem de prioridade:
1. **TrigramTagger:** Avalia a palavra atual e as duas anteriores.
2. **BigramTagger:** Avalia a palavra atual e a imediatamente anterior.
3. **UnigramTagger:** Avalia apenas a palavra isolada.
4. **DefaultTagger:** Retorna para a linha de base (Substantivo) caso os modelos anteriores falhem.
