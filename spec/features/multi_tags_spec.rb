feature "Adding multiple tags" do

  scenario 'I can add multiple tags to a new link' do
    visit '/links/new'
    fill_in 'url',   with: 'http://www.makersacademy.com/'
    fill_in 'title', with: 'Makers Academy'
    # our tags will be space separated
    fill_in 'tags',  with: 'education ruby'
    click_button 'Add Link'
    link = Link.first
    expect(link.tags.map(&:name)).to include('education', 'ruby')
  end

end
