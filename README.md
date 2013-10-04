sample_app
==========

This application will learn about strong parameter in rails 4

## Setup
```sh
$ git clone https://github.com/khanhhd/sample_app.git
$ cd sample_app
$ bundle install
$ rake db:migrate
```
## Usage
```sh
1. $ rails s
2. Open web brower and access to 
    http://localhost:3000/customers/new
```
## Strong parameter
```sh
def customer_params
  params.require(:customer).permit(:name, :address, :phone,
    products_attributes: [:id, :name,  :code, {manufacturers_attributes: [:id, :name, :address]}])
end
```
* permit will return an instance of ActionController::Parameters
* Using permit won't mind if the permitted attribute is missing
* The require returns the actual value of the parameter, unlike permit which returns the actual hash.
In this application i use nested attribute for product and manufaturer in customer form
For use nested attribute: 
* In model

```sh
class Customer < ActiveRecord::Base
  has_many :products, dependent: :destroy
  accepts_nested_attributes_for :products # use for nested attribute
end
```
```sh
class Product < ActiveRecord::Base
  belongs_to :customer
  has_many :manufacturers, dependent: :destroy
  accepts_nested_attributes_for :manufacturers # use for nested attribute
end
```
* In controller <br>
  Need build object

```sh
  def new
    @customer = Customer.new
    product = @customer.products.build
    product.manufacturers.build
  end
```

* In views form

```sh
  <div class="field">
    <%= f.fields_for :products do |fp| %>
      <%= render "customers/product_form", f: fp %>
    <% end %>
  </div>
```

## References 
http://blog.sensible.io/2013/08/17/strong-parameters-by-example.html
http://edgeapi.rubyonrails.org/classes/ActionController/StrongParameters.html


## Operation require
Using ruby 2.0 and rails 4.0.0
