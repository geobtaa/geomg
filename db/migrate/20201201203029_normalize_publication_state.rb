class NormalizePublicationState < ActiveRecord::Migration[6.0]
  def change
    execute "UPDATE kithe_models SET publication_state = LOWER(publication_state)"
    execute "UPDATE document_transitions SET to_state = LOWER(to_state)"

    Rake::Task['geomg:solr:reindex'].invoke
  end
end
