# cashier [![Build Status](https://travis-ci.com/argami/cashier.svg?branch=main)](https://travis-ci.com/argami/cashier) [![Codacy Badge](https://app.codacy.com/project/badge/Grade/3d38e40e3fb649f18b713a8e5e6adbf7)](https://www.codacy.com/gh/argami/cashier/dashboard?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=argami/cashier&amp;utm_campaign=Badge_Grade)
cashier kata

## Description

To this evaluation i have 2 versions:

- [Main](https://github.com/argami/cashier) branch is the more "complex" version 
- [MVP](https://github.com/argami/cashier/tree/MVP) branch is the more simpler version of the same.

In both versions all the tests checks out. (Its all tested in travis, and code validated with Codacy) 

I did some assumptions on how things should be constructed. I also avoid the use of gems. The only ones used are related with the testing framework. 

# TODO

- [x] product price is required and has to be a positive value
- [x] validate rules formating and set up default values
- [x] when apply rule price, total price can't be lower than 0
- [x] test cart without products shouldn't fail
- [x] refactor rule
- [x] refactor product
- [x] create a rules manager
- [x] needs a Rule#apply
- [x] in rules should be unique products (related with rules manager)
- [x] update readme
- [ ] should test Rules#each
- [ ] create a cart (no needed yet complexity is too low)
- [ ] extract the products and rule validation errors to its own error type