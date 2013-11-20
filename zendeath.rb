#!/usr/bin/env ruby

module Zendeath

require 'net/http'
require 'net/https'
require 'yaml'
require 'json'

configdata = YAML.load_file('config.yaml')
baseurl = configdata[:baseurl]
username = configdata[:username]
password = configdata[:password]

class Commands
  def initialize(baseurl, username, password)
    @uri = URI.parse("https://#{baseurl}/")
    @username = username
    @password = password
    @uri.path = '/api/v2/users/me.json'
    @current_user_info = JSON.parse(makerequest)
  end

  def localinfo
    puts @uri
    puts @username
    puts @password
  end

  def makerequest
    @http = Net::HTTP.new(@uri.host, @uri.port)
    @http.use_ssl = true
    @http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    @request = Net::HTTP::Get.new(@uri.request_uri)
    @request.basic_auth(@username, @password)
    return @response = @http.request(@request).body
  end

  def get_this_user(userid)
    @uri.path = "/api/v2/users/#{userid}.json"
    @uri.query = ''
    return JSON.parse(makerequest)['user']
  end

  def me
    def userelement(field)
      @current_user_info['user'][field]
    end

    user_name = userelement('name')
    user_email = userelement('email')
    user_role = userelement('role')
    user_created = userelement('created_at')
    user_last_login = userelement('last_login_at')
    user_time_zone = userelement('time_zone')

    puts "Name:         #{user_name}"
    puts "Email:        #{user_email}"
    puts "Role:         #{user_role}"
    puts "Created:      #{user_created}"
    puts "Last Login:   #{user_last_login}"
    puts "Time Zone:    #{user_time_zone}"
  end

  def alltickets
    @uri.path = '/api/v2/tickets.json'
    @response = JSON.parse(makerequest)
    alltickets = @response['tickets']

    pagecount = 1

    while @response['next_page'] != nil
      pagecount += 1
      @uri.query = 'page=' + pagecount.to_s
      @response = JSON.parse(makerequest)
      alltickets.concat(@response['tickets'])
    end

    unsolved_tickets = alltickets.reject { |element| element['status'] == 'closed' }

    puts "Total Tickets: #{alltickets.length.to_s}"
    puts "Unsolved Tickets: #{unsolved_tickets.length.to_s}"
  end

  def myworking
    @uri.path = '/api/v2/search.json'
    @uri.query = URI.encode("query=status<solved+assignee:#{@username}+type:ticket")
    @my_working_tickets = JSON.parse(makerequest)['results']

    @my_working_tickets.each do |ticket|
      requester = get_this_user(ticket['requester_id'])['name']
      puts ticket['id'].to_s + ': ' + ticket['subject']
      puts "Requester: #{requester}"
      puts 'Status: ' + ticket['status']
      puts ''
    end
    puts "Total Working Tickets: #{@my_working_tickets.length}"
  end

end

command = Commands.new(baseurl, username, password)

case ARGV[0]
when 'localinfo'
  command.localinfo
when 'me'
  command.me
when 'alltickets'
  command.alltickets
when 'myworking'
  command.myworking
else
  puts 'Error!
  Current commands include
  - localinfo
  - me
  - alltickets
  - myworking'
end
end
