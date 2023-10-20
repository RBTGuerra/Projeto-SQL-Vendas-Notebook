-- Databricks notebook source
-- MAGIC %md
-- MAGIC >##*Quais fatores Podem afetar os preços dos Notebooks?*##
-- MAGIC
-- MAGIC * Vários fatores diferentes podem afetar os preços dos laptops. Esses fatores incluem a marca do computador e o número de opções e complementos incluídos no pacote do computador. Além disso, a quantidade de memória e a velocidade do processador também podem afetar os preços. Embora menos comuns, alguns consumidores gastam dinheiro adicional para comprar um computador com base no visual geral “ ” e no design do sistema.
-- MAGIC
-- MAGIC * Em muitos casos, os computadores de marca são mais caros que as versões genéricas. Esse aumento de preço geralmente tem mais a ver com reconhecimento de nome do que com qualquer superioridade real do produto. Uma grande diferença entre a marca de nome e os sistemas genéricos é que, na maioria dos casos, os computadores de marca oferecem melhores garantias do que as versões genéricas. Ter a opção de retornar um computador com defeito costuma ser um incentivo suficiente para incentivar muitos consumidores a gastar mais dinheiro.
-- MAGIC
-- MAGIC * A funcionalidade é um fator importante na determinação dos preços dos laptops. Um computador com mais memória geralmente apresenta melhor desempenho por mais tempo do que um computador com menos memória. Além disso, o espaço no disco rígido também é crucial, e o tamanho do disco rígido geralmente afeta os preços. Muitos consumidores também podem procurar drivers de vídeo digital e outros tipos de dispositivos de gravação que podem afetar os preços dos laptops.
-- MAGIC
-- MAGIC * A maioria dos computadores vem com algum software pré-instalado. Na maioria dos casos, quanto mais software é instalado em um computador, mais caro é. Isso é especialmente verdadeiro se os programas instalados forem de editores de software bem estabelecidos e reconhecíveis. Aqueles que consideram comprar um novo laptop devem estar cientes de que muitos dos programas pré-instalados podem ser apenas versões de teste e expirarão dentro de um determinado período de tempo. Para manter os programas, um código precisará ser adquirido e, em seguida, uma versão permanente do software poderá ser baixada.
-- MAGIC
-- MAGIC * Muitos consumidores que estão comprando um novo computador estão comprando um pacote inteiro. Além do próprio computador, esses sistemas geralmente incluem um monitor, teclado e mouse. Alguns pacotes podem até incluir uma impressora ou câmera digital. O número de extras incluídos em um pacote de computador geralmente afeta os preços dos laptops.
-- MAGIC
-- MAGIC * Alguns líderes do setor na fabricação de computadores o tornam um ponto de venda para oferecer computadores com estilo elegante e em uma variedade de cores. Eles também podem oferecer design de sistema incomum ou contemporâneo. Embora isso seja menos importante para muitos consumidores, para aqueles que têm o valor “, ” esse tipo de sistema pode valer o custo extra.
-- MAGIC
-- MAGIC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # *Análise Descritiva(SQL)*

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## *Exploração/Desenvolvimento*

-- COMMAND ----------

alter view vw_notebooks_vendidos_1 
as
select *,
(preco_atual * 0.063) as preco_atual_real ,
(preco_antigo * 0.063) as preco_antigo_real, 
(desconto/100) as desconto_pt
from notebooks_vendidos_1


-- COMMAND ----------

select * from vw_notebooks_vendidos_1

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ###*Média de Preço das Marcas*###

-- COMMAND ----------

select
case when marca = 'lenovo' then 'Lenovo' 
     else marca 
end as marca_ajustada,
avg(preco_atual_real) as media_preco_atual
from vw_notebooks_vendidos_1
group by case when marca = 'lenovo' then 'Lenovo' 
     else marca 
end
order by 2 desc

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####*Como Podemos ver acima as 3 marcas em destaque mais caras São Alien Ware, Apple e Asus, empresas conceituadas no segmento de informática, o que mostra possiveis computadores provavelmente mais robustos específicos para um tipo de público, como Gamer, Designer ou até mesmo Desenvolvedor.*####

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ###Participação das Memórias (DDR3, DDR4 e DDR5)###

-- COMMAND ----------

select
case when tipo_memoria ='LPDDR3' then 'DDR3'
     when tipo_memoria in ('LPDDR4','LPDDR4X') then 'DDR4'
else tipo_memoria end as tipo_memoria_ajustado,
sum(preco_atual_real) as soma_preco_atual
from vw_notebooks_vendidos_1
group by 

case when tipo_memoria ='LPDDR3' then 'DDR3'
     when tipo_memoria in ('LPDDR4','LPDDR4X') then 'DDR4'
else tipo_memoria end

order by 2 desc


-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####*Ao Analisar o Gráfico Acima podemos ver as memórias com mais participação nos computadores são as DDR4, no qual o motivo provavél possa ser o custo benfício alinhado com a compatibilidade na maioria das configurações dos computadores.*####

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ##Placa de Video##

-- COMMAND ----------

select placa_de_video from vw_notebooks_vendidos_1

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####*Podemos ver no gráfico acima que 70% dos Notebook não possuem placa de video, o que pode indicar que os mesmos seja para uso convencional, sem a necessidade de uma placa de video o que poderia encarecer o produto ainda mais.*#### 

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ##Participação dos Processadores##

-- COMMAND ----------

select  nome_processador,
sum(preco_atual_real) as sum_preco_atual
from vw_notebooks_vendidos_1
group by nome_processador
order by 2








-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####*Através Deste gráfico podemos perceber os 3 processadores mais presentes nos Notebooks são Microsoft indicando uma possivel alta na venda dos mesmos.*####

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ##Avaliações##

-- COMMAND ----------

select nota from vw_notebooks_vendidos_1

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####*Por fim Podemos Identificar que 30% dos clientes não avaliaram sobre o produto, o que indica que precisaria ser feito um trabalho alinhado com pós venda e Customer Success para mitigar esses dados.*####
