/*filtros - Ordenação - Agrupamentos*/

/*Trazer o nome e o cpf de todos os associados que morem no estado de SP*/

SELECT nomeAssociados, Cpf, cidade
FROM associados AS a
INNER JOIN 
enderecos AS e 
ON a.idAssociado = e.idAssociado
WHERE e.cidade='São Vicente'

/*Funçoes de agregação*/

/*Count -contar 
Sum - Somar 
Avg - extrair a média
Min - menor valor
Max - Maior valor*/

/*<>* diferente ou not para fazer exclusão*/

/*group by - agrupar 

SELECT COUNT(idAsscociados) FROM associados

/*pega cidade, conta quantos asscociados tem nassas cidades*/
SELECT cidade, COUNT (idAssociado) AS 'Total de Associados' FROM Associados 

SELECT cidade, COUNT (idAssociado) AS 'Total de Associados' FROM enderecos 
GROUP BY cidade

SELECT cidade, COUNT (idAssociado) AS 'Total de Associados' FROM enderecos 
GROUP BY cidade
HAVING COUNT (idAssociados)>=4

SELECT cidade, COUNT (idAssociado) AS 'Total de Associados' FROM enderecos 
GROUP BY cidade
HAVING COUNT (idAssociados)>= 5
ORDER BY COUNT (idAssociado) ASC

SELECT cidade, COUNT(idAssociado) AS 'Total de Associados' FROM enderecos
GROUP BY cidade 
HAVING COUNT(idAssociado)>=4
ORDER BY 'Total de Associados' DESC;

/* having count para trabalhar com calculos e sempre usado após o agrupamento */

/* distinct separa os dados de forma diferentes, por ex, de forma direta e sem repetir os mesmo dados, te mostra quantos cidades unicamente existe dentro da tabela */
 
SELECT DISTINCT cidade FROM enderecos ORDER BY cidade ASC /* ordem alfabetica crescente */

/* somandos todos os valores de multas dentro da tabela multas*/
SELECT SUM(valor) AS 'Total em Multas (R$)' FROM multas
 
/* trazendo o maior valor dentro da tabela multas */
SELECT MAX(valor) AS 'Maior Multa Paga' FROM multas
 
/* O valor, o nome do associado e os contatos (email e telefone) 
do associado que pagou a maior multa */
 
SELECT nomeassociado, ddd, numero, email, valor FROM multas 
INNER JOIN emprestimos
ON multas.idemprestimo = emprestimos.idemprestimo
INNER JOIN associados
ON associados.idAssociado = emprestimos.idassociado
INNER JOIN emails
ON associados.idAssociado = emails.idAssociado
INNER JOIN contatostelefonicos
ON associados.idAssociado = contatostelefonicos.idAssociado
WHERE valor=(SELECT MAX(valor) FROM multas)
 
SELECT valor FROM multas
LIMIT 3

/* Exercicio: Todos os livros que possuam dois autores ou mais Dados do livro: nome livro, qtd paginas, editora*/


SELECT livros.nome,qtdPaginas, editoras.nomeEditoras 
FROM livros
INNER JOIN autoreslivros
ON livros.idLivro = autoreslivros.idlivro
INNER JOIN autores
ON autores.idAutor = autoreslivros.idAutor
INNER JOIN editoras
ON editoras.idEditora = livros.idEditora
GROUP BY livros.idlivro
HAVING COUNT(autoreslivros.idAutor)>=2