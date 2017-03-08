feature "Creating new links" do

  scenario "be able to add new links" do
    visit('/links/new')
    fill_in :title, with: 'Google'
    fill_in :url, with: 'http://www.google.co.uk'
    fill_in :tags, with: 'search'
    click_button 'Add Link'
    link = Link.first
    expect(link.tags.map(&:name)).to include('search')
  end

end
