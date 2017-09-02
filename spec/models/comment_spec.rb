require 'rails_helper'

describe Comment do
  describe "validations" do
    context "invalid attributes" do
      it "is invalid without content" do
        comment = Comment.new()
        expect(comment).to be_invalid
      end

      it "has a unique name" do
        Comment.create(content: "Cool job")
        comment = Comment.new(content: "Cool job")
        expect(comment).to be_invalid
      end
    end
  end

  describe "relationships" do
    it "has a job" do
      comment = Comment.new(content: "Cool job")
      expect(comment).to respond_to(:job)
    end
  end
end
