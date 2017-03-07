feature "List of links" do

  scenario "See a list of existing links" do
    # Link.create(url: 'http://www.makersacademy.com', title: 'Makers Academy')
    visit('/links')
    expect(page.status_code).to eq 200

    within 'ul#links' do # need to have this inside the unordered list not in general page
      expect(page).to have_content('Makers Academy')
    end
  end

end
