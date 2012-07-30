require 'spec_helper'

describe "Phones management" do

  it "shows phones", js: true do
    phone = create :phone
    visit root_path
    page.should have_content phone.name
    page.should have_content phone.number
  end

  it "adds phone", js: true do
    phone = build :phone
    visit root_path

    expect{
      fill_in "phone_name", with: phone.name
      fill_in "phone_number", with: phone.number
      click_button "Add"
    }.to change(Phone, :count).by(1)

    page.should have_content(phone.name)
    page.should have_content(phone.number)
  end

  it "deletes phone", js: true do
    phone = create :phone
    visit root_path

    expect{
      within "#phone#{phone.id}" do
        click_link "Destroy"
        alert = page.driver.browser.switch_to.alert
        alert.accept
      end
      wait_until { page.has_no_selector? "#phone#{phone.id}" }
    }.to change(Phone, :count).by(-1)

    Phone.should_not exist(phone.id)

    page.should_not have_content(phone.name)
    page.should_not have_content(phone.number)
  end

  context "when user edits phone" do
    before(:each) do
      @phone = create :phone
      visit root_path

      within "#phone#{@phone.id}" do
        click_link "Edit"
      end
      wait_until { page.has_selector? "#phone#{@phone.id} form" }
    end

    it "updates phone", js: true do
      within "#phone#{@phone.id}" do
        fill_in "phone_name", with: "Chuck Norris"
        click_button "Save"
      end
      wait_until { page.has_no_selector? "#phone#{@phone.id} form" }

      updated_phone = Phone.find(@phone.id)
      updated_phone.name.should == "Chuck Norris"
    end

    it "not updates phone", js: true do
      within "#phone#{@phone.id}" do
        fill_in "phone_name", with: "#{@phone.name}_updated"
        click_link "Cancel"
      end
      wait_until { page.has_no_selector? "#phone#{@phone.id} form" }

      not_updated_phone = Phone.find(@phone.id)
      not_updated_phone.name.should_not == "#{@phone.name}_updated"
    end
  end
end