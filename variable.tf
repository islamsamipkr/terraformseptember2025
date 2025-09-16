variable "subscription_id"{
  type=string
}
variable "client_id"{
  type=string
}
variable "client_secret"{
  type=string
}
variable "tenant_id"{
  type=string
}
variable "mcitvariable"{
  type =string
  default="mcitcollege"
}
variable "batchyear"{
  type =string
  default="2025"
}
variable "millenium"{
  type=number
  default=2000
}
variable "truefalse"{
  type= bool
  default=true
}
variable "listoffruits"{
  type=list(string)
  default=["apple","banana","kiwi"]
}
variable "environment" {
  default = "production"
}
variable "app_name" {
  type    = string
  default = "myapp"
}
variable "items" {
  type    = list(string)
  default = ["one", "two", "three"]
}
variable "server_name" {
  type    = string
  default = "app-prod-01"
}

variable "phrase" {
  default = "InceptionMovie"
}

