variable "cidr_vpc" {
  description = "CIDR block for the VPC"
  default     = "10.1.0.0/16"
}
variable "cidr_subnet" {
  description = "CIDR block for the subnet"
  default     = "10.1.0.0/24"
}

variable "environment_tag" {
  description = "Environment tag"
  default     = "Learn"
}

variable "prefix" {
  description = "used to associate resources with a person"
  default = "dpeacock"
}

variable "region"{
  description = "The region Terraform deploys your instance"
  default = "us-east-1"
}

variable "aws_region" {
  description = "Region for AWS secrets engine"
  default = "us-east-1"
}

variable "owner" {
  default = "dpeacock"
  description = "person from HC that deployed the resource"
}

variable "hashi-region" {
  default = "nymetro"
  description = "HC region that the owner belongs to"
}

variable "purpose" {
  default = "testing"
  description = "what the resource is for"
} 

variable "ttl" {
  default = "12"
  description = "time to live before reaper should delete"
}

variable "Department" {
  description = "the department the resource is for"
  default = "Engineering"
    }

variable "Billable" {
  description = "to bill or not to bill"
  default = true
  }

