# first create a backend bucket to store there a statefile
# gsutil mb -l eu -p your-gcp-project-name gs://your-bucket-name
# gsutil versioning set on gs://your-bucket-name

# Variables may not be used here

terraform {
 backend "gcs" {
   bucket  = "your-bucket-name"
   prefix  = "terraform/state"
 }
}
