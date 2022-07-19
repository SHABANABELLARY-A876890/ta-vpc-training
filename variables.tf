variable "vpc_name" {
    description = "This is the vpc name"
    type = string
}

variable "vpc_cidr" {
    description = "This is the cidr of the vpc"
  
}
variable "cidr_public" {
    description = "This is the cidr of the public subnet"
  
}
variable "cidr_private" {
    description = "This is the cidr of the private subnet"
  
}
variable "cidr_data" {
    description = "This is the cidr of the cidr-data"
  
}