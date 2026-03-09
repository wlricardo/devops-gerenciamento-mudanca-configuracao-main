# ==============================================================================
# ARQUIVO DE EXEMPLO PARA VALORES DE VARIÁVEIS
# Disciplina: Gerenciamento de Mudanças, Configuração e Infraestrutura
# Unidade 2: Infrastructure as Code com Terraform
# ==============================================================================

# Para utilizar este arquivo, siga os passos:
# 1. Renomeie-o para "terraform.tfvars" (remova a extensão .example).
# 2. Altere os valores abaixo para corresponder ao seu ambiente.
# 3. O arquivo terraform.tfvars não deve ser versionado em repositórios públicos.

# ------------------------------------------------------------------------------
# Exemplo de preenchimento:
# ------------------------------------------------------------------------------

# (Opcional) Região da AWS onde os recursos serão criados.
# O padrão é "us-east-1" se não for especificado.
# aws_region = "sa-east-1"

# Nome do bucket S3. Lembre-se que este nome deve ser GLOBALMENTE ÚNICO.
# Substitua pelo nome que você deseja usar.
bucket_name = "devops-ifmt-iac-site-estatico-2026-exemplo"

# Caminho para o diretório local que contém os arquivos do site (HTML, CSS, etc.).
# Conforme a estrutura de pastas, o caminho relativo a partir de 's3-static-site'
# para a pasta 'site' é '../../site'.
website_source_path = "../../site"
