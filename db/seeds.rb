include FactoryBot::Syntax::Methods

User.delete_all
Account.delete_all
Address.delete_all
Category.delete_all
Provider.delete_all

account = Account.new(name: Faker::Company.name)
user_info = {
  email: 'admin@user.com',
  password: 'secure-password',
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name
}
user = account.users.new(user_info)
user.role = :admin
account.save

4.times do
  category = create(:category, account: account)
  create(:tax, account: account, category: category)
end

12.times do
  category = account.categories.order('RAND()').first
  category.children.create(name: Faker::Beer.brand)
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
