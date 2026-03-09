# ==============================================================================
# ARQUIVO DE DECLARAÇÃO DE VARIÁVEIS
# Disciplina: Gerenciamento de Mudanças, Configuração e Infraestrutura
# Unidade 2: Infrastructure as Code com Terraform
# ==============================================================================

# ------------------------------------------------------------------------------
# Variável 1: Região da AWS
# ------------------------------------------------------------------------------
# Define em qual data center da AWS os recursos serão criados. O valor padrão
# é 'us-east-1', mas pode ser sobrescrito. A validação garante que o formato
# do nome da região seja válido.
# ------------------------------------------------------------------------------
variable "aws_region" {
  description = "Região da AWS para a criação dos recursos."
  type        = string
  default     = "sa-east-1"

  validation {
    condition     = can(regex("^[a-z]{2}-[a-z]+-[0-9]$", var.aws_region))
    error_message = "O formato da região da AWS é inválido. Exemplo válido: us-east-1."
  }
}

# ------------------------------------------------------------------------------
# Variável 2: Nome do Bucket
# ------------------------------------------------------------------------------
# Define o nome do bucket S3. Este nome precisa ser globalmente único. As
# validações garantem que o nome siga as regras de nomenclatura da AWS.
# ------------------------------------------------------------------------------
variable "bucket_name" {
  description = "Nome do bucket S3. Deve ser globalmente único."
  type        = string

  validation {
    condition     = length(var.bucket_name) >= 3 && length(var.bucket_name) <= 63
    error_message = "O nome do bucket deve conter entre 3 e 63 caracteres."
  }

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9.-]*[a-z0-9]$", var.bucket_name))
    error_message = "O nome do bucket deve conter apenas letras minúsculas, números, pontos e hifens, e não pode começar ou terminar com ponto ou hífen."
  }
}

# ------------------------------------------------------------------------------
# Variável 3: Caminho para os Arquivos do Site
# ------------------------------------------------------------------------------
# Especifica o caminho local para o diretório que contém os arquivos do site
# (HTML, CSS, etc.). A validação verifica se um arquivo 'index.html' existe
# no caminho fornecido, garantindo que o site tenha uma página inicial.
# ------------------------------------------------------------------------------
variable "website_source_path" {
  description = "Caminho para o diretório local contendo os arquivos do site."
  type        = string

  validation {
    condition     = fileexists("${var.website_source_path}/index.html")
    error_message = "O diretório especificado não contém um arquivo 'index.html'."
  }
}
