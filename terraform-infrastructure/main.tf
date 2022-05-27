module "s3" {

  source = "./modules/s3"
}

module "iam" {
  
    source = "./modules/iam"
    
}
module "ec2" {
    source = "./modules/ec2"
    iam_instance_profile = module.iam.instance_profile_name
    key_name = module.key-pair.key
}


module "key-pair" {
  source = "./modules/key-pair"

}
