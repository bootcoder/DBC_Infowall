FactoryGirl.define do  factory :calendar do
    
  end
  factory :token do
    access_token "MyString"
refresh_token "MyString"
expires_at "2015-10-25 20:25:00"
  end
  factory :marquee do
    text ""
text_color ""
bg_color ""
scroll_amount ""
display_status "MyString"
  end
  factory :text_scroll do
    text ""
text_color ""
bg_color ""
scroll_amount 1
  end

  factory :user do
    username "John"
    password "secret"
  end
end
