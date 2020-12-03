class NormalizePublicationState < ActiveRecord::Migration[6.0]
  def up
    execute "UPDATE kithe_models SET publication_state = LOWER(publication_state)"
    execute "UPDATE document_transitions SET to_state = LOWER(to_state)"

    Rake::Task['geomg:solr:reindex'].invoke
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
