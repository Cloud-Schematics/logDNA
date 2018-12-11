provider "ibm" {
  bluemix_api_key    = "${var.ibm_bluemix_api_key}"
  softlayer_api_key  = "${var.ibm_softlayer_api_key}"
  softlayer_username = "${var.ibm_softlayer_user_name}"
}

variable "ibm_softlayer_user_name" {}

variable "ibm_softlayer_api_key" {}

variable "ibm_bluemix_api_key" {}
