# Atividade - Formulário de Cliente

Projeto desenvolvido para a atividade de cadastro de clientes.

## Funcionalidades

- Cadastro de cliente PF ou PJ
- CPF/CNPJ, telefone e e-mail
- Endereço completo
- Listagem dos clientes cadastrados
- Interface em Angular consumindo API Spring Boot

## Tecnologias

- Java
- Spring Boot 2.7.18
- Angular 20
- TypeScript
- HTML e CSS

## Como executar

### 1. Backend

Na pasta principal do projeto:

```powershell
.\mvnw.cmd spring-boot:run
```

API disponível em:

```text
http://localhost:8080
```

### 2. Frontend

Em outro terminal:

```powershell
cd frontend
npm install
npm start
```

Abra no navegador:

```text
http://localhost:4200
```

## Endpoints principais

```text
POST http://localhost:8080/clientes/salvar-cliente
GET  http://localhost:8080/clientes/listar-clientes
```

> Os dados ficam armazenados em memória durante a execução da aplicação.
