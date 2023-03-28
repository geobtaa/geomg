module UploadUtil
  def self.kithe_upload_data_config(toggle_value: "kithe-upload")
    data = {
      toggle: toggle_value,
      upload_endpoint: Rails.application.routes.url_helpers.direct_app_upload_path
    }

    data
  end
end