DB_HOST="peerages.postgres.database.azure.com"
DB_DATABASE="standing_orders"
DB_USERNAME="<username>"
DB_PASSWORD="<password>"

# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!