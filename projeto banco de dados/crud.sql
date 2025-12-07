-- 6. CRUD (Create, Read, Update, Delete)

-- ====================================================================================================
-- C - CREATE (Inserção de Dados)
-- ====================================================================================================

-- 1. Inserir um novo Tutor
INSERT INTO TUTOR (primeiro_nome, sobrenome, cpf, email)
VALUES ('Ana', 'Souza', '123.456.789-00', 'ana.souza@exemplo.com');

-- 2. Inserir um novo Animal para a Ana Souza (assumindo que o id_tutor gerado foi 501)
-- NOTA: O ID 501 é um exemplo. Em um ambiente real, você usaria RETURNING id_tutor ou saberia o ID gerado.
INSERT INTO ANIMAL (id_tutor, nome, especie, raca, data_nascimento)
VALUES (
    (SELECT id_tutor FROM TUTOR WHERE cpf = '123.456.789-00'),
    'Floco',
    'Gato',
    'Persa',
    '2023-05-10'
);

-- 3. Inserir um telefone para o novo Tutor (Atributo Multivalorado)
INSERT INTO TUTOR_TELEFONE (id_tutor, telefone)
VALUES (
    (SELECT id_tutor FROM TUTOR WHERE cpf = '123.456.789-00'),
    '(11) 98765-4321'
);

-- ====================================================================================================
-- R - READ (Leitura de Dados)
-- ====================================================================================================

-- 4. Selecionar todos os dados do novo Animal e calcular sua idade (Atributo Derivado)
SELECT
    A.nome AS nome_animal,
    A.especie,
    A.raca,
    A.data_nascimento,
    calcular_idade(A.data_nascimento) AS idade_anos,
    T.primeiro_nome || ' ' || T.sobrenome AS tutor
FROM ANIMAL A
JOIN TUTOR T ON A.id_tutor = T.id_tutor
WHERE A.nome = 'Floco' AND T.cpf = '123.456.789-00';

-- ====================================================================================================
-- U - UPDATE (Atualização de Dados)
-- ====================================================================================================

-- 5. Atualizar o email do Tutor 'Ana Souza'
UPDATE TUTOR
SET email = 'ana.souza.novo@exemplo.com'
WHERE cpf = '123.456.789-00';

-- 6. Atualizar a especialidade de um Veterinário (Exemplo: o Veterinário com id_veterinario = 1)
UPDATE VETERINARIO
SET especialidade = 'Dermatologia Avançada'
WHERE id_veterinario = 1;

-- ====================================================================================================
-- D - DELETE (Exclusão de Dados)
-- ====================================================================================================

-- 7. Excluir o Animal 'Floco' (e todas as suas consultas e prontuários relacionados, se as chaves estrangeiras estiverem configuradas com ON DELETE CASCADE)
DELETE FROM ANIMAL
WHERE nome = 'Floco' AND id_tutor = (SELECT id_tutor FROM TUTOR WHERE cpf = '123.456.789-00');

-- 8. Excluir o Tutor 'Ana Souza' (Se o animal 'Floco' já foi excluído, a exclusão do tutor deve ser possível)
DELETE FROM TUTOR
WHERE cpf = '123.456.789-00';
