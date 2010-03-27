 - validation testing `User.email expected to be invalid when set to <xx@yy>`
 - valid attributes to test a controller :post or fill a form (integration tests / cucumber)
 - create a valid record
 - create edge-case records
 - fixture replacement
 - guards non-model test-code from validation changes

INSTALL
=======
    script/plugin install git://github.com/grosser/valid_attributes.git

Fill `test/valid_attributes.yml` (or spec) with 1 valid set of attributes per model

    user:
      name: Hans
      login: hand
      address_id: 1

When using Rspec: add to `spec/spec_helper.rb`:

    Spec::Runner.configure do |config|
      ...
      config.include(ValidAttributes)
      ...
    end

When using `Test::Unit`: add to `test/test_helper.rb`

    include ValidAttributes

USAGE
=====
 - `assert_invalid_attributes(User, :email => [nil, 's', '@', 'asd@sdf'], :name => [nil, 'x', 'admin'])`
 - set of valid attributes: `valid_attributes User`
 - a valid Record(new): `valid User`
 - a valid Record(saved): `create_valid User`
 - an edge-case User: `valid User, :name=>'oh noo it is too long'`

 
AUTHOR
======
Michael Grosser  
grosser.michael@gmail.com  
Hereby placed under public domain, do what you want, just do not hold me accountable...  
[Original `assert_invalid`](http://www.railsforum.com/viewtopic.php?id=741)
