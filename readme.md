# Run specs
```ruby
bundle exec rspec
```
# File Structure
- receipt.rb
- purchase_item_builder.rb
- taxes.rb

Sample ruby `receipt.rb`
```ruby
purchases = ["1 imported bottle of perfume at 27.99",
             "1 bottle of perfume at 18.99",
             "1 packet of headache pills at 9.75",
             "3 imported boxes of chocolates at 11.25"
]

receipt = Receipt.new(purchases)
receipt.show
```

Terminal
```unix
$ ruby receipt.rb
```
