require 'rails_helper'

require 'rails_helper'

describe Contact do
  describe "validations" do
    context "invalid attributes" do
      it "is invalid without a name" do
        contact = Contact.new()
        expect(contact).to be_invalid
      end
    end

    context "valid attributes" do
      it "is valid with a name" do
        company = create(:company)
        contact = Contact.new(name: "Karl", company: company)
        expect(contact).to be_valid
      end
    end
  end

  describe "relationships" do
    it "belongs to a caompany" do
      contact = Contact.new(name: "Dropbox")
      expect(contact).to respond_to(:company)
    end
  end
end
