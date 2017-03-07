feature "Creating new links" do

  scenario "be able to add new links" do
    visit('/links/new')
    fill_in :title, with: 'Google'
    fill_in :url, with: 'http://www.google.co.uk'
    click_button 'Add Link'
    within 'ul#links' do # need to have this inside the unordered list not in general page
      expect(page).to have_content('Google')
    end
  end

end
