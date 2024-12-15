require 'rails_helper'

RSpec.describe "adam/new", type: :view do
  it "renders new adam form" do
    render

    assert_select "form[action=?][method=?]", adam_path, "post" do
      assert_select "input[name=?]", "password"
    end
  end
end
