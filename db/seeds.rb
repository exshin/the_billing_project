# frozen_string_literal: true

# Seed data from json files

## From organizations.json
organization_records = JSON.parse(File.read('db/data/organizations.json'))
organization_records.each do |record|
  new_record = record.except('_id', 'tags', 'domain_names')
  tags = record['tags']
  domain_names = record['domain_names']

  # Make sure organization doesn't already exist
  next if Organization.find_by(id: record['_id'].to_i)

  organization = Organization.new.tap do |o|
    o.id = record['_id']
    o.update(new_record)
    o.save!
  end

  tags.each do |tag|
    # Make sure tag doesn't already exist
    next if organization.tags.find_by(name: tag)

    organization.tags.create!(name: tag)
  end

  domain_names.each do |domain_name|
    # Make sure domain_name doesn't already exist
    next if organization.domain_names.find_by(name: domain_name)

    organization.domain_names.create!(name: domain_name)
  end
end

## From users.json
user_records = JSON.parse(File.read('db/data/users.json'))
user_records.each do |record|
  new_record = record.except('_id', 'tags')
  tags = record['tags']

  # Make sure user doesn't already exist
  next if User.find_by(id: record['_id'].to_i)

  user = User.create!(new_record)

  tags.each do |tag|
    # Make sure tag doesn't already exist
    next if user.tags.find_by(name: tag)

    user.tags.create!(name: tag)
  end
end

## From tickets.json
ticket_records = JSON.parse(File.read('db/data/tickets.json'))
ticket_records.each do |record|
  new_record = record.except('_id', 'tags', 'type')
  new_record['ticket_type'] = record['type']
  new_record['ticket_id'] = record['_id']
  tags = record['tags']

  # Make sure ticket doesn't already exist
  next if Ticket.find_by(id: record['_id'].to_i)

  ticket = Ticket.create!(new_record)

  tags.each do |tag|
    # Make sure tag doesn't already exist
    next if ticket.tags.find_by(name: tag)

    ticket.tags.create!(name: tag)
  end
end
