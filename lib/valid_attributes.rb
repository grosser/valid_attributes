#create a valid new record
#attributes are set separetly(no mass-assignment)
#valid User or valid 'user' or valid User, :name=>'Peter'
def valid(type,attributes={})
  record = type.to_s.camelcase.constantize.new
  valid_attributes(type.to_s.underscore).merge(attributes).each do |k,v|
    record.send("#{k}=",v)
  end
  record
end

def create_valid(type,attributes={})
  record = valid(type,attributes)
  record.save!
  record
end

def valid_attributes(record_name,attributes={})
  Grosser::Valid.load_valid_attributes(record_name).merge(attributes.to_options)
end

#example: User, :login=>['',nil,'admin'], :email=>['',nil,'aa','@','a@','@a']
def assert_invalid_attributes(model_class, attributes)
  attributes.each_pair do |attribute, value|
    assert_invalid_value model_class, attribute, value
  end
end 

#example: User, :login, ['',nil,'admin']
def assert_invalid_value(model_class, attribute, value)
  if value.kind_of? Array
    value.each { |v| assert_invalid_value model_class, attribute, v }
  else
    record = valid model_class
    record.send(attribute.to_s+'=',value)
    assert_block "<#{model_class}.#{attribute}> expected to be invalid when set to <#{value}>" do
      record.valid? # Must be called to generate the errors
      record.errors.invalid? attribute
    end
  end
end

module Grosser
  class Valid
    def self.load_valid_attributes(record_name)
      name = record_name.to_s.underscore
      @@valid_attributes ||= YAML::load_file(path_to_valid_yml)
      begin
        attrs = @@valid_attributes[name].to_options! 
      rescue
        raise "attributes for #{name} not found! --> valid.yml"
      end
      attrs
    end
    
    def self.path_to_valid_yml
      File.join(RAILS_ROOT,'test','fixtures','valid','valid.yml')
    end
  end
end