# EC2 Static Site - Ansible Playbook

## Visão Geral

Este projeto Ansible automatiza a configuração de um servidor web estático em uma instância EC2 da AWS, utilizando **Nginx** como servidor web. O projeto demonstra o uso de **Role-Based Architecture**, um dos padrões recomendados pelo Ansible para organização de playbooks.

### Propósito Pedagógico

Este projeto é parte da disciplina **"Gerenciamento de Mudanças, Configuração e Infraestrutura"** da Especialização em Engenharia DevOps do IFMT. Demonstra:

- Uso de **Roles** para organização modular de tarefas
- Configuração de servidor web com Nginx
- Gerenciamento de domínios e virtual hosts
- Boas práticas de Infrastructure as Code (IaC)
- Diferenças entre padrões de arquitetura Ansible (Role-Based vs Task-Based)

---

## Estrutura do Projeto

```
ec2-static-site/
├── roles/
│   ├── nginx-site/                 # Role para configuração HTTP
│   │   ├── handlers/
│   │   │   └── main.yml           # Handlers (restart nginx)
│   │   ├── tasks/
│   │   │   └── main.yml           # Tarefas de instalação e configuração
│   │   └── templates/
│   │       └── nginx.conf.j2      # Template de configuração Nginx
│   │
│   └── nginx-site-https/           # Role para adicionar HTTPS
│       ├── handlers/
│       │   └── main.yml           # Handlers
│       ├── tasks/
│       │   └── main.yml           # Tarefas de HTTPS (Certbot)
│       └── templates/
│           └── nginx-https.conf.j2 # Template com HTTPS
│
├── site-nginx.yml                  # Playbook principal (HTTP)
├── site-nginx-https.yml            # Playbook para HTTPS
├── hosts                           # Inventário Ansible
└── README.md                       # Este arquivo
```

---

## Padrão de Arquitetura: Role-Based

Este projeto utiliza o **Role-Based Architecture**, o padrão recomendado pelo Ansible para projetos modulares e reutilizáveis.

### Por que Roles?

- **Modularidade**: Cada role é independente e reutilizável
- **Escalabilidade**: Fácil adicionar novas roles (nginx-site-https, etc.)
- **Manutenção**: Código organizado e fácil de manter
- **Reutilização**: Roles podem ser usadas em múltiplos playbooks

### Comparação com Task-Based

O projeto **ec2-redmine** utiliza **Task-Based Architecture** (arquivos 01-update.yml, 02-allbasic.yml, etc.), que é:

- **Mais simples**: Sequência linear de tarefas
- **Mais didático**: Fácil ver o fluxo passo a passo
- **Menos modular**: Difícil reutilizar entre projetos

**Ambos são padrões válidos**, escolha depende da complexidade do projeto.

---

## Requisitos

### Pré-requisitos

1. **Terraform** configurado com AWS
2. **Ansible** instalado localmente
3. **Chave SSH** configurada (ifmt-devops-iac.pem)
4. **Domínio** registrado e DNS configurado

### Variáveis Necessárias

| Variável | Descrição | Padrão |
|----------|-----------|--------|
| `domain_name` | Domínio do site | `SEU_DOMINIO` |
| `web_root` | Diretório raiz | `/var/www/SEU_DOMINIO/html` |
| `nginx_user` | Usuário Nginx | `www-data` |
| `nginx_group` | Grupo Nginx | `www-data` |

---

## Como Usar

### 1. Preparar o Ambiente

```bash
# Clonar/baixar o projeto
cd ec2-static-site

# Editar o arquivo hosts com o IP da instância
nano hosts
# Mude: site_nginx ansible_host=SEU_IP_AQUI
```

### 2. Executar o Playbook (HTTP)

```bash
# Executar com domínio padrão
ansible-playbook -i hosts site-nginx.yml

# Ou com domínio customizado
ansible-playbook -i hosts site-nginx.yml -e "domain_name=SEU_DOMINIO"
```

### 3. Validar a Instalação

O playbook executa testes automáticos ao final:

```
✓ Site respondendo via IP: SEU_IP
✓ Site respondendo via domínio: SEU_DOMINIO
```

### 4. Adicionar HTTPS (Let's Encrypt)

```bash
# Editar variáveis
nano site-nginx-https.yml
# Mude: admin_email: SEU_EMAIL

# Executar playbook HTTPS
ansible-playbook -i hosts site-nginx-https.yml
```

---

## Estrutura de Roles

### Role: nginx-site

**Responsabilidade**: Instalar e configurar Nginx para servir site estático HTTP

**Tarefas**:
1. Atualizar lista de pacotes
2. Instalar Nginx
3. Criar diretórios (web_root, logs)
4. Copiar arquivos do site
5. Ajustar permissões
6. Criar configuração virtual host
7. Validar configuração
8. Reiniciar Nginx

**Handlers**:
- `restart nginx`: Reinicia o serviço Nginx

**Templates**:
- `nginx.conf.j2`: Configuração do virtual host

### Role: nginx-site-https

**Responsabilidade**: Adicionar HTTPS com Let's Encrypt

**Tarefas**:
1. Instalar Certbot
2. Gerar certificado Let's Encrypt
3. Criar configuração HTTPS
4. Configurar renovação automática

**Templates**:
- `nginx-https.conf.j2`: Configuração com HTTPS + redirecionamento

---

## Variáveis e Customização

### Editar Domínio

**Opção 1: Arquivo site-nginx.yml**
```yaml
vars:
  domain_name: SEU_DOMINIO
  web_root: /var/www/SEU_DOMINIO/html
```

**Opção 2: Linha de Comando**
```bash
ansible-playbook -i hosts site-nginx.yml -e "domain_name=SEU_DOMINIO"
```

### Editar Diretório de Arquivos

Os arquivos do site são copiados de `./site-files/` para `{{ web_root }}`.

Estrutura esperada:
```
site-files/
├── index.html
├── css/
│   └── style.css
├── js/
│   └── script.js
└── images/
    └── logo.png
```

---

## Troubleshooting

### Site não responde via domínio

**Causa**: DNS ainda não propagou

**Solução**: Aguarde 24-48 horas ou verifique DNS:
```bash
nslookup SEU_DOMINIO
```

### Erro de permissão ao copiar arquivos

**Causa**: Diretório não tem permissões corretas

**Solução**: Conecte no servidor e verifique:
```bash
sudo ls -la /var/www/SEU_DOMINIO/
sudo chown -R www-data:www-data /var/www/SEU_DOMINIO/
```

### Nginx não inicia

**Solução**: Verifique configuração:
```bash
sudo nginx -t
sudo systemctl status nginx
sudo journalctl -u nginx -n 50
```

---

## Próximas Etapas

1. **Adicionar HTTPS**: Execute `site-nginx-https.yml`
2. **Adicionar Redmine**: Use projeto `ec2-redmine`
3. **Adicionar Grafana**: Criar nova role `nginx-grafana`
4. **Monitoramento**: Integrar com Prometheus

---

## Referências

- [Ansible Roles Documentation](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_reuse_roles.html)
- [Nginx Documentation](https://nginx.org/en/docs/)
- [Let's Encrypt](https://letsencrypt.org/)
- [AWS EC2 Documentation](https://docs.aws.amazon.com/ec2/)

---

## Autor

Professor Waldinei Bispo de Lima  
IFMT - Centro de Referência em Educação a Distância (CREAD)  
Especialização em Engenharia DevOps

---

## Licença

Material didático institucional - IFMT
