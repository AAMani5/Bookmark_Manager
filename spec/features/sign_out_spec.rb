feature 'User signs out' do

  before(:each) do
    User.create(email: 'test@test.com',
                password: 'test',
                password_confirmation: 'test')
  end

  scenario 'while being signed in' do
    visit '/session/new'
    fill_in :email, with: 'test@test.com'
    fill_in :password, with: 'test'
    click_button 'Sign In'
    click_button 'Sign Out'
    expect(page).to have_content('goodbye!')
    expect(page).not_to have_content('Welcome, test@test.com')
  end

end
