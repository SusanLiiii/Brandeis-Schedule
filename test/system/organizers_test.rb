require "application_system_test_case"

class OrganizersTest < ApplicationSystemTestCase
  setup do
    @organizer = organizers(:one)
  end

  test "visiting the index" do
    visit organizers_url
    assert_selector "h1", text: "Organizers"
  end

  test "creating a Organizer" do
    visit organizers_url
    click_on "New Organizer"

    fill_in "Department", with: @organizer.department_id
    fill_in "Email", with: @organizer.email
    fill_in "Name", with: @organizer.name
    click_on "Create Organizer"

    assert_text "Organizer was successfully created"
    click_on "Back"
  end

  test "updating a Organizer" do
    visit organizers_url
    click_on "Edit", match: :first

    fill_in "Department", with: @organizer.department_id
    fill_in "Email", with: @organizer.email
    fill_in "Name", with: @organizer.name
    click_on "Update Organizer"

    assert_text "Organizer was successfully updated"
    click_on "Back"
  end

  test "destroying a Organizer" do
    visit organizers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Organizer was successfully destroyed"
  end
end
