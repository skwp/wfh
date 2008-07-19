class UserStatusUpdatesController < ApplicationController

  def update_status  
    update = UserStatusUpdate.find_by_date_and_user_id(params[:date], params[:user]) || UserStatusUpdate.new(:user_id => params[:user], :date => params[:date])
    logger.error "Found #{update}"
    update.status_id = params[:status]
    update.save
    logger.error "update #{update.errors}"
    render :update do |page|
      page.replace_html "statuses-#{params[:date]}", :partial => 'statuses', :locals => {:date => params[:date]}
      page.replace_html "recent", :partial => 'front/recent'
    end
  end

  def working_on
  end
  
  def rss
     render :text => render_rss_feed, :content_type => Mime::RSS
  end

  private
  def render_rss_feed
    items = UserStatusUpdate.recent + WorkingOn.recent
    items = items.sort_by {|i| i.created_at}
    
    xml = Builder::XmlMarkup.new(:indent => 2)

    feed = {}
    feed[:title] ||= "Working From Home"
    feed[:url] ||= homepage_url
    feed[:item_url_prefix] ||= ""

    xml.instruct!
    xml.rss({:version => 2.0}) do
      xml.channel do
        xml.title(feed[:title])
        xml.link(feed[:url])
        xml.description(feed[:description]) if feed[:description]
        xml.language("en")
        xml.ttl("40")

        for update in items
          xml.item do
            if update.is_a?(WorkingOn)
              xml.title("#{update.user.username}: #{update.text}")
              xml.description(update.text)                            
            elsif update.is_a?(UserStatusUpdate)
              xml.title("#{update.user.username}: #{update.status.status} on #{update.date.strftime("%A")} the #{update.date.day.ordinalize}")
              xml.description(update.status.description)              
            end
            xml.pubDate(update.created_at.to_s(:rfc822))
            xml.guid("#{update.class}-#{update.id}")
            xml.link(homepage_url + "##{update.class.to_s.underscore}-#{update.id}")
          end
        end
      end
    end
  end
end
