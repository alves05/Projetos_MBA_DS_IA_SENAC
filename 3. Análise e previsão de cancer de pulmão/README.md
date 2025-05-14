# Projeto: Previsão de Cancer de Pulmão
## **Objetivo do projeto**

O projeto tem o objetivo de criar um sistema eficaz de previsão de cancer de pulmão para uma população observada em um hospital especializado em tratamento de câncer de pulmão. O modelo criado deverá ter uma acurácia igual ou maior que **95%**, será usado o algoritmo de classificação **Random Forest**.

O modelo poderá ser usado para auxiliar os médicos à terem um pré diagnostico com baixo custo e também os ajudará a tomar decisões adequada com base no estado de risco de cancer do paciente.

As características e observações da base de dados que serão exploradas durante o projeto terá como referência apenas a população observada na base, assim como suas características.

A base de dados [Lung Cancer](https://www.kaggle.com/datasets/mysarahmadbhat/lung-cancer/) está disponível ao público no Kaggle.

A base de dados contém as seguintes informações em seus atributos:

|Variável|Valores|Descrição|
|---|---|---|
|Gender|M(masculino), F(feminino)|Classificação do genero.|
|Age|Idade do paciente|números inteiros|
|Smoking|YES=2, NO=1| booleano|
|Yellow fingers|YES=2 , NO=1|booleano|
|Anxiety|YES=2 , NO=1|booleano
|Peer_pressure|YES=2 , NO=1|booleano|
|Chronic Disease|YES=2 , NO=1|booleano|
|Fatigue|YES=2 , NO=1|booleano|
|Allergy|YES=2 , NO=1|booleano|
|Wheezing|YES=2 , NO=1|booleano|
|Alcohol|YES=2 , NO=1|booleano|
|Coughing|YES=2 , NO=1|booleano|
|Shortness of Breath|YES=2 , NO=1|booleano|
|Swallowing Difficulty|YES=2 , NO=1|booleano|
|Chest pain|YES=2 , NO=1|booleano|
|Lung Cancer|YES, NO|YES para com cancer e NO para sem cancer|

## **Metodologia**

A moteodologia utilizada no projeto foi a CRISP-DM, seguindo os passos abaixo:

1. **Análise descritiva com ETL (Extract, Transform, Load)**:
  - [x] Extract: Extração dos dados da plataforma kaggle;
  - [x] Transform: Transformação dos dados;
  - [x] Load: Utilização dos dados em análise descritiva e modelagem preditiva.

2. **Modelagem Preditiva**:
  - [x] Pré processamento dos dados;
  - [x] Treinamento do modelo de machine learning;
  - [x] Seleção de hiperparâmetros;
  - [x] Avaliação do modelo de machine learning.

## **Resultados**

### **Inferências**:

As hipóteses foram levantadas a partir do estudo especifico da base utilizada para o projeto.

- Hipótese 1: Idade não influencia no desenvolvimento de câncer de pulmão.
    - **Resultado**: A hipótese é nula, a idade não tem ligação no desenvolvimento de câncer de pulmão. 
O teste apresenta o Valor-p de 0.1165504293. 

    Não é possível afirmar que a idade tem uma influência significativa no desenvolvimento de câncer de pulmão. A hipótese nula de que a idade não influencia o desenvolvimento de câncer de pulmão não foi rejeitada, e o intervalo de confiança sugere que qualquer efeito da idade seria muito pequeno.

- Hipótese 2: Fumar não causa câncer de pulmão.
    - **Resultado**: A hipótese é nula, ser fumante não influencia no desenvolvimento de câncer de pulmão. 
O teste apresenta o Valor-p de 0.3080081864. 

    Embora um censu comum na relação entre fumar e o câncer de pulmão, os resultados não são estatisticamente significativos. Portanto, com base neste teste específico, não podemos afirmar com certeza que fumar causa câncer de pulmão.

- Hipótese 3: Fumantes tendem a não ter ansiedade.
    - **Resultado**: Hipótese nula rejeitada, indicando que fumantes tem quadro de ansiedade, conforme os resultados: 
        - Valor-p de 0.0047414194 
        - Intervalo de confiança de 0.05 | 0.27 em 95% dos casos.

    Em resumo, os dados indicam que fumantes têm uma maior probabilidade de apresentar ansiedade em comparação com não fumantes.

- Hipótese 4: Ser fumante não indica dores no peito.
    - **Resultado**: Hipótese nula rejeitada, indicando que fumantes tem quadro de dores no peito, conforme os resultados: 
        - Valor-p de 0.0348099738 
        - Intervalo de confiança de 0.01 | 0.23 em 95% dos casos

    Esses resultados reforçam a conclusão de que fumar está associado a um aumento na ocorrência de dores no peito.

- Hipótese 5: Fumantes passivos tendem a não desenvolver câncer.
    - **Resultado**: Hipótese nula rejeitada, indicando que fumantes passivos tem quadro de desenvolvimento de câncer de pulmão, conforme os resultados: 
        - Valor-p de 0.0009947363 
        - Intervalo de confiança de 0.05 | 0.20 em 95% dos casos
    
    Esses resultados reforçam a conclusão de que o fumo passivo está associado a um risco aumentado de câncer de pulmão.

- Hipótese 6: Doenças crônicas não tem relação com desenvolver câncer.
    - **Resultado**: A hipótese é nula, doenças crônicas não tem ligação a desenvolvimento de cânce de pulmão. 
O teste apresenta o Valor-p de 0.0514871193.

    Esse resultado indica que, com base nos dados fornecidos, não há uma associação significativa entre ter uma doença crônica e o desenvolvimento de câncer de pulmão.


### **Modelo de Machine Learning**

Abaixo estão os resultados finais do modelo de machine learning treinado a partir da base de dados utilizada no projeto.
- Accuracy: 96.91%
- Cross validation: 96.85%
- Curve ROC: 0.99817

## Conclusão
O modelo de **Random Forest** atingiu uma acurácia de **96.91%** atigindo a meta estabelecida para o projeto de acurácia acima de **95%**, o resultado da acurácia indica um bom desempenho na predição da presença de câncer de pulmão com base nas variáveis analisadas. O melhoramento do modelo com as definições do hiperparâmetros contribuiram para a consolidação do resultado satisfatório. A validação do modelo utilizando **Accuracy, Cross validation, Curve ROC e Matrix Confusion**, nos aponta que o modelo desenvolvido neste projeto é robusto e generaliza bem para novos dados.