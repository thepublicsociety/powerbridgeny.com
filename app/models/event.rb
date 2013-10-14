class Event < ActiveRecord::Base
  attr_accessible :event_date, :event_description, :event_name, :event_end, :location, :in_footer
  def start_time
    event_date.to_s
  end
  def end_time
    event_end.to_s
  end
  def name
    event_name
  end
  def link
    "/calendar?month=#{self.event_date.strftime("%-m")}&year=#{self.event_date.strftime("%Y")}"
  end
  def description
    event_description
  end
end
