# Teste de Seleção

* [1. Resposta](#1-resposta)
* [2. Instruções para execução](#2-instruções-para-execução)
* [3. Sobre a solução](#3-sobre-a-solução)

## 1. Resposta

O Real é a atual moeda oficial do Brasil e que foi adotada em julho de 1994, seu código ISO é o BRL. Em seu lançamento, havia uma paridade de R$ 1 : US$ 1, ou seja, 1 real equivalia a 1 dólar americano de código USD. De posse dessas informações, usando qualquer linguagem de programação, elabore um código que obtenha cotações da moeda entre os períodos de **7 de Agosto de 2009 a 17 de Novembro de 2011**, tendo como base o dólar, do [Fixer.io](http://fixer.io/). Esse serviço é gratuito e atualizado diariamente com dados do Banco Central Europeu. Para a data de hoje, por exemplo, podemos notar que a cotação é de R$ 3,0953.

Para o período compreendido, responda às seguintes questões:

#### 1. Em qual dia foi observado o menor valor?

R: Menor valor registrado no dia **26/07/2011 (R$ 1,5347)**.

#### 2. Em qual dia foi observado o maior valor?

R: Maior valor registrado no dia **23/09/2011 (R$ 1,9111)**.

#### 3. Qual é a média da cotação para esse período, excetuando os dias de início e fim?

R: A cotação média no período entre **08/08/2009 e 16/11/2011** é de **R$ 1,7207** (arredondado em quatro casas decimais).

---

## 2. Instruções para execução

A solução foi feita em Ruby on Rails.

* Versão do *Ruby:* 2.3.1

* Versão do *Rails:* 5.0.4

Para executá-la, utilize os seguintes comandos:

* Execute o comando abaixo para instalar as *gems* necessárias:

  `$ bundle install`

* Crie o banco de dados e as *migrations*:

  `$ rake db:migrate`

* Inicialize o banco de dados:

  `$ rake db:seed`

* Suba o servidor local:

  `$ rails s`

* Acesse o endereço do *localhost* da sua máquina.

---

## 3. Sobre a solução

Para lidar com as requisições, primeiramente foi utilizado o módulo [OpenURI](http://www.rubydoc.info/stdlib/open-uri/OpenURI) do Ruby. Contudo, as requisições estavam levando um tempo considerável. Para resolver esse problema, passou a se utilizar a gem [Typhoeus](https://github.com/typhoeus/typhoeus), que é capaz de lidar com várias requisições de forma paralela. Entretanto, a API não suportou o número de requisições (833 ao total) e devolvia resultados indicando *rate limit  exceeded*. Lendo a documentação e o histórico de *issues* da API, notou-se que ela permite 50 requisições iniciais, e depois 5 requisições de uma mesma fonte por segundo. Então, optou-se por fazer as requisições uma a uma, pois mesmo configurando o número máximo de requisições concorrentes como 2 ainda havia problema com limite excedido.

Por questões de otimização e por se tratarem de dados arquivados e imutáveis, optou-se por gerar previamente um JSON com todos os dados necessários da API, dado o tamanho do escopo. Tal algoritmo pode ser encontrado nesse [link](https://github.com/joao18araujo/exchange_rate/blob/master/app/assets/algorithms/pre_process_algorithm.rb), o JSON gerado pode ser encontrado nesse [link](https://github.com/joao18araujo/exchange_rate/blob/master/app/assets/algorithms/currencies.json). Após esse pré-processamento, o JSON citado é utilizado para alimentar a tabela BrlExchangeRate no banco de dados por meio do arquivo [seeds.rb](https://github.com/joao18araujo/exchange_rate/blob/master/db/seeds.rb). Também foi criada uma *model* simples com os atributos de data (*date*) e valor da cotação do dia (*value*).

Os cálculos de máximo, mínimo e média são feitos na [index da controller](https://github.com/joao18araujo/exchange_rate/blob/master/app/controllers/brl_exchange_rates_controller.rb) e utilizam os dados já cadastrados no banco, a [view](https://github.com/joao18araujo/exchange_rate/blob/master/app/views/brl_exchange_rates/index.html.erb) mostra o valor dos dados analisados. Em ambos, há validações para o caso do banco de dados estar vazio ou incompleto.

Vale ressaltar que o valor de máximo está presente em 3 datas diferentes (23/09/2011, 24/09/2011 e 25/09/2011), mas isso se deve ao fato de que o fornecedor dos dados da API não atualiza as cotações aos finais de semana, permanecendo o último valor calculado. Então, o primeiro dia de ocorrência do valor foi considerado como a resposta.

Segue abaixo uma foto da solução sendo executada:

![solucao](https://upload.wikimedia.org/wikipedia/commons/e/ec/Teste_de_Sele%C3%A7%C3%A3o.png)
