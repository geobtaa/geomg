# frozen_string_literal: true

task stats: :environment do
  Rake::Task["geomg:stats"].invoke
end

desc "Run test suite"
task ci: :environment do
  Rails.env = "test"
  shared_solr_opts = {managed: true, verbose: true, persist: false, download_dir: "tmp"}
  shared_solr_opts[:version] = ENV["SOLR_VERSION"] if ENV["SOLR_VERSION"]

  success = true
  SolrWrapper.wrap(shared_solr_opts.merge(port: 8983, instance_dir: "tmp/blacklight-core")) do |solr|
    solr.with_collection(name: "blacklight-core", dir: Rails.root.join("solr/conf").to_s) do
      system('RAILS_ENV=test TESTOPTS="-v" bundle exec rails test:system test') || success = false
    end
  end

  exit!(1) unless success
end

namespace :geomg do
  desc "Set everything to published state"
  task publish_all: :environment do
    Document.all.each do |doc|
      doc.publication_state = "Published"
      doc.save
    end

    puts "\nAll documents published."
  end

  task production_guard: :environment do
    if Rails.env.production? && ENV["PRODUCTION_OKAY"] != "true"
      warn "\nNot safe for production. If you are sure, run with `PRODUCTION_OKAY=true #{ARGV.join}`\n\n"
      exit 1
    end
  end

  task stats: :environment do
    require "rails/code_statistics"
    ::STATS_DIRECTORIES << ["Indexers", "app/indexers"]
    ::STATS_DIRECTORIES << ["Indexers Tests", "test/indexers"]
    CodeStatistics::TEST_TYPES << "Indexers Tests"
  end

  desc "Run Solr and GEOMG for development"
  task server: :environment do
    require "solr_wrapper"

    shared_solr_opts = {managed: true, verbose: true, persist: false, download_dir: "tmp"}
    shared_solr_opts[:version] = ENV["SOLR_VERSION"] if ENV["SOLR_VERSION"]

    SolrWrapper.wrap(shared_solr_opts.merge(port: 8983, instance_dir: "tmp/blacklight-core")) do |solr|
      solr.with_collection(name: "blacklight-core", dir: Rails.root.join("solr/conf").to_s) do
        puts "Solr running at http://localhost:8983/solr/blacklight-core/, ^C to exit"
        puts " "
        begin
          # Rake::Task['geomg:solr:restore'].invoke
          system "bundle exec rails s --binding=#{ENV.fetch("GEOMG_SERVER_BIND_INTERFACE", "0.0.0.0")} --port=#{ENV.fetch("GEOMG_SERVER_PORT", "3000")}"
          sleep
        rescue Interrupt
          puts "\nShutting down..."
        end
      end
    end
  end

  desc "Start solr server for testing."
  task test: :environment do
    if Rails.env.test?
      shared_solr_opts = {managed: true, verbose: true, persist: false, download_dir: "tmp"}
      shared_solr_opts[:version] = ENV["SOLR_VERSION"] if ENV["SOLR_VERSION"]

      SolrWrapper.wrap(shared_solr_opts.merge(port: 8983, instance_dir: "tmp/blacklight-core")) do |solr|
        solr.with_collection(name: "blacklight-core", dir: Rails.root.join("solr/conf").to_s) do
          puts "Solr running at http://localhost:8983/solr/#/blacklight-core/, ^C to exit"
          begin
            Rake::Task["db:fixtures:load"].invoke
            Rake::Task["geomg:solr:reindex"].invoke
            sleep
          rescue Interrupt
            puts "\nShutting down..."
          end
        end
      end
    else
      system("rake geomg:test RAILS_ENV=test")
    end
  end

  desc "Start solr server for development."
  task :development do
    shared_solr_opts = {managed: true, verbose: true, persist: false, download_dir: "tmp"}
    shared_solr_opts[:version] = ENV["SOLR_VERSION"] if ENV["SOLR_VERSION"]

    SolrWrapper.wrap(shared_solr_opts.merge(port: 8983, instance_dir: "tmp/blacklight-core")) do |solr|
      solr.with_collection(name: "blacklight-core", dir: Rails.root.join("solr", "conf").to_s) do
        puts "Solr running at http://localhost:8983/solr/#/blacklight-core/, ^C to exit"
        begin
          # Rake::Task['geoblacklight:solr:seed'].invoke
          sleep
        rescue Interrupt
          puts "\nShutting down..."
        end
      end
    end
  end

  namespace :solr do
    desc "sync all Works and Collections to solr index"
    task reindex: :environment do
      Kithe::Indexable.index_with(batching: true) do
        progress_bar = ProgressBar.create(total: Document.count, format: Kithe::STANDARD_PROGRESS_BAR_FORMAT)

        scope = Kithe::Model.where(kithe_model_type: 1)

        scope.find_each do |model|
          progress_bar.title = "#{model.class.name}:#{model.friendlier_id}"
          model.update_index
          progress_bar.increment
        end
      end
    end

    desc "delete any model objects in solr that no longer exist in the db"
    task delete_orphans: :environment do
      deleted_ids = Kithe::SolrUtil.delete_solr_orphans
      puts "Deleted #{deleted_ids.count} Solr objects"
    end

    desc "delete ALL items from Solr"
    task delete_all: %i[environment production_guard] do
      Kithe::SolrUtil.delete_all
    end

    desc "print out mapped index hash for specified ID, eg rake scihist:solr:debug_indexing[adf232adf]"
    task :debug_indexing, [:friendlier_id] => [:environment] do |_t, args|
      Kithe::Model.find_by(friendlier_id: args[:friendlier_id]).update_index(writer: Traject::DebugWriter.new({}))
    end

    desc "Save - Sanity Check"
    task save_check: :environment do
      @steps = 0
      Document.in_batches(of: 1000).each do |relation|
        relation.each do |doc|
          # Reindex doc
          doc.save
        rescue
          puts "Save Failed: #{doc.id}\n"
        end

        @steps += relation.count
        puts "Docs Saved: #{@steps}"
      end
    end

    desc "Backup - Create a Solr snapshot"
    task backup: :environment do
      solr = ENV["SOLR_URL"]
      replication = "replication?command=backup"

      res = Faraday.get "#{solr}/#{replication}"
      puts res.body

      sleep(10)

      snapshots = Dir.glob(Rails.root.join("tmp/geoportal-core-development/server/solr/geoportal-core-development/data/snapshot.*").to_s)

      FileUtils.cp_r(snapshots, Rails.root.join("solr/snapshots").to_s)
    end

    desc "Restore Backup"
    task restore: :environment do
      solr = ENV["SOLR_URL"]
      replication = "replication?command=restore"

      snapshot = Dir.glob(Rails.root.join("solr/snapshots/snapshot.*").to_s).last

      FileUtils.cp_r(snapshot, Rails.root.join("tmp/geoportal-core-development/server/solr/geoportal-core-development/data").to_s)

      res = Faraday.get "#{solr}/#{replication}"
      puts res.body
    end
  end
end
