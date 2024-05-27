variable "name" {
  type = list(string)
  default = [ "one", "two", "three" ]
}
resource "azurerm_resource_group" "gpa" {
  name = "gpa-${var.name[count.index]}"
  location = "central us"
  count = 3
}