require 'spec_helper'

feature "Users can create new issues" do 
	
	let(:user) { FactoryGirl.create(:user) }

	before do 
		login_as(user)
		platform = FactoryGirl.create(:platform, name: "Caliber")
		assign_role!(user, :editor, platform)
		visit platform_path(platform)
		click_link "New Issue"
	end

	scenario "With valid attributes" do 
		select "P1", from: "Priority"
		fill_in "Subject", with: "Caliber account service is down"
		fill_in "Issue", with: "Users are unable to log in with devices, apps or NOOK Digital sites (nook.com, nook press)"
		fill_in "Impact", with: "This is impacting a larger number of users"
		fill_in "Ticket", with: "SYS-1234"
		fill_in "Status", with: "Operations and engineering notified, a bridge will be opened.  Details to follow."
		fill_in "Next steps", with: "Bridge call to be opened"
		click_button "Create Issue"

		expect(page).to have_content "Issue has been created."

		within ("#issue") do
			expect(page).to have_content "Creator: #{user.email}"
		end
	end

	scenario "With invalid attributes" do 
		click_button "Create Issue"
		expect(page).to have_content "Issue has not been created."
		expect(page).to have_content "Subject can't be blank"
		expect(page).to have_content "Issue can't be blank"
		expect(page).to have_content "Impact can't be blank"
		expect(page).to have_content "Status can't be blank"
	end

	scenario "with an invalid subject" do 
		select "P1", from: "Priority"
		fill_in "Subject", with: "Caliber account service is down and there are people running around with their hair on fire, and cats and dogs are living together and the world is in chaos, what have we done????"
		fill_in "Issue", with: "Users are unable to log in with devices, apps or NOOK Digital sites (nook.com, nook press)"
		fill_in "Impact", with: "This is impacting a larger number of users"
		fill_in "Ticket", with: "SYS-1234"
		fill_in "Status", with: "Operations and engineering notified, a bridge will be opened.  Details to follow."
		fill_in "Next steps", with: "Bridge call to be opened"
		click_button "Create Issue"
		expect(page).to have_content "Issue has not been created."
		expect(page).to have_content "Subject is too long"
	end

	scenario "with an attachment" do 
		select "P3", from: "Priority"
		fill_in "Subject", with: "Page is rendering without CSS"
		fill_in "Issue", with: "Some pages look funny"
		fill_in "Impact", with: "This makes us look bad"
		fill_in "Ticket", with: "UPRESS-1234"
		fill_in "Status", with: "New"
		fill_in "Next steps", with: "Look at attached file, make fix"
		attach_file "File #1", "spec/fixtures/speed.txt"
		click_button "Create Issue"

		expect(page).to have_content "Issue has been created."

		within("#issue .attachments") do 
			expect(page).to  have_content "speed.txt"
		end
	end

	scenario "persist file uploads across form submissions" do
		attach_file "File #1", "spec/fixtures/speed.txt"
		click_button "Create Issue"

		select "P3", from: "Priority"
		fill_in "Subject", with: "Page is rendering without CSS"
		fill_in "Issue", with: "Some pages look funny"
		fill_in "Impact", with: "This makes us look bad"
		fill_in "Ticket", with: "UPRESS-1234"
		fill_in "Status", with: "New"
		fill_in "Next steps", with: "Look at attached file, make fix"
		click_button "Create Issue"

		expect(page).to have_content "Issue has been created."

		within("#issue .attachments") do 
			expect(page).to  have_content "speed.txt"
		end
	end

	scenario "with multiple attachments", js: true do 
		select "P3", from: "Priority"
		fill_in "Subject", with: "Page is rendering without images"
		fill_in "Issue", with: "Pages look funny without pictures"
		fill_in "Impact", with: "This makes us look daft"
		fill_in "Ticket", with: "UPRESS-5678"
		fill_in "Status", with: "New"
		fill_in "Next steps", with: "Look at attached files, make fix"

		attach_file "File #1", Rails.root.join("spec/fixtures/jaypegs.txt")
		click_button "Create Issue"

		expect(page).to have_content "Issue has been created."

		within("#issue .attachments") do 
			expect(page).to  have_content "jaypegs.txt"
		end
	end
end