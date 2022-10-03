# azure-database-example

This project aims to study some concepts of Database provisioning on Azure using Terraform.

> **This project is in work in progress and will be updated without notice.**

## First steps

### 0. Configure Azure CLI on your local environment

See official documentation: [Get started with Azure CLI](https://docs.microsoft.com/en-us/cli/azure/get-started-with-azure-cli)

### 1. Create `demo.tfvars` files

```bash
mkdir envs && touch envs/demo.tfvars
```

After that, edit the content of `demo.tfvars` with:

```tfvars
azure_location   = "East US"
ssh_pub_key_path = "~/.ssh/id_rsa.pub"
```

## Running Terraform commands

### 1. Init

```bash
terraform init
```

### 2. Plan

```bash
terraform plan -var-file=envs/demo.tfvars
```

### 3. Apply

```bash
terraform apply -var-file=envs/demo.tfvars

# or
terrafor apply -auto-approve -var-file=envs/demo.tfvars

```

## Access Database via Bastion Host
  1. Go to the created linux virtual machine;
  2. On left sidebar, select *Operation -> Bastion*:
      - Set the username `azureuser`
      - Set `SSH Private Key from Local File`
      - Upload the SSH private key pair on your local machine

  3. Click to `Connect`

### Configure to connect to PostgreSQL Database
  1. Install `postgresql` package: `sudo apt install postgresql`
  2. Connect to the database: 
  ```bash
  PGPASSWORD=Admin12345 psql -h <hostname>.postgres.database.azure.com -p 5432 -U pgdemo -d postgres
  ```

### Create a new database
```sql
create database db01;
```

Quit to `psql` and connect to the new database:
```bash
PGPASSWORD=Admin12345 psql -h <hostname>.postgres.database.azure.com -p 5432 -U pgdemo -d db01
```

### Create a new schema
```sql
create schema if not exists app01;
```

### Create a new table
```sql
create table app01.people(
  id serial primary key,
  name varchar(200) not null,
  email varchar(100) not null unique
);
```

## Terraform Reference

- https://registry.terraform.io/providers/hashicorp/azurerm/3.25.0
