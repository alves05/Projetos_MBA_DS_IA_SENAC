# 📊 Análise Estatística do Preço de Casas

Este projeto tem como objetivo explorar os principais fatores que influenciam o preço de imóveis residenciais, por meio de análise estatística descritiva e inferencial utilizando Python.

## 🧠 Objetivo

Investigar, com base em dados reais, quais características têm maior impacto no preço de casas. A análise inclui estatísticas descritivas, visualizações e testes de hipóteses para entender correlações e relações causais.

## 📚 Equipe

* Antônio Nunes
* Jonatha Weydson
* Sanderson Rhawan
* Saulo Bernardo
* Washington França
* Williams Alves

## 🗂️ Conjunto de Dados

* **Fonte:** Base própria (545 registros)
* **Formato:** CSV (`Grupo 1 - Imobiliario - Preço de Casas.csv`)
* **Variáveis:**

  * Contínuas: `Preco`, `Area`
  * Discretas: `Quartos`, `Banheiros`, `NumAndares`, `VagasGaragem`
  * Categóricas: `EstradaPrincipal`, `QuartoHospedes`, `AquecimentoAgua`, `Mobilia`

## 🛠️ Ferramentas e Bibliotecas

* Python
* Pandas
* Plotly
* Statsmodels

## 📈 Metodologia

1. **Estatística Descritiva:**
   Média, mediana, desvio padrão e distribuição de variáveis.

2. **Visualizações:**
   Histogramas, gráficos de dispersão, barras e boxplots para ilustrar as relações entre variáveis.

3. **Estatística Inferencial:**
   Testes de hipótese (regressão linear) para verificar impacto de variáveis como `QuartoHospedes` e `Quartos` sobre o preço.

## 🔍 Principais Descobertas

* A **área** e o número de **banheiros** apresentam as **maiores correlações** com o preço.
* Imóveis **mobiliados** e **com aquecimento de água** tendem a ter preços mais altos.
* Imóveis em **estradas principais** ou em **andares mais altos** também têm valorização.
* A **presença de quarto de hóspedes** impacta significativamente no preço, conforme teste de hipótese (p-valor ≈ 0.0000000014).

## 📊 Visualizações Incluídas

* Distribuição de preços
* Relação entre área e preço
* Preço médio por localização, número de andares, quartos, banheiros, vagas, mobiliado ou não
* Mapa de correlação entre variáveis numéricas

## 🧪 Inferências Realizadas

* Regressão simples para verificar o efeito de `QuartoHospedes` e `Quartos` sobre `Preco`
* Intervalos de confiança demonstrando aumentos significativos no preço em ambos os casos

## 📁 Estrutura do Projeto

```
.
├── Base/
│   └── Grupo 1 - Imobiliario - Preço de Casas.csv
├── analise_estatistica_preco_casas.pdf
├── main.py (ou notebook com análises)
└── README.md
```

## 📌 Conclusão

A análise evidencia a complexidade do mercado imobiliário e como múltiplas variáveis se combinam para determinar o valor de uma propriedade. Esta abordagem estatística pode ser útil para compradores, vendedores e investidores no setor.

