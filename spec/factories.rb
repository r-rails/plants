
FactoryBot.define do
  factory(:user) do
    email { 'abc@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
    username { 'john_doe' } 
  end
end