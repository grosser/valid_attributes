GOALS
=====
 - create single valid record
 - edge-case records without fixtures
 - valid attributes to test a post or fill a form


INSTALL
=======
Fill the test/fixtures/valid/valid.yml with 1 valid set of attributes per model
Example:

    user:
      name: Hans
      login: hand
      address_id: 1
  
 
USAGE
=====
 - set of valid attributes: valid_attributes User
 - a valid Record(new): valid User
 - a valid saved Record: create_valid User
 - an edge-case User: valid User, :name=>'oh noo it is too long'

 
CONTRIBUTORS
============
[assert_invalid](http://www.railsforum.com/viewtopic.php?id=741)