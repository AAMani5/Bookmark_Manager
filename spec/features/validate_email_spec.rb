feature "Data Validation" do

  scenario "validates that the email is entered" do
    visit('/users/new')
    fill_in :password, with: 'firstone'
    fill_in :password_confirmation, with: 'firstone'
    expect{click_button 'Sign Up'}.to_not change(User, :count)
    expect(page).to have_current_path('/users')
    expect(page).to have_content 'Password and confirmation password do not match'
  end

  scenario "validates that the email is valid" do
    visit('/users/new')
    fill_in :email, with: 'invalid@mail'
    fill_in :password, with: 'firstone'
    fill_in :password_confirmation, with: 'firstone'
    expect{click_button 'Sign Up'}.to_not change(User, :count)
    expect(page).to have_current_path('/users')
    expect(page).to have_content 'Password and confirmation password do not match'
  end

end
