resource "aws_dynamodb_table" "Rides" {
  name           = "Rides"
  hash_key       = "RideId"
  read_capacity  = 5
  write_capacity = 5

  attribute {
    name = "RideId"
    type = "S"
  }
}