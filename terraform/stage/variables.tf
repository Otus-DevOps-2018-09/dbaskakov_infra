variable project {
  description = "infra-219219"
}

variable region {
  description = "Region"
  default     = "europe-west1"
}

variable zone {
  description = "zone"
  default     = "europe-west1-b"
}

variable public_key_path {
  description = "public key path"
}

variable private_key_path {
  description = "private key path"
}

variable disk_image {
  description = "reddit-base"
}

variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}

variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-db-base"
}
