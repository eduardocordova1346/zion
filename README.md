## Pré-requisitos

Antes de começar, certifique-se de ter instalado:

- [Docker](https://www.docker.com/get-started) e Docker Compose
- Git

## Instalação Automática

Use o script de setup:

```bash
git clone https://github.com/eduardocordova1346/zion.git
cd zion
chmod +x setup.sh
./setup.sh
```

## Executando Comandos

Como o projeto roda dentro de containers Docker, todos os comandos PHP, Artisan, Composer e outros relacionados ao Laravel devem ser executados dentro do container.

### Formato Básico

Sempre use o prefixo `docker-compose exec app` antes dos comandos:

```bash
docker-compose exec app <comando>
```

### Comandos Artisan

```bash

# Criar model
docker-compose exec app php artisan make:model NomeModel

# Criar migration
docker-compose exec app php artisan make:migration nome_da_migration

# Executar migrations
docker-compose exec app php artisan migrate
```

### Entrar no Container

Se preferir trabalhar dentro do container:

```bash
# Acessar o container interativamente
docker-compose exec app bash
```

## Fluxo de Git

Este projeto utiliza um fluxo de trabalho Git para organizar o desenvolvimento e facilitar code reviews.

### Convenções de Branch

- `master`: Branch principal, código em produção
- `dev`: Branch de desenvolvimento
- `feature/nome-da-feature`: Nova funcionalidade
- `bugfix/nome-do-bugfix`: Correção de bugs
- `hotfix/nome-do-hotfix`: Correções urgentes
- `refactor/nome-do-refactor`: Refatoração de código

### Criando uma Nova Branch

Antes de começar a trabalhar em uma nova funcionalidade ou correção:

1. **Atualize a branch principal**
   ```bash
   git checkout master
   git pull origin master
   ```

2. **Crie e mude para a nova branch**
   ```bash
   # Para uma nova funcionalidade
   git checkout -b feature/minha-nova-funcionalidade
   
   # Para correção de bug
   git checkout -b bugfix/corrigir-login
   
   # Para hotfix
   git checkout -b hotfix/corrigir-seguranca
   ```

### Fazendo Commits

1. **Faça commits descritivos**
   ```bash
   # Formato recomendado
   git commit -m "feat: adiciona autenticação de usuário"
   ```

2. **Evite commits grandes**
   - Faça commits pequenos e frequentes
   - Cada commit deve representar uma mudança lógica completa
   - Seja específico: um commit, uma responsabilidade

### Enviando para o Repositório Remoto

1. **Envie sua branch para o remoto**
   ```bash
   git push origin feature/minha-nova-funcionalidade
   ```
