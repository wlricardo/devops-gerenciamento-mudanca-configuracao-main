# ==============================================================================
# ARQUIVO PRINCIPAL DE CONFIGURAÇÃO DO TERRAFORM
# Disciplina: Gerenciamento de Mudanças, Configuração e Infraestrutura
# Unidade 2: Infrastructure as Code com Terraform
# ==============================================================================

# ------------------------------------------------------------------------------
# Bloco 1: Configuração do Provedor (Provider)
# ------------------------------------------------------------------------------
# Este bloco informa ao Terraform que estamos interagindo com a AWS. A região é
# parametrizada através de uma variável para tornar o código mais flexível.
# O Terraform buscará as credenciais automaticamente do ambiente (AWS CLI, etc.).
# ------------------------------------------------------------------------------
provider "aws" {
  region = var.aws_region
}

# ------------------------------------------------------------------------------
# Bloco 2: Recurso para o Bucket S3
# ------------------------------------------------------------------------------
# Este recurso define o bucket S3 que armazenará os arquivos do nosso site.
# O nome do bucket é uma variável para garantir que seja único. As tags são
# metadados importantes para organização, rastreamento de custos e identificação.
# ------------------------------------------------------------------------------
resource "aws_s3_bucket" "site_bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = "Bucket para o site estático da Unidade 2"
    Project     = "Especializacao DevOps IFMT"
    ManagedBy   = "Terraform"
    Professor   = "Waldinei Bispo de Lima"
  }
}

# ------------------------------------------------------------------------------
# Bloco 3: Configuração do Bloqueio de Acesso Público
# ------------------------------------------------------------------------------
# Por padrão, a AWS bloqueia todo o acesso público aos buckets S3. Para que o
# nosso site seja acessível publicamente, precisamos desabilitar esses bloqueios
# de forma explícita. O controle de acesso será feito pela política do bucket.
# ------------------------------------------------------------------------------
resource "aws_s3_bucket_public_access_block" "site_bucket_pab" {
  bucket = aws_s3_bucket.site_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# ------------------------------------------------------------------------------
# Bloco 4: Habilitação da Hospedagem de Site Estático
# ------------------------------------------------------------------------------
# Este recurso instrui o S3 a tratar o bucket como um servidor web. Definimos
# o 'index.html' como o documento principal a ser servido quando um usuário
# acessa a raiz do site.
# A cláusula 'depends_on' garante que esta configuração só seja aplicada após
# a configuração de acesso público ter sido ajustada.
# ------------------------------------------------------------------------------
resource "aws_s3_bucket_website_configuration" "site_website_config" {
  bucket = aws_s3_bucket.site_bucket.id

  index_document {
    suffix = "index.html"
  }

  # Opcional: você pode adicionar um documento de erro personalizado
  # error_document {
  #   key = "error.html"
  # }

  depends_on = [aws_s3_bucket_public_access_block.site_bucket_pab]
}

# ------------------------------------------------------------------------------
# Bloco 5: Política de Acesso do Bucket (Bucket Policy)
# ------------------------------------------------------------------------------
# Esta é a política que efetivamente torna os objetos do bucket legíveis
# publicamente. Ela concede a permissão 's3:GetObject' para qualquer pessoa ('*')
# em todos os objetos ('/*') dentro deste bucket.
# A função 'jsonencode' converte a estrutura HCL em um documento JSON válido.
# ------------------------------------------------------------------------------
resource "aws_s3_bucket_policy" "site_bucket_policy" {
  bucket = aws_s3_bucket.site_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetObject",
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "${aws_s3_bucket.site_bucket.arn}/*"
      }
    ]
  })

  depends_on = [aws_s3_bucket_public_access_block.site_bucket_pab]
}

# ------------------------------------------------------------------------------
# Bloco 6: Upload dos Arquivos do Site
# ------------------------------------------------------------------------------
# Este bloco é responsável por carregar os arquivos do diretório local para o
# bucket S3. Ele itera sobre cada arquivo encontrado no caminho especificado
# pela variável 'website_source_path'.
# - 'fileset': Função que retorna uma lista de todos os arquivos no caminho.
# - 'for_each': Cria uma instância deste recurso para cada arquivo na lista.
# - 'etag': Garante que o arquivo só seja carregado novamente se o seu conteúdo mudar.
# - 'content_type': Define o tipo MIME correto para cada arquivo (HTML, CSS, etc.).
# ------------------------------------------------------------------------------
resource "aws_s3_object" "site_files" {
  for_each = fileset(var.website_source_path, "**/*")

  bucket       = aws_s3_bucket.site_bucket.id
  key          = each.value
  source       = "${var.website_source_path}/${each.value}"
  content_type = lookup(
    {
      "html" = "text/html",
      "css"  = "text/css",
      "js"   = "application/javascript",
      "png"  = "image/png",
      "jpg"  = "image/jpeg"
    },
    regex("[^.]+$", each.value),
    "application/octet-stream" # Tipo padrão caso a extensão não seja encontrada
  )

  etag = filemd5("${var.website_source_path}/${each.value}")

  depends_on = [aws_s3_bucket_policy.site_bucket_policy]
}

# ------------------------------------------------------------------------------
# Bloco 7: Saídas (Outputs)
# ------------------------------------------------------------------------------
# Outputs são uma forma de expor informações importantes sobre a infraestrutura
# criada. Após a execução, o Terraform exibirá esses valores no console.
# ------------------------------------------------------------------------------
output "website_url" {
  description = "URL pública do site estático hospedado no S3."
  value       = "http://${aws_s3_bucket_website_configuration.site_website_config.website_endpoint}"
}

output "bucket_name" {
  description = "Nome do bucket S3 criado."
  value       = aws_s3_bucket.site_bucket.bucket
}

output "aws_region" {
  description = "Região da AWS onde os recursos foram criados."
  value       = var.aws_region
}
