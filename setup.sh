#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_header() {
    echo -e "\n${BLUE}========================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}========================================${NC}\n"
}

# Verificar se Docker está instalado
check_docker() {
    print_info "Verificando se Docker está instalado..."
    if ! command -v docker &> /dev/null; then
        print_error "Docker não está instalado. Por favor, instale o Docker primeiro."
        exit 1
    fi
    print_success "Docker encontrado"

    print_info "Verificando se Docker Compose está instalado..."
    if ! command -v docker-compose &> /dev/null && ! docker compose version &> /dev/null; then
        print_error "Docker Compose não está instalado. Por favor, instale o Docker Compose primeiro."
        exit 1
    fi
    print_success "Docker Compose encontrado"

    print_info "Verificando se o Docker está rodando..."
    if ! docker info &> /dev/null; then
        print_error "Docker não está rodando. Por favor, inicie o Docker primeiro."
        exit 1
    fi
    print_success "Docker está rodando"
}

# Criar arquivo .env se não existir
setup_env() {
    print_header "Configurando arquivo .env"

    if [ -f .env.example ]; then
        print_info "Copiando .env.example para .env..."
        cp .env.example .env
        print_success "Arquivo .env criado a partir do .env.example"
    fi
    
    print_warning "Revise o arquivo .env e ajuste conforme necessário antes de continuar"
}

# Iniciar containers Docker
start_containers() {
    print_header "Iniciando containers Docker"
    
    print_info "Construindo e iniciando containers..."
    docker-compose up -d --build
    
    if [ $? -eq 0 ]; then
        print_success "Containers iniciados com sucesso"
        
        print_info "Aguardando containers ficarem prontos..."
        sleep 5
 
        if docker-compose ps | grep -q "Up"; then
            print_success "Todos os containers estão rodando"
        else
            print_warning "Alguns containers podem não estar rodando. Verifique com 'docker-compose ps'"
        fi
    else
        print_error "Erro ao iniciar containers"
        exit 1
    fi
}

# Instalar dependências do Composer
install_composer_deps() {
    print_header "Instalando dependências do Composer"
    
    print_info "Instalando dependências PHP..."
    docker-compose exec -T app composer install --no-interaction --prefer-dist --optimize-autoloader
    
    if [ $? -eq 0 ]; then
        print_success "Dependências do Composer instaladas"
    else
        print_error "Erro ao instalar dependências do Composer"
        exit 1
    fi
}

generate_app_key() {   
    print_info "Gerando chave da aplicação..."
    docker-compose exec -T app php artisan key:generate --force
    
    if [ $? -eq 0 ]; then
        print_success "Chave da aplicação gerada"
    else
        print_error "Erro ao gerar chave da aplicação"
        exit 1
    fi
}

# Executar migrations
run_migrations() {
    print_header "Executando migrations"
    
    print_info "Aguardando banco de dados ficar pronto..."
    sleep 3
 
    print_info "Testando conexão com banco de dados..."
    for i in {1..30}; do
        if docker-compose exec -T db mysqladmin ping -h localhost --silent 2>/dev/null; then
            print_success "Banco de dados está pronto"
            break
        fi
        if [ $i -eq 30 ]; then
            print_error "Timeout aguardando banco de dados"
            exit 1
        fi
        sleep 1
    done
    
    print_info "Executando migrations..."
    docker-compose exec -T app php artisan migrate --force
    
    if [ $? -eq 0 ]; then
        print_success "Migrations executadas com sucesso"
    else
        print_warning "Erro ao executar migrations (isso é normal se o banco ainda não existe)"
    fi
}

# Definir permissões
set_permissions() {
    print_header "Configurando permissões"
    
    print_info "Ajustando permissões do storage e cache..."
    docker-compose exec -T app chmod -R 775 storage bootstrap/cache || true
    docker-compose exec -T app chown -R developer:www-data storage bootstrap/cache || true
    
    print_success "Permissões configuradas"
}

# Mostrar informações finais
show_final_info() {
    print_header "Configuração Concluída!"
    
    echo -e "${GREEN}Seu ambiente está pronto para uso!${NC}\n"
    
    echo -e "${BLUE}Informações de acesso:${NC}"
    echo -e "  • Aplicação:     ${GREEN}http://localhost:8080${NC}"
    echo -e "  • phpMyAdmin:    ${GREEN}http://localhost:8081${NC}"
    echo ""
    
    echo -e "${BLUE}Credenciais do banco de dados:${NC}"
    DB_USER=$(grep "^DB_USERNAME=" .env | cut -d '=' -f2 | tr -d '"' 2>/dev/null || echo "laravel")
    DB_PASS=$(grep "^DB_PASSWORD=" .env | cut -d '=' -f2 | tr -d '"' 2>/dev/null || echo "laravel")
    DB_NAME=$(grep "^DB_DATABASE=" .env | cut -d '=' -f2 | tr -d '"' 2>/dev/null || echo "laravel")
    echo -e "  • Host:          ${GREEN}localhost${NC} (ou ${GREEN}db${NC} de dentro dos containers)"
    echo -e "  • Porta:         ${GREEN}3306${NC}"
    echo -e "  • Database:      ${GREEN}${DB_NAME}${NC}"
    echo -e "  • Username:      ${GREEN}${DB_USER}${NC}"
    echo -e "  • Password:      ${GREEN}${DB_PASS}${NC}"
    echo ""
    
    echo -e "${BLUE}Comandos úteis:${NC}"
    echo -e "  • Ver logs:           ${YELLOW}docker-compose logs -f${NC}"
    echo -e "  • Parar containers:   ${YELLOW}docker-compose down${NC}"
    echo -e "  • Entrar no container: ${YELLOW}docker-compose exec app bash${NC}"
    echo -e "  • Executar artisan:   ${YELLOW}docker-compose exec app php artisan [comando]${NC}"
    echo ""
    
    echo -e "${YELLOW}⚠${NC} Lembre-se de revisar o arquivo .env e ajustar as configurações conforme necessário!\n"
}

main() {
    print_header "Setup do Projeto Zion"
    
    check_docker
    
    setup_env
    
    echo ""
    read -p "Deseja continuar com a instalação? (s/N): " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Ss]$ ]]; then
        print_warning "Instalação cancelada pelo usuário"
        exit 0
    fi
    
    start_containers
    install_composer_deps
    generate_app_key
    run_migrations
    set_permissions
    show_final_info
}

main

