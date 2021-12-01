module OrganizersHelper
  def get_organizer_list
    entry = []
    Organizer.all.each do |org|
      entry << [org.name, org.id]
    end
    return [['Select an organizer', '']] + entry.sort_by(&:first)
  end
end
