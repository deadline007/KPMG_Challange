terraform {
  backend "gcs" {
    bucket = "terra-sf"
    prefix = "env/dev"
  }
}