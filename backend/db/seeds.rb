# frozen_string_literal: true

include FactoryBot::Syntax::Methods

User.delete_all
Account.delete_all
Address.delete_all
Category.delete_all
Provider.delete_all
Customer.delete_all

account = Account.new(name: Faker::Company.name, domain: 'http://localhost:5000')
user_info = {
  email: 'admin@user.com',
  password: 'secure-password'
}
user = account.users.new(user_info)
user.role = :admin
account.save

4.times do
  category = create(:category, account: account)
  create(:tax, account: account, category: category)
  create(:language, account: account)
end
account.default_language = Language.first.uuid

12.times do
  category = account.categories.order('RAND()').first
  subcategory = category.children.create(name: Faker::Beer.brand, account: account)
  if rand(100) > 40
    language = account.languages.order('RAND()').first
    subcategory.translations.create(name: Faker::Book.title, language: language)
  end
end

3.times do
  create(:provider, account: account)
end

# global tax
create(:tax, account: account)

24.times do
  product = build(:product, account: account)
  product.category = account.categories.order('RAND()').first
  product.save!
end

account.products.limit(5).each do |product|
  create(:tax, account: account, product: product)
end

3.times do
  create(:customer, account: account)
end
