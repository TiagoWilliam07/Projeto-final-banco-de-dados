-- 4. Modelagem Física (Script SQL - PostgreSQL/Supabase)

-- Tabela TUTOR
CREATE TABLE TUTOR (
    id_tutor SERIAL PRIMARY KEY,
    primeiro_nome VARCHAR(50) NOT NULL,
    sobrenome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

-- Tabela TUTOR_TELEFONE (Para atributo multivalorado 'telefone')
CREATE TABLE TUTOR_TELEFONE (
    id_tutor INTEGER NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    PRIMARY KEY (id_tutor, telefone),
    FOREIGN KEY (id_tutor) REFERENCES TUTOR(id_tutor) ON DELETE CASCADE
);

-- Tabela VETERINARIO
CREATE TABLE VETERINARIO (
    id_veterinario SERIAL PRIMARY KEY,
    crmv VARCHAR(20) UNIQUE NOT NULL,
    nome VARCHAR(150) NOT NULL,
    especialidade VARCHAR(100) NOT NULL
);

-- Tabela ANIMAL
CREATE TABLE ANIMAL (
    id_animal SERIAL PRIMARY KEY,
    id_tutor INTEGER NOT NULL,
    nome VARCHAR(50) NOT NULL,
    especie VARCHAR(50) NOT NULL,
    raca VARCHAR(50),
    data_nascimento DATE NOT NULL,
    FOREIGN KEY (id_tutor) REFERENCES TUTOR(id_tutor) ON DELETE RESTRICT
);

-- Tabela PRONTUARIO (Relacionamento 1:1 com ANIMAL)
CREATE TABLE PRONTUARIO (
    id_prontuario SERIAL PRIMARY KEY,
    id_animal INTEGER UNIQUE NOT NULL, -- UNIQUE garante o 1:1
    data_criacao DATE NOT NULL DEFAULT CURRENT_DATE,
    observacoes_gerais TEXT,
    FOREIGN KEY (id_animal) REFERENCES ANIMAL(id_animal) ON DELETE CASCADE
);

-- Tabela CONSULTA
CREATE TABLE CONSULTA (
    id_consulta SERIAL PRIMARY KEY,
    id_animal INTEGER NOT NULL,
    id_veterinario INTEGER NOT NULL,
    data_hora TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    diagnostico TEXT,
    tratamento TEXT,
    FOREIGN KEY (id_animal) REFERENCES ANIMAL(id_animal) ON DELETE RESTRICT,
    FOREIGN KEY (id_veterinario) REFERENCES VETERINARIO(id_veterinario) ON DELETE RESTRICT
);

-- Tabela PRODUTO_SERVICO
CREATE TABLE PRODUTO_SERVICO (
    id_produto_servico SERIAL PRIMARY KEY,
    nome VARCHAR(150) UNIQUE NOT NULL,
    tipo VARCHAR(10) NOT NULL CHECK (tipo IN ('Produto', 'Serviço')),
    preco NUMERIC(10, 2) NOT NULL CHECK (preco >= 0)
);

-- Tabela CONSULTA_PRODUTO_SERVICO (Para relacionamento N:N entre CONSULTA e PRODUTO_SERVICO)
CREATE TABLE CONSULTA_PRODUTO_SERVICO (
    id_consulta INTEGER NOT NULL,
    id_produto_servico INTEGER NOT NULL,
    quantidade INTEGER NOT NULL CHECK (quantidade > 0),
    PRIMARY KEY (id_consulta, id_produto_servico),
    FOREIGN KEY (id_consulta) REFERENCES CONSULTA(id_consulta) ON DELETE CASCADE,
    FOREIGN KEY (id_produto_servico) REFERENCES PRODUTO_SERVICO(id_produto_servico) ON DELETE RESTRICT
);

-- Função para calcular a idade (Atributo Derivado)
CREATE OR REPLACE FUNCTION calcular_idade(data_nasc DATE)
RETURNS INTEGER AS $$
BEGIN
    RETURN DATE_PART('year', AGE(CURRENT_DATE, data_nasc));
END;
$$ LANGUAGE plpgsql IMMUTABLE;
