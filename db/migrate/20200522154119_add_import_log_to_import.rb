class AddImportLogToImport < ActiveRecord::Migration[6.0]
  def change
    add_column :imports, :import_log, :json, default: {}
  end
end
