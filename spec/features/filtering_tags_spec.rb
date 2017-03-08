feature "Filtering links by tags" do

  scenario "be able to filter links with tag 'bubbles'" do
    visit('/links/new')
    fill_in :title, with: 'Google'
    fill_in :url, with: 'http://www.google.co.uk'
    fill_in :tags, with: 'bubbles'
    click_button 'Add Link'
    visit('/links/new')
    fill_in :title, with: 'BBC'
    fill_in :url, with: 'http://www.google.co.uk'
    fill_in :tags, with: 'news'
    click_button 'Add Link'
    visit ('/tags/bubbles')
    within 'ul#tagged_bubbles' do # need to have this inside the unordered list not in general page
      expect(page).to have_content('Google')
      expect(page).to_not have_content('BBC')
    end
  end

end
