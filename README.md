# Gerenciamento de Mudanças, Configuração e Infraestrutura

**Recursos Complementares da Disciplina**

[![Licença](https://img.shields.io/badge/licen%C3%A7a-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![GitHub issues](https://img.shields.io/github/issues/wbispolima/devops-gerenciamento-mudanca-configuracao.svg)](https://github.com/wbispolima/devops-gerenciamento-mudanca-configuracao/issues)
[![GitHub forks](https://img.shields.io/github/forks/wbispolima/devops-gerenciamento-mudanca-configuracao.svg)](https://github.com/wbispolima/devops-gerenciamento-mudanca-configuracao/network)
[![GitHub stars](https://img.shields.io/github/stars/wbispolima/devops-gerenciamento-mudanca-configuracao.svg)](https://github.com/wbispolima/devops-gerenciamento-mudanca-configuracao/stargazers)

---

## 📚 Tabela de Conteúdos

*   [Sobre Este Repositório](#-sobre-este-repositório)
*   [Informações da Disciplina](#-informações-da-disciplina)
*   [Estrutura do Repositório](#-estrutura-do-repositório)
*   [Exemplos Práticos](#-exemplos-práticos)
    *   [Terraform](#terraform)
    *   [Ansible](#ansible)
*   [Como Usar Este Repositório](#-como-usar-este-repositório)
*   [Conteúdo do Curso](#-conteúdo-do-curso)
*   [Recursos Adicionais](#-recursos-adicionais)
*   [Licença](#-licença)
*   [Contato](#-contato)

---

## 📚 Sobre Este Repositório

Este repositório contém **recursos complementares** da disciplina **"Gerenciamento de Mudanças, Configuração e Infraestrutura"** da Especialização em Engenharia DevOps do Instituto Federal de Mato Grosso (IFMT).

### ⚠️ Importante

**Este repositório NÃO substitui o curso.** O conteúdo acadêmico completo (videoaulas, materiais teóricos, fóruns, questões e atividades avaliativas) está disponível no **ambiente virtual de aprendizagem do IFMT Online**.

**Este repositório fornece:**

*   Site estático de exemplo (publicado e acessível online)
*   Exemplos práticos de código (Terraform, Ansible)
*   Código-fonte de projetos utilizados nas aulas
*   Recursos para exploração prática além do curso

---

## 📋 Informações da Disciplina

| Informação | Detalhes |
| --- | --- |
| **Instituição** | Instituto Federal de Mato Grosso (IFMT) |
| **Centro** | Centro de Referência em Educação a Distância (CREAD) |
| **Curso** | Especialização em Engenharia DevOps |
| **Disciplina** | Gerenciamento de Mudanças, Configuração e Infraestrutura |
| **Professor** | Waldinei Bispo de Lima |
| **Período** | 16 de fevereiro a 17 de abril de 2026 |
| **Carga Horária** | 60 horas (30h teórica + 30h prática) |
| **Modalidade** | Educação a Distância (EAD) |

---
## 📂 Estrutura do Repositório

```
devops-gerenciamento-mudanca-configuracao/
├── ansible/                 # Exemplos de Gerenciamento de Configuração com Ansible
│   ├── ec2-redmine/
│   └── ec2-static-site/
├── site/                    # Código-fonte do site estático de exemplo
│   ├── css/
│   ├── images/
│   ├── js/
│   └── index.html
├── terraform/               # Exemplos de Infraestrutura como Código com Terraform
│   ├── ec2-redmine/
│   ├── ec2-static-site/
│   └── s3-static-site/
├── .gitignore               # Arquivo de exclusão do Git
├── LICENSE                  # Licença MIT
└── README.md                # Este arquivo
```

---

## 🚀 Exemplos Práticos

Navegue pelos exemplos práticos disponíveis para cada ferramenta.

### Terraform

| Exemplo | Descrição | Link |
| --- | --- | --- |
| **Site Estático no S3** | Provisiona um bucket S3 para hospedar um site estático na AWS. | [Acessar Código](./terraform/s3-static-site) |
| **EC2 com Site Estático** | Cria uma instância EC2 e provisiona um site estático simples. | [Acessar Código](./terraform/ec2-static-site) |
| **EC2 com Redmine** | Provisiona uma instância EC2 e instala o Redmine. | [Acessar Código](./terraform/ec2-redmine) |

### Ansible

| Exemplo | Descrição | Link |
| --- | --- | --- |
| **Configurar Site Estático** | Configura um servidor web para hospedar o site estático. | [Acessar Código](./ansible/ec2-static-site) |
| **Instalar Redmine** | Instala e configura o Redmine em um servidor. | [Acessar Código](./ansible/ec2-redmine) |