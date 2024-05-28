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

SELECT cidade, COUNT(idAssociado) AS 'Total de Associados' FROM enderecos 
GROUP BY cidade
HAVING COUNT(idAssociado)>= 5
ORDER BY COUNT(idAssociado) ASC

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

/*Exercicio: Relatório de quantos livros cada autor escreveu
levando em conta apenas os autores que escreveram mais de 2
livros. Tudo isto em ordem alfabética por nome do autor*/
 
SELECT * FROM livros
SELECT * FROM autores
 
 
SELECT autores.nome, COUNT(autoreslivros.idautor) FROM autoreslivros
INNER JOIN autores ON autoreslivros.idautor=autores.idautor
INNER JOIN livros ON autoreslivros.idlivro=livros.idlivro
GROUP BY autores.nome 
having COUNT(autoreslivros.idautor)>=2; 

/* Exercicio: Trazer quantos emprestimos foram realizados por data*/

SELECT DATE(retirada), COUNT(idEmprestimo)
AS 'Total Emprestimos'
FROM emprestimos 
GROUP BY DATE(retirada)
ORDER BY retirada DESC 

/*Sumiu um livro na biblioteca e precisamos saber o histórico
dos emprestimos deste livro. 
A query deve trazer o nome de quem o emprestou, a data, o nome 
do funcionario. Escolha um livro para servir como filtro da busca.
O resultado deve ser mostrado da data mais atual para a mais antiga*/

SELECT nomeFuncionario, retirada, dataDevolucaoEfetiva,nomeAssociado FROM funcionarios 
INNER JOIN emprestimos
ON funcionarios.idFuncionario = emprestimos.idFuncionario
INNER JOIN associados 
ON associados.idAssociado = emprestimos.idAssociado 
INNER JOIN emprestimoslivros
ON emprestimoslivros.idEmprestimo = emprestimos.idEmprestimo
INNER JOIN livros 
ON emprestimoslivros.idLivro = livros.idlivro
WHERE nome = 'A cantiga dos pássaros e das serpentes'
ORDER BY retirada DESC 

/*View é utilizado para maximizar a busca do relatiorio dos comondos como */
CREATE VIEW vw_EmprstimosPorFuncionarioEAssociado AS 
SELECT nomeFuncionario, retirada, dataDevolucaoEfetiva,nomeAssociado
FROM funcionarios 
INNER JOIN emprestimos
ON funcionarios.idFuncionario = emprestimos.idFuncionario
INNER JOIN associados 
ON associados.idAssociado = emprestimos.idAssociado 
INNER JOIN emprestimoslivros
ON emprestimoslivros.idEmprestimo = emprestimos.idEmprestimo
INNER JOIN livros 
ON emprestimoslivros.idLivro = livros.idlivro

SELECT * FROM vw_emprstimosporfuncionarioeassociado
WHERE nomeFuncionario = 'Maria Silva'

/*Exercicio: Criar uma view que traga o nome, o celular e o email dos associados Nome da View - AssociadoContatos*/

CREATE VIEW vw_AssociadoContatos as
SELECT nomeAssociado,DDD, numero, emailAsso
FROM associados 
INNER JOIN contatostelefonicos
ON associados.idAssociado = contatostelefonicos.idAssociado
INNER JOIN emails 
ON emails.idAssociado = associados.idAssociado
/*INNER JOIN tiposcontatos 
ON tiposcontatos.idTipoContato = associados.idAssociado*/
/*GROUP BY (nomeAssociado)
ORDER BY nomeAssociado ASC*/

SELECT * FROM vw_associadocontatos

/*Stored Procedures - Procedimentos Armazenados
Criar uma procedure para inserir uma editora*/

DROP PROCEDURE pi_Editoras

CREATE PROCEDURE pi_Editoras
(IN nome VARCHAR(30))
INSERT INTO editoras(nomeeditoras)
VALUES (nome);

CALL pi_editoras ('Abril')

select * FROM editoras 

DELETE FROM editoras WHERE idEditora>5 

/*Exercicio: Criar uma procedure que taga quantos emprestimos foram realizados por associados*/



/*Exercicio: Criar uma procedure que traga quantos emprestimos foram realizados por determinado associado por nome*/



