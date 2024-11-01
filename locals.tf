locals {

  ##################
  #VM Instances
  ##################

  instance_count = "1"
  putin_khuylo             = true
  ami                      = null  # Use SSM parameter for AMI
  ami_ssm_parameter        = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
  instance_type            = "t2.micro"
  cpu_core_count           = 1
  cpu_threads_per_core     = 1
  hibernation              = false

  # Networking variables
  availability_zone        = "us-west-2a"  # Adjust as necessary
  subnet_id                = "subnet-12345678"  # Replace with your subnet ID
  vpc_security_group_ids   = ["sg-12345678"]  # Replace with your security group ID

  key_name                 = "my-keypair"  # Replace with your key pair name
  monitoring               = false
  associate_public_ip_address = true
  ebs_optimized            = true
  
  resource_eip_count = 1

  # IAM role and profile variables
  create_iam_instance_profile = true
  iam_role_name               = "my_instance_role"
  iam_role_use_name_prefix     = true
  iam_role_path                = "/my_roles/"

 
 ###########################################
 #volumes
 ###########################################


 volumes = {
    #volume1 = { size = 10, availability_zone = data.aws_availability_zones.available.names[0] }
    #volume1 = { size = 10, availability_zone = data.aws_availability_zones.available.names[0] }

    volume1 = { size = 10, availability_zone = null }  # Optional availability zone
    #volume2 = { size = 20, availability_zone = null }  # Optional availability zone
  }

  

#############################################
#Dynamo Dynamo DB 
#############################################

dynamo_db_config = {
    create_table                     = true
    table_count                      = 1
    name                             = "my-dynamodb-table"
    billing_mode                     = "PAY_PER_REQUEST"
    hash_key                         = "id"
    range_key                        = "sort_key"
    read_capacity                     = 5
    write_capacity                    = 5
    stream_enabled                   = true
    stream_view_type                 = "NEW_AND_OLD_IMAGES"
    table_class                      = "STANDARD"
    deletion_protection_enabled      = false
    ttl_enabled                      = true
    ttl_attribute_name               = "ttl"
    point_in_time_recovery_enabled   = true
    attributes                       = [{ name = "id", type = "S" }, { name = "sort_key", type = "S" }]
    local_secondary_indexes          = []
    global_secondary_indexes         = []
    replica_regions                  = []
    server_side_encryption_enabled    = true
    tags                             = { "Environment" = "Dev" }
    timeouts                         = { "create" = "10m", "delete" = "10m", "update" = "10m" }
  }

  #####################################
   # VPC configuration
  #####################################
 vpc_create = {
    create_vpc             = true
    vpc_count              = 1
    cidr_blocks            = ["10.0.0.0/16", "10.1.0.0/16", "10.2.0.0/16"]
    secondary_cidr_blocks  = ["10.0.1.0/24", "10.1.1.0/24", "10.2.1.0/24"]
    public_subnet_count    = 1
    private_subnet_count   = 1
    public_subnet_cidrs    = ["10.0.0.0/24", "10.0.1.0/24"]
    private_subnet_cidrs   = ["10.0.2.0/24", "10.0.3.0/24"]
    availability_zones     = ["us-east-1a", "us-east-1b", "us-east-1c"]
    name                   = "my-vpc"
    tags                   = { "Environment" = "Dev" }
  }
}
