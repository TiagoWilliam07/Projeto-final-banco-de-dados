# Projeto Final de Modelagem de Banco de Dados - Clínica Veterinária "Pelo Amigo" (Prof marcio)

Este e o projeto final(avaliacao) 

Este projeto demonstra o conhecimento adquirido na disciplina de Modelagem de Banco de Dados, criando entao a ``Clínica Veterinária "Pelo Amigo"``, com o intuito de gerar praticidade e facilidade na organizacao de tutores, animais, consultas etc.

``todos os dados desse trabalho e ficticio``


## 1. Cenário

### Descrição da Empresa
A ``Clínica Veterinária "Pelo Amigo`` é uma instituição de médio porte dedicada ao cuidado e bem-estar de animais de estimação. Oferece serviços completos, incluindo consultas de rotina, vacinação, cirurgias, exames laboratoriais e serviços complementares como banho e tosa. O foco é na gestão integrada de tutores, animais, veterinários, consultas e estoque/serviços.

### Problema e Necessidade
O sistema anterior, baseado em fichas de papel e planilhas, gerava ineficiência na recuperação de histórico médico, erros de agendamento e controle de estoque deficiente. O novo ``Sistema de Gerenciamento Integrado`` visa centralizar as informações, otimizar o fluxo de trabalho e melhorar a qualidade do atendimento.

### Entidades Principais
1.  **TUTOR**: Responsável pelo animal.
2.  **ANIMAL**: O paciente da clínica.
3.  **VETERINARIO**: Profissional que realiza as consultas.
4.  **CONSULTA**: Registro do atendimento médico.
5.  **PRODUTO_SERVICO**: Itens e serviços utilizados nas consultas ou vendidos.
6.  **PRONTUARIO**: Histórico médico completo do animal.

### Tipos de Atributos Utilizados

| Tipo de Atributo | Entidade | Atributo | Exemplo de Implementação |
| :--- | :--- | :--- | :--- |
| **Chave Primária** | Todas | `id_tutor`, `id_animal`, etc. | `SERIAL PRIMARY KEY` |
| **Simples** | TUTOR | `cpf`, `email` | `VARCHAR(14) UNIQUE NOT NULL` |
| **Composto** | TUTOR | `nome_completo` | Dividido em `primeiro_nome` e `sobrenome` |
| **Multivalorado** | TUTOR | `telefone` | Mapeado para a tabela `TUTOR_TELEFONE` |
| **Derivado** | ANIMAL | `idade` | Implementado com a função `calcular_idade(data_nascimento)` |

### Tipos de Relacionamentos Utilizados

| Tipo de Relacionamento | Entidades | Tabela de Mapeamento |
| :--- | :--- | :--- |
| **1:1 (Um para Um)** | ANIMAL e PRONTUARIO | A tabela `PRONTUARIO` possui uma FK única para `ANIMAL`. |
| **1:N (Um para Muitos)** | TUTOR e ANIMAL | A tabela `ANIMAL` possui uma FK para `TUTOR`. |
| **N:N (Muitos para Muitos)** | CONSULTA e PRODUTO_SERVICO | Mapeado para a tabela associativa `CONSULTA_PRODUTO_SERVICO`. |

---

## 2. Modelagem Conceitual

O Diagrama Entidade-Relacionamento (DER) representa a estrutura do banco de dados, identificando entidades, atributos e a cardinalidade dos relacionamentos.

diagramas\Der colorido .jpg



---

## 3. Modelagem Lógica

A Modelagem Lógica transforma o DER em um esquema relacional, definindo as tabelas e os tipos de dados.

| Tabela | Chave Primária (PK) | Chaves Estrangeiras (FK) | Atributos Notáveis |
| :--- | :--- | :--- | :--- |
| **TUTOR** | `id_tutor` | - | `cpf` (UNIQUE), `email` (UNIQUE) |
| **TUTOR_TELEFONE** | `id_tutor`, `telefone` | `id_tutor` (FK para TUTOR) | Mapeamento do atributo multivalorado. |
| **VETERINARIO** | `id_veterinario` | - | `crmv` (UNIQUE) |
| **ANIMAL** | `id_animal` | `id_tutor` (FK para TUTOR) | `data_nascimento` (Base para atributo derivado). |
| **PRONTUARIO** | `id_prontuario` | `id_animal` (FK única para ANIMAL) | Garante o relacionamento 1:1. |
| **CONSULTA** | `id_consulta` | `id_animal`, `id_veterinario` | `data_hora`, `diagnostico`, `tratamento`. |
| **PRODUTO_SERVICO** | `id_produto_servico` | - | `tipo` (CHECK: 'Produto' ou 'Serviço'), `preco`. |
| **CONSULTA_PRODUTO_SERVICO** | `id_consulta`, `id_produto_servico` | `id_consulta`, `id_produto_servico` | Mapeamento do relacionamento N:N. |

---

## 4. Modelagem Física

 O script completo de criação do esquema está em (valores de esquema.sql).


## 5. Dados

O banco de dados foi populado com dados fictícios O script de inserção está em (data.sql).

| Tabela | Número Aproximado de Registros |
| :--- | :--- |
| TUTOR | 500 |
| VETERINARIO | 15 |
| ANIMAL | 600 |
| CONSULTA | 1500 |
| CONSULTA_PRODUTO_SERVICO | 2500 |

---

## 6. CRUD

Os comandos SQL do CRUD estão no arquivo (crud.sql).

01
Prints cruds\print 1.png
02
Prints cruds\print 2.png
03
Prints cruds\print 3.png
04
Prints cruds\print 4.png
05
Prints cruds\print 5.png
06
Prints cruds\6.png
07
Prints cruds\7.png
08
Prints cruds\08.png
09
Prints cruds\9.png


## 7. Relatórios

 consultas `SELECT`, `WHERE`, `ORDER BY`, `JOIN` e funções de agregação, estão no arquivo (consultas.sql).

01
prints consulta\print consultas 01.png
02
prints consulta\print consultas 02.png
03
prints consulta\print consultas 03.png
04
prints consulta\print consultas 04.png
05
prints consulta\print consultas 05.png
06
prints consulta\print consultas 06.png
07
prints consulta\print consultas 07.png
08
prints consulta\print consultas 08.png



