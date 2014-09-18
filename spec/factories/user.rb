FactoryGirl.define do
  factory :user do
    first_name "Freddy"
    last_name "Francisco"
    email "freddyfrancisco@jumpstartlab.com"
    password "password"
    password_confirmation "password"
  end

   factory :borrower, class: User, parent: :user do
     role "borrower"
   end

   factory :lender, class: User, parent: :user do
    role "lender"
    first_name "Lender"
    last_name "McNender"
    email "lender@jumpstartlab.com"
    role "lender"
   end
end
