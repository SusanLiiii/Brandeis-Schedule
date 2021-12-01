module RoomsHelper
  def get_room_list
    entry = []
    Room.all.each do |room|
      entry << ["#{room.location}: #{room.name}", room.id]
    end
    return [['Select a room', '']] + entry.sort_by(&:first)
  end
  def get_location_list
    entry = ['Select a location'] + Room.all.pluck(:location).uniq.sort
    return entry
  end
end
