db_senabiblio
/*DDL*/

CREATE TABLE autores  (
idAutor INT AUTO_INCREMENT NOT NULL,
nome VARCHAR(45) NOT NULL,
CONSTRAINT PRIMARY KEY (idAutor)
) ;


CREATE TABLE editoras ( 
idEditora INT AUTO_INCREMENT NOT NULL,
nomeEditoras VARCHAR (30) NOT NULL,
CONSTRAINT PRIMARY KEY (idEditora)
);

CREATE TABLE livros (
idLivro INT AUTO_INCREMENT NOT NULL,
nome VARCHAR (45) NOT NULL,
sinopse VARCHAR(150),
isbn CHAR(13) NOT NULL,
qtdPaginas INT NOT NULL,
edicao INT,
idEditora INT NOT NULL,
CONSTRAINT PRIMARY KEY (idLivro),
CONSTRAINT Fk_livros_editoras FOREIGN KEY (idEditora)
REFERENCES Editoras (idEditora)
);

CREATE TABLE generos (
idGenero INT AUTO_INCREMENT NOT NULL,
nomeGenero VARCHAR (20) NOT NULL,
CONSTRAINT PRIMARY KEY (idGenero)
);

CREATE TABLE livrosGeneros(
idlivro INT NOT NULL,
idGenero INT NOT NULL,
CONSTRAINT PRIMARY KEY (idlivro,idGenero),
CONSTRAINT fk_livrosGeneros_Generos FOREIGN KEY (idGenero)
REFERENCES Generos(idGenero),
CONSTRAINT fk_livrosgenros_Livros FOREIGN KEY (idlivro)
REFERENCES livros (idlivro)
);

CREATE TABLE associados (
idAssociado INT AUTO_INCREMENT NOT NULL,
nomeAssociado VARCHAR(45) NOT NULL,
cpf CHAR(11) NOT NULL,
CONSTRAINT PRIMARY KEY (idAssociado)
);

CREATE TABLE enderecos (
idEndereco INT AUTO_INCREMENT NOT NULL,
logradouro VARCHAR(50) NOT NULL,
numero VARCHAR(8) NOT NULL,
complemento VARCHAR (10) NOT NULL,
bairro VARCHAR(30),
UF CHAR(2) NOT NULL,
cidade VARCHAR(50) NOT NULL,
CEP CHAR(8) NOT NULL,
IdAssociado INT NOT NULL,
CONSTRAINT PRIMARY KEY (idEndereco),
CONSTRAINT FK_enderecos_associados FOREIGN KEY (idAssociado) REFERENCES associados (idAssociado)
);

CREATE TABLE emails(
idEmail INT AUTO_INCREMENT NOT NULL,
emailAsso VARCHAR(50),
idAssociado INT NOT NULL,
CONSTRAINT PRIMARY KEY (idEmail),
CONSTRAINT FK_emails_associados FOREIGN KEY (idAssociado)
REFERENCES Associados (idAssociado)
);

CREATE TABLE tiposContatos(
idTipoContato INT AUTO_INCREMENT NOT NULL,
nomeContato VARCHAR(45),
CONSTRAINT PRIMARY KEY (idTipoContato)
);

CREATE TABLE contatosTelefonicos (
IdContato INT AUTO_INCREMENT NOT NULL,
ddd CHAR(2),
numero VARCHAR(9) NOT NULL,
idAssociado INT NOT NULL,
idTipoContato INT NOT NULL,
CONSTRAINT PRIMARY KEY (idContato),
CONSTRAINT fk_contatosTelefonicos_tiposContatos FOREIGN KEY (idTipoContato)
REFERENCES Tiposcontatos (idTipoContato),
CONSTRAINT fk_contatosTelefonicos_associados FOREIGN KEY (idAssociado)
REFERENCES Associados (idAssociado)
);

CREATE TABLE autoresLivros (
IdAutor INT NOT NULL,
IdLivro INT NOT NULL,
CONSTRAINT PRIMARY KEY (idAutor, idLivro),
CONSTRAINT fk_autoresLivros_Autores FOREIGN KEY (idAutor)
REFERENCES autores (idAutor),
CONSTRAINT fk_autoresLivros_Livros FOREIGN KEY (idLivro)
REFERENCES livros (idLivro)
);

CREATE TABLE funcionarios(
IdFuncionario INT AUTO_INCREMENT  NOT NULL,
nomeFuncionario VARCHAR(50) NOT NULL,
loginFuncionario VARCHAR(50) NOT NULL,
senhaFuncionario CHAR(8) NOT NULL,
CONSTRAINT PRIMARY KEY (idFuncionario)
);

CREATE TABLE emprestimos(
idEmprestimo INT AUTO_INCREMENT NOT NULL,
Retirada DATETIME NOT NULL,
Devolucao DATETIME NOT NULL, 
dataDevolucaoEfetiva DATETIME NOT NULL,
idFuncionario INT NOT NULL,
idAssociado INT NOT NULL, 
CONSTRAINT PRIMARY KEY (IdEmprestimo),
CONSTRAINT pk_emprestimos_funcionarios FOREIGN KEY (idFuncionario)
REFERENCES funcionarios (idFuncionario),
CONSTRAINT pk_emprestimo_associado FOREIGN KEY (idAssociado)
REFERENCES associados (idAssociado)
);

CREATE TABLE multas(
idMulta INT NOT NULL AUTO_INCREMENT, 
valor FLOAT(6,2) NOT NULL,
statusMultas BOOLEAN NOT NULL,
dataPagamento DATETIME,
idEmprestimo INT NOT NULL, 
idLivro INT NOT NULL, 
CONSTRAINT PRIMARY KEY (idMulta), 
CONSTRAINT fk_multas_emprestimos FOREIGN KEY (idEmprestimo)
REFERENCES Emprestimos(idEmprestimo), 
CONSTRAINT fk_multas_livros FOREIGN KEY (idLivro) 
REFERENCES Livros(idLivro)
);


CREATE TABLE EmprestimosLivros (
idEmprestimo INT NOT NULL,
idLivro INT NOT NULL,
dataDevolucaoEfetiva DATETIME NOT NULL,
CONSTRAINT pk_EmprestimosLivros PRIMARY KEY (idEmprestimo, idLivro),
CONSTRAINT fk_EmprestimosLivros_Emprestimo FOREIGN KEY (idEmprestimo) 
REFERENCES emprestimos(idEmprestimo),
CONSTRAINT fk_EmprestimosLivros_Livros FOREIGN KEY (idLivro) 
REFERENCES livros(idLivro)
);

SHOW TABLES









