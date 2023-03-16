require "test_helper"

class BulkActionRunJobTest < ActiveJob::TestCase
  def setup
    @bulk_action = bulk_actions(:one)
    @response = BulkActionRunJob.perform_later @bulk_action
  end

  test "enqueued jobs" do
    assert_enqueued_jobs 1
    clear_enqueued_jobs
    assert_enqueued_jobs 0
  end
end
