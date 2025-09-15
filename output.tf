output "mcitoutput"{
    value=var.mcitvariable
}

output "mcityear"{
    value=var.batchyear
}
output "milleniumoutput"{
    value=var.millenium
}
output "booleanoutput"{
    value=var.truefalse
}
output "listoffruitsoutput"{
    value=var.listoffruits
}

output "csv" {
  value = join(",", ["one", "two", "three"])
}
# → "one,two,three"

output "list" {
  value = split("-", "app-prod-01")
}
# → ["app", "prod", "01"]
output "clean_name" {
  value = replace("app-prod-01", "prod", "staging")
}
# → "app-staging-01"

