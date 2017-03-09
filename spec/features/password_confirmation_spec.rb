feature "Password confirmation" do

  scenario "be not able to sign up if password is invalid" do
    visit('/users/new')
    fill_in :email, with: 'test@test.com'
    fill_in :password, with: 'firstone'
    fill_in :password_confirmation, with: 'secondone'
    expect{click_button 'Sign Up'}.to_not change(User, :count)
    expect(page).to have_current_path('/links')
  end

end
