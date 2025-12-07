----------------------------------------------------------------------- Relatórios -----------------------------------------------------------------------

-- 1. Animais e Seus Tutores: Lista de todos os animais, seus nomes, espécies, raças e o nome completo do tutor.
SELECT
    A.nome AS animal,
    A.especie,
    A.raca,
    T.primeiro_nome || ' ' || T.sobrenome AS tutor
FROM ANIMAL A
JOIN TUTOR T ON A.id_tutor = T.id_tutor
ORDER BY tutor, animal;

-- 2. Consultas por Veterinário: Contagem de consultas realizadas por cada veterinário, ordenado do mais ativo para o menos ativo.
SELECT
    V.nome AS veterinario,
    V.especialidade,
    COUNT(C.id_consulta) AS total_consultas
FROM VETERINARIO V
JOIN CONSULTA C ON V.id_veterinario = C.id_veterinario
GROUP BY V.nome, V.especialidade
ORDER BY total_consultas DESC;

-- 3. Animais Mais Velhos: Lista dos 10 animais mais velhos, mostrando o nome, data de nascimento e idade calculada.
SELECT
    nome,
    data_nascimento,
    calcular_idade(data_nascimento) AS idade_anos
FROM ANIMAL
ORDER BY idade_anos DESC
LIMIT 10;

-- 4. Consultas de um Mês Específico: Detalhes das consultas realizadas em um mês específico (ex: Novembro de 2024), incluindo o nome do animal e do veterinário.
SELECT
    C.data_hora,
    A.nome AS animal,
    V.nome AS veterinario,
    C.diagnostico
FROM CONSULTA C
JOIN ANIMAL A ON C.id_animal = A.id_animal
JOIN VETERINARIO V ON C.id_veterinario = V.id_veterinario
WHERE C.data_hora BETWEEN '2024-11-01' AND '2024-11-30'
ORDER BY C.data_hora;

-- 5. Produtos/Serviços Mais Utilizados: Ranking dos produtos e serviços mais utilizados em consultas, mostrando o total de vezes que foram registrados.
SELECT
    PS.nome,
    PS.tipo,
    SUM(CPS.quantidade) AS total_utilizado
FROM PRODUTO_SERVICO PS
JOIN CONSULTA_PRODUTO_SERVICO CPS ON PS.id_produto_servico = CPS.id_produto_servico
GROUP BY PS.nome, PS.tipo
ORDER BY total_utilizado DESC
LIMIT 10;

-- 6. Custo Total por Consulta: Cálculo do custo total de produtos/serviços utilizados em cada consulta.
SELECT
    C.id_consulta,
    C.data_hora,
    A.nome AS animal,
    SUM(CPS.quantidade * PS.preco) AS custo_total
FROM CONSULTA C
JOIN ANIMAL A ON C.id_animal = A.id_animal
JOIN CONSULTA_PRODUTO_SERVICO CPS ON C.id_consulta = CPS.id_consulta
JOIN PRODUTO_SERVICO PS ON CPS.id_produto_servico = PS.id_produto_servico
GROUP BY C.id_consulta, C.data_hora, A.nome
ORDER BY custo_total DESC;

-- 7. Veterinários sem Consultas Recentes: Veterinários que não realizaram consultas nos últimos 30 dias.
SELECT
    V.nome,
    V.especialidade
FROM VETERINARIO V
LEFT JOIN CONSULTA C ON V.id_veterinario = C.id_veterinario
GROUP BY V.id_veterinario, V.nome, V.especialidade
HAVING MAX(C.data_hora) < NOW() - INTERVAL '30 days' OR MAX(C.data_hora) IS NULL
ORDER BY V.nome;

-- 8. Prontuários e Data de Criação: Lista de animais e a data de criação de seus prontuários, para verificar a aderência ao relacionamento 1:1.
SELECT
    A.nome AS animal,
    P.data_criacao AS data_prontuario
FROM ANIMAL A
JOIN PRONTUARIO P ON A.id_animal = P.id_animal
ORDER BY data_prontuario DESC;
