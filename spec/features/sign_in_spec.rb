feature "Sign in for services" do

  scenario "be able to sign into my account" do
    user = User.create(:email => 'test@test.com', :password => '1234', :password_confirmation => '1234')
    visit('/session/new')
    fill_in :email, with: user.email
    fill_in :password, with: user.password
    click_button 'Sign In'
    expect(page).to have_current_path('/links')
    expect(page).to have_content("Welcome, #{user.email}")
  end


  scenario "be not able to sign in with wrong credientials" do
    user = User.create(:email => 'test@test.com', :password => '1234', :password_confirmation => '1234')
    visit('/session/new')
    fill_in :email, with: user.email
    fill_in :password, with: 'wrong'
    click_button 'Sign In'
    expect(page).to have_current_path('/session/new')
    expect(page).to have_content('The email or password is incorrect')
  end
end
