feature "Prevent duplicate sign up" do

  scenario "be not able to signup with an existing user email" do
    visit('/users/new')
    fill_in :email, with: 'test@test.com'
    fill_in :password, with: '1234'
    fill_in :password_confirmation, with: '1234'
    expect{click_button 'Sign Up'}.to change{User.count}.by 1
    expect(page).to have_current_path('/links')
    expect(page).to have_content('Welcome, test@test.com')
    visit('/users/new')
    fill_in :email, with: 'test@test.com'
    fill_in :password, with: '1234'
    fill_in :password_confirmation, with: '1234'
    expect{click_button 'Sign Up'}.to_not change(User, :count)
    expect(page).to have_content 'We already have that email.'
  end

end
