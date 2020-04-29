# frozen_string_literal: true

desc 'Run test suite'
task :ci do
  shared_solr_opts = { managed: true, verbose: true, persist: false, download_dir: 'tmp' }
  shared_solr_opts[:version] = ENV['SOLR_VERSION'] if ENV['SOLR_VERSION']

  success = true
  SolrWrapper.wrap(shared_solr_opts.merge(port: 8985, instance_dir: 'tmp/geoportal-core-test')) do |solr|
    solr.with_collection(name: "geoportal-core-test", dir: Rails.root.join("solr", "conf").to_s) do
      system 'RAILS_ENV=test TESTOPTS="-v" bundle exec rails test:system test' || success = false
    end
  end

  exit!(1) unless success
end

namespace :geomg do
  desc 'Run Solr and GeOMG for development'
  task :server, [:rails_server_args] do
    require 'solr_wrapper'

    shared_solr_opts = { managed: true, verbose: true, persist: false, download_dir: 'tmp' }
    shared_solr_opts[:version] = ENV['SOLR_VERSION'] if ENV['SOLR_VERSION']

    SolrWrapper.wrap(shared_solr_opts.merge(port: 8983, instance_dir: 'tmp/geoportal-core-development')) do |solr|
      solr.with_collection(name: "geoportal-core-development", dir: Rails.root.join("solr", "conf").to_s) do
        puts "Solr running at http://localhost:8983/solr/geoportal-core-development/, ^C to exit"
        puts ' '
        begin
          # Rake::Task['geoblacklight:solr:seed'].invoke
          system "bundle exec rails s -b 0.0.0.0"
          sleep
        rescue Interrupt
          puts "\nShutting down..."
        end
      end
    end
  end

  desc "Start solr server for testing."
  task :test do
    if Rails.env.test?
      shared_solr_opts = { managed: true, verbose: true, persist: false, download_dir: 'tmp' }
      shared_solr_opts[:version] = ENV['SOLR_VERSION'] if ENV['SOLR_VERSION']

      SolrWrapper.wrap(shared_solr_opts.merge(port: 8985, instance_dir: 'tmp/geoportal-core-test')) do |solr|
        solr.with_collection(name: "geoportal-core-test", dir: Rails.root.join("solr", "conf").to_s) do
          puts "Solr running at http://localhost:8985/solr/#/geoportal-core-test/, ^C to exit"
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

  desc "Sync all Works and Collections to Solr index"
  task :reindex do
    Kithe::Indexable.index_with(batching: true) do
      Kithe::Model.where("kithe_model_type": ["document"]).find_each do |model|
        model.update_index
      end
    end
  end
end
