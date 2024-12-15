require 'rails_helper'

RSpec.describe Note, type: :model do
  it "is valid with a body" do
    expect(Note.new(body: "Hello")).to be_valid
  end

  it "is not valid without a body" do
    expect(Note.new(body: nil)).to_not be_valid
  end
end
