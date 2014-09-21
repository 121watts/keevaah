# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
module ActiveRecord
  module Tasks
    class PostgreSQLDatabaseTasks
      def drop
        establish_master_connection
        connection.select_all "select pg_terminate_backend(pg_stat_activity.pid) from pg_stat_activity where datname='#{configuration['database']}' AND state='idle';"
        connection.drop_database configuration['database']
      end
    end
  end
end

Rails.application.initialize!
