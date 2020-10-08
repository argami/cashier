# cashier [![Build Status](https://travis-ci.com/argami/cashier.svg?branch=main)](https://travis-ci.com/argami/cashier)
cashier kata

## Description

### Pricing rules (in MVP)

Is a hash, where keys are the barcode of the product

{ 'GR1' => { 
    price: 3.11,
    rule: { min_quantity: 3, price_per: 1, price: 11.23 / 3 * 2 } } }