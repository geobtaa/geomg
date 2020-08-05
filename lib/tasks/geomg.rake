# frozen_string_literal: true

task stats: :environment do
  Rake::Task['geomg:stats'].invoke
end

desc 'Run test suite'
task ci: :environment do
  shared_solr_opts = { managed: true, verbose: true, persist: false, download_dir: 'tmp' }
  shared_solr_opts[:version] = ENV['SOLR_VERSION'] if ENV['SOLR_VERSION']

  success = true
  SolrWrapper.wrap(shared_solr_opts.merge(port: 8985, instance_dir: 'tmp/geoportal-core-test')) do |solr|
    solr.with_collection(name: 'geoportal-core-test', dir: Rails.root.join('solr/conf').to_s) do
      system 'RAILS_ENV=test TESTOPTS="-v" bundle exec rails test:system test' || success = false
    end
  end

  exit!(1) unless success
end

namespace :geomg do
  task production_guard: :environment do
    if Rails.env.production? && ENV['PRODUCTION_OKAY'] != 'true'
      warn "\nNot safe for production. If you are sure, run with `PRODUCTION_OKAY=true #{ARGV.join}`\n\n"
      exit 1
    end
  end

  task stats: :environment do
    require 'rails/code_statistics'
    ::STATS_DIRECTORIES << ['Indexers', 'app/indexers']
    ::STATS_DIRECTORIES << ['Indexers Tests', 'test/indexers']
    CodeStatistics::TEST_TYPES << 'Indexers Tests'
  end

  desc 'Run Solr and GeOMG for development'
  task server: :environment do
    require 'solr_wrapper'

    shared_solr_opts = { managed: true, verbose: true, persist: false, download_dir: 'tmp' }
    shared_solr_opts[:version] = ENV['SOLR_VERSION'] if ENV['SOLR_VERSION']

    SolrWrapper.wrap(shared_solr_opts.merge(port: 8983, instance_dir: 'tmp/geoportal-core-development')) do |solr|
      solr.with_collection(name: 'geoportal-core-development', dir: Rails.root.join('solr/conf').to_s) do
        puts 'Solr running at http://localhost:8983/solr/geoportal-core-development/, ^C to exit'
        puts ' '
        begin
          Rake::Task['geomg:solr:reindex'].invoke
          system "bundle exec rails s --binding=#{ENV.fetch('GEOMG_SERVER_BIND_INTERFACE', '0.0.0.0')} --port=#{ENV.fetch('GEOMG_SERVER_PORT', '3000')}"
          sleep
        rescue Interrupt
          puts "\nShutting down..."
        end
      end
    end
  end

  desc 'Start solr server for testing.'
  task test: :environment do
    if Rails.env.test?
      shared_solr_opts = { managed: true, verbose: true, persist: false, download_dir: 'tmp' }
      shared_solr_opts[:version] = ENV['SOLR_VERSION'] if ENV['SOLR_VERSION']

      SolrWrapper.wrap(shared_solr_opts.merge(port: 8985, instance_dir: 'tmp/geoportal-core-test')) do |solr|
        solr.with_collection(name: 'geoportal-core-test', dir: Rails.root.join('solr/conf').to_s) do
          puts 'Solr running at http://localhost:8985/solr/#/geoportal-core-test/, ^C to exit'
          begin
            Rake::Task['geomg:reindex'].invoke
          rescue Interrupt
            puts "\nShutting down..."
          end
        end
      end
    else
      system('rake geomg:test RAILS_ENV=test')
    end
  end

  namespace :solr do
    desc 'sync all Works and Collections to solr index'
    task reindex: :environment do
      scope = Kithe::Model.where(kithe_model_type: 1)

      Kithe::Indexable.index_with(batching: true) do
        scope.find_each(&:update_index)
      end
    end

    desc 'delete any model objects in solr that no longer exist in the db'
    task delete_orphans: :environment do
      deleted_ids = Kithe::SolrUtil.delete_solr_orphans
      puts "Deleted #{deleted_ids.count} Solr objects"
    end

    desc 'delete ALL items from Solr'
    task delete_all: %i[environment production_guard] do
      Kithe::SolrUtil.delete_all
    end

    desc 'print out mapped index hash for specified ID, eg rake scihist:solr:debug_indexing[adf232adf]'
    task :debug_indexing, [:friendlier_id] => [:environment] do |_t, args|
      Kithe::Model.find_by(friendlier_id: args[:friendlier_id]).update_index(writer: Traject::DebugWriter.new({}))
    end
  end
end
