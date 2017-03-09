feature "Sign Up for services" do

  scenario "be able to sign up in my account" do
    visit('/users/new')
    fill_in :email, with: 'test@test.com'
    fill_in :password, with: '1234'
    expect{click_button 'Sign Up'}.to change{User.count}.by 1
    expect(page).to have_current_path('/links')
    expect(page).to have_content('Hello test@test.com, Welcone to BookmarkManager')
  end

end
