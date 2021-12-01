module TimeBlocksHelper
  def get_time_list
    entry = [['Select a time', '']]
    TimeBlock.all.each do |time|
      entry << [time.start_time, time.id]
    end
    return entry
  end

  def get_date_time(event, time)
    date =  Date.new(event["date(1i)"].to_i, event["date(2i)"].to_i, event["date(3i)"].to_i)
    start_time = Time.new(date.year, date.month, date.day, time["start_time(4i)"].to_i, time["start_time(5i)"].to_i)
    end_time = Time.new(date.year, date.month, date.day, time["end_time(4i)"].to_i, time["end_time(5i)"].to_i)
    return date, start_time, end_time
  end
end
