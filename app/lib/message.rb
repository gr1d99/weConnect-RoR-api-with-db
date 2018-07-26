class Message
  def self.not_found(record = 'record')
    "Sorry #{record} not found."
  end

  def self.invalid_credentials
    'Invalid credentials.'
  end

  def self.invalid_token
    'Invalid token.'
  end

  def self.unauthorized
    'Unauthorized request.'
  end

  def self.expired_token
    'Sorry, your token has expired. Please log in to continue.'
  end

  def self.missing_token
    'Missing token.'
  end

  def self.account_created
    'Account created successfully.'
  end

  def self.category_created
    'Category created successfully'
  end

  def self.category_updated
    'Category updated successfully'
  end

  def self.category_deleted
    'Category deleted successfully'
  end

  def self.location_created
    'Location created successfully'
  end
end
