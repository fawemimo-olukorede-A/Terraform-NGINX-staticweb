resource "azurerm_linux_virtual_machine" "vm" {
  for_each = { for x in var.config.linux_vm : x.name => x }
  
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = coalesce(each.value.location, "UK South")
  size                = coalesce(each.value.size, "Standard_DS1_v2")
  admin_username      = coalesce(each.value.admin_username, "adminuser")
  admin_password      = each.value.admin_password
  network_interface_ids = each.value.network_interface_ids
  disable_password_authentication = each.value.disable_password_authentication 

  os_disk {
    caching              = coalesce(each.value.os_disk.caching, "ReadWrite")
    storage_account_type = coalesce(each.value.os_disk.storage_account_type, "Premium_LRS")
  }

  source_image_reference {
    publisher = coalesce(each.value.source_image_reference.publisher, "Canonical")
    offer     = coalesce(each.value.source_image_reference.offer, "0001-com-ubuntu-server-jammy")
    sku       = coalesce(each.value.source_image_reference.sku, "22_04-lts-gen2")
    version   = coalesce(each.value.source_image_reference.version, "latest")
  }

 custom_data = base64encode(<<EOF
#!/bin/bash -xe

# Set non-interactive mode to avoid prompts
export DEBIAN_FRONTEND=noninteractive

# Wait for apt lock to be released
while sudo fuser /var/lib/dpkg/lock-frontend >/dev/null 2>&1; do sleep 1; done

# Update package list and install Nginx
sudo apt update && sudo apt install nginx -y

# Ensure Nginx service starts on boot and is running
systemctl enable nginx
systemctl restart nginx || systemctl start nginx

# Create an HTML file for the web page
cat <<EOT > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
  <title>HNG DevOps Task</title>
  <style>
    body { font-family: Arial, sans-serif; text-align: center; background-color: #f4f4f4; }
    h1 { font-weight: bold; }
    form { background: #fff; padding: 20px; max-width: 300px; margin: auto; box-shadow: 0px 0px 10px 0px rgba(0,0,0,0.1); border-radius: 10px; }
    input { width: 100%; padding: 10px; margin: 5px 0; border: 1px solid #ccc; border-radius: 5px; }
    button { background: #007BFF; color: white; padding: 10px; border: none; border-radius: 5px; cursor: pointer; }
    button:hover { background: #0056b3; }
  </style>
</head>
<body>

<h1>Welcome to DevOps Stage 0</h1>

  <h1>HNG DEVOPS TASK 0</h1>
  <form>
    <label>Name:</label>
    <input type="text" name="name" required><br>
    <label>Email:</label>
    <input type="email" name="email" required><br>
    <label>Phone No:</label>
    <input type="tel" name="phone" required><br>
    <button type="submit">Submit</button>
  </form>
</body>
</html>
EOT

# Restart Nginx to apply changes
systemctl restart nginx || systemctl start nginx

# Ensure firewall allows HTTP traffic
ufw allow 80/tcp || true
iptables -I INPUT -p tcp --dport 80 -j ACCEPT || true
EOF
)



  tags = each.value.tags
  
} 

