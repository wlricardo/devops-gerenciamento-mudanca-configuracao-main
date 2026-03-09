# ==============================================================================
# ARQUIVO DE CONFIGURAÇÃO DE VERSÕES E DEPENDÊNCIAS
# Disciplina: Gerenciamento de Mudanças, Configuração e Infraestrutura
# Unidade 2: Infrastructure as Code com Terraform
# ==============================================================================

# Este arquivo declara as versões requeridas do Terraform e dos provedores
# que este projeto utiliza. Isso garante que o código seja executado com
# versões compatíveis e evita problemas de compatibilidade entre ambientes.

terraform {
    required_version = ">= 1.14.3"
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 6.28"
        }
    }
}
