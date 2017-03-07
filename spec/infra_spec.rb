feature "Welcome page" do

  scenario "infra check" do
    visit('/')
    expect(page).to have_content "Hello World"
  end

end
