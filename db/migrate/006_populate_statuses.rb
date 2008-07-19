class PopulateStatuses < ActiveRecord::Migration
  def self.up
    execute "delete from statuses"
    Status.create(:status => "Unknown", :color => '#333', :description => "Not set.")
    Status.create(:status => "In Office", :color => 'green', :description => "Working in the office")
    Status.create(:status => "WFH", :color => 'darkorange', :description => "Working From Home")
    Status.create(:status => "Sick", :color => 'darkred', :description => "Sick")
    Status.create(:status => "Vacation", :color => 'brown', :description => "Vacation Day")
    Status.create(:status => "Biz Trip", :color => 'darkblue', :description => "Business Trip")
  end

  def self.down
  end
end
