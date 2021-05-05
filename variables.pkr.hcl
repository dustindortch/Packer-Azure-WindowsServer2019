variable "SUBSCRIPTION_ID" {
    type = string
}

variable "CLIENT_ID" {
    type = string
}

variable "client_secret" {
    type      = string
    sensitive = true
}

variable "TENANT_ID" {
    type = string
}

variable "RESOURCE_GROUP_NAME" {
    type = string
}

variable "LOCATION" {
    type    = string
    default = "East US"
    validation {
        condition = contains(
            split("\r\n",file("./azure_regions.txt")),
            var.LOCATION
        )
        error_message = "Unapproved Azure region specified."
    }
}

variable "PREFIX" {
    type    = string
    default = "GoldenImage_"
}

variable "CHOCO_REPO_NAME" {
    type = "string"
}

variable "CHOCO_REPO_URL" {
    type = "string"
}

variable "CHOCO_REPO_USERNAME" {
    type = string
}

variable "choco_repo_token" {
    type      = string
    sensitive = true
}

variable "IMAGE" {
    type = object({
        communicator = string
        publisher    = string
        offer        = string
        sku          = string
        type         = string
    })
    default = {
        communicator = "winrm"
        publisher    = "MicrosoftWindowsServer"
        offer        = "WindowsServer"
        sku          = "2019-Datacenter"
        type         = "Windows"
    }
}
variable "VM_SIZE" {
    type = string
    default = "Standard_DS2_v2"
}