variable "region"{
}
variable "access_key"{
}
variable "secret_key"{
}

provider "aws" {
    version = "2.70.0"
    region = var.region
    access_key = var.access_key
    secret_key = var.secret_key
}