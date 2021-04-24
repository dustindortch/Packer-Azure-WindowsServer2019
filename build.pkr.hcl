source "azure-arm" "image" {
    tenant_id       = var.TENANT_ID
    subscription_id = var.SUBSCRIPTION_ID
    client_id       = var.CLIENT_ID
    client_secret   = var.client_secret

    managed_image_resource_group_name  = var.RESOURCE_GROUP_NAME
    managed_image_name                 = "${var.PREFIX}WindowsServer2019_${formatdate("YYYY-MM-DD_hh-mm-ss",timestamp())}"
    managed_image_storage_account_type = "Premium_LRS"

    os_type = var.IMAGE["type"]

    image_publisher = var.IMAGE["publisher"]
    image_offer     = var.IMAGE["offer"]
    image_sku       = var.IMAGE["sku"]

    communicator   = var.IMAGE["communicator"]
    winrm_use_ssl  = true
    winrm_insecure = true
    winrm_timeout  = "5m"
    winrm_username = "packer"

    location = var.LOCATION
    vm_size  = var.VM_SIZE
}

build {
    sources = ["sources.azure-arm.image"]

    provisioner "powershell" {
        scripts = [
            "./scripts/wait.ps1",
            "./scripts/chocolatey.ps1",
            "./scripts/build.ps1",
        ]
    }

    provisioner "powershell" {
        script = "./scripts/sysprep.ps1"
    }
}