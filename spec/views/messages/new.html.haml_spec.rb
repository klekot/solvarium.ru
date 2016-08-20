require 'rails_helper'

RSpec.describe "messages/new", type: :view do
  before(:each) do
    assign(:message, Message.new(
      :body => "MyText",
      :user => nil
    ))
  end

  it "renders new message form" do
    render

    assert_select "form[action=?][method=?]", messages_path, "post" do

      assert_select "textarea#message_body[name=?]", "message[body]"

      assert_select "input#message_user_id[name=?]", "message[user_id]"
    end
  end
end
