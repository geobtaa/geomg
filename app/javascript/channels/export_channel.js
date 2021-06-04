import consumer from "./consumer"

consumer.subscriptions.create({ channel: "ExportChannel" }, {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log('Export Channel Connected');
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
    console.log('Export Channel Disconnected');
  },

  received(data) {
    console.log('Export Channel Received');
    console.log(data);

    if (data['progress']) {
      console.log(data['progress']);
    }

    if (data['csv_file']) {
      var blob, csv_download_link;

      blob = new Blob([data['csv_file']['content']]);

      // Create a link with the data
      // Trigger the link click event to download the file
      csv_download_link = document.createElement('a');

      csv_download_link.href = window.URL.createObjectURL(blob);
      csv_download_link.download = data['csv_file']['file_name'];
      csv_download_link.click();
    }
  }
});
