resource "aws_connect_instance" "unicorn" {
  identity_management_type = "CONNECT_MANAGED"
  inbound_calls_enabled    = true
  instance_alias           = "unicorn-contact-center"
  outbound_calls_enabled   = true
}

resource "aws_connect_hours_of_operation" "general" {
  instance_id = aws_connect_instance.unicorn.id
  name        = "General Hours"
  description = "Monday Only"
  time_zone   = "EST"

  config {
    day = "MONDAY"

    start_time {
      hours   = 9
      minutes = 0
    }
    end_time {
      hours   = 17
      minutes = 0
    }
  }
}

resource "aws_connect_queue" "sales" {
  instance_id           = aws_connect_instance.unicorn.id
  name                  = "Sales"
  description           = "Customers want buy our Unicorns"
  hours_of_operation_id = aws_connect_hours_of_operation.general.hours_of_operation_id
}

resource "aws_connect_queue" "techincal_support" {
  instance_id           = aws_connect_instance.unicorn.id
  name                  = "Techincal Support"
  description           = "Customers having issues with Unicorns"
  hours_of_operation_id = aws_connect_hours_of_operation.general.hours_of_operation_id
}

resource "aws_connect_queue" "customer_service" {
  instance_id           = aws_connect_instance.unicorn.id
  name                  = "Customer Service"
  description           = "Customers asking about Unicorns"
  hours_of_operation_id = aws_connect_hours_of_operation.general.hours_of_operation_id
}

resource "aws_connect_contact_flow" "general" {
  instance_id = aws_connect_instance.unicorn.id
  name        = "General"
  description = "General Flow routing customers to queues"
  filename     = "flows/general_contact_flow.json"
  content_hash = filebase64sha256("flows/general_contact_flow.json")
}