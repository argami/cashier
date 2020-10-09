# cashier [![Build Status](https://travis-ci.com/argami/cashier.svg?branch=main)](https://travis-ci.com/argami/cashier) [![Codacy Badge](https://app.codacy.com/project/badge/Grade/3d38e40e3fb649f18b713a8e5e6adbf7)](https://www.codacy.com/gh/argami/cashier/dashboard?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=argami/cashier&amp;utm_campaign=Badge_Grade)
cashier kata

## Description

This is what i will call a MVP version of this task, this is the most simpler way to do it.

### Pricing rules (in MVP)

```ruby
    { 'GR1' => { 
                price: 3.11,
                rule: { min_quantity: 3, 
                        price_per: 1, 
                        price: 11.23 / 3 * 2 } } }
```

KEY | Required | Default | Description
------------ | ------------ | ------------ | -------------
price | x | | normal price of the product
rule | | {} | rule to apply to the product
rule.min_quantity || 0 | minimun quantity of products to apply rule. if is 0 rule is disabled
rule.price_per || 1 | the rule price should be applied per X amount of products
rule.price || 0 | this is the applied per (price_per) X products.

# TODO

- [x] product price is required and has to be a positive value
- [x] validate rules formating and set up default values
- [ ] when apply rule price, total price can't be lower than 0
- [x] test cart without products shouldn't fail
- [x] refactor rule
- [x] refactor product
- [ ] create a rules manager
- [ ] create a cart
- [x] needs a Rule#apply
- [ ] in rules should be unique products (related with rules manager)
- [ ] extract the products and rule validation errors to its own error type
