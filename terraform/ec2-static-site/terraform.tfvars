# ============================================================================
# TERRAFORM.TFVARS - Valores das Variáveis
# ============================================================================
# Este arquivo contém os valores específicos para as variáveis declaradas
# em variables.tf. Aqui você customiza o comportamento do Terraform sem
# alterar o código-fonte principal.
#
# IMPORTANTE: Este arquivo pode conter informações sensíveis. Em produção,
# considere usar variáveis de ambiente ou ferramentas como Terraform Cloud.
#
# Documentação: https://www.terraform.io/language/values/variables
# ============================================================================

# Configuração AWS
aws_region = "sa-east-1"

# Identificação do Projeto
projeto       = "especializa-devops"
gerenciamento = "terraform-iac"
ambiente      = "desenvolvimento"
recurso       = "site-nginx"

# Configuração da Instância EC2
instance_type = "t3.micro"
ami_ubuntu    = "ami-0a14809f48c07e3b7"
key_name      = "ColoqueAquiSuakeypair"

# Configuração de Rede
enable_public_ip = true
ssh_port         = 22
http_port        = 80
https_port       = 443

# Tags Adicionais
tags_adicionais = {
  Recurso = "site-nginx",
  Gerenciamento = "terraform-iac"
}
