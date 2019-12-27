require 'sidekiq/worker'
require 'sidekiq-metrics'
require 'mysql2'

module Sidekiq
  module Metrics
    module Adapter
      class Mysql < Base
        class Worker
          include Sidekiq::Worker

          def perform(worker_status)
            stat = client.prepare("INSERT INTO #{table_name} (queue, class, retry, jid, status, enqueued_at, started_at, finished_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?)")
            stat.execute(
              worker_status['queue'],
              worker_status['class'],
              worker_status['retry'],
              worker_status['jid'],
              worker_status['status'],
              worker_status['enqueued_at'],
              worker_status['started_at'],
              worker_status['finished_at']
            )
          end

          private

          def client
            @client ||= Mysql2::Client.new(Sidekiq::Metrics.configuration.adapter.database_configuration)
          end

          def table_name
            Sidekiq::Metrics.configuration.adapter.table_name
          end
        end

        attr_reader :database_configuration, :table_name

        def initialize(database_configuration,
                       table_name,
                       async: true,
                       sidekiq_worker_options: {
                         queue: :default,
                         retry: 5
                       })
          @database_configuration = database_configuration
          @table_name = table_name
          @async = async
          Worker.sidekiq_options(sidekiq_worker_options)

          Sidekiq::Metrics.configure do |config|
            config.excludes << Worker.name
          end
        end

        def write(worker_status)
          if @async
            Worker.perform_async(worker_status)
          else
            Worker.new.perform(worker_status)
          end
        end
      end
    end
  end
end
