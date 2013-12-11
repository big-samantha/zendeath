#!/usr/bin/env ruby
#$LOAD_PATH << File.dirname(__FILE__)

module Zendeath
  require 'net/http'
  require 'net/https'
  require 'yaml'
  require 'json'
  require 'pry'
  require 'commands'

  configdata = YAML.load_file(ENV['HOME'] + '/.zendeath.yaml')
  baseurl = configdata[:baseurl]
  username = configdata[:username]
  password = configdata[:password]

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
  when 'ticketinfo'
    command.ticketinfo(ARGV[1])
  when 'ticketcomments'
    command.ticketcomments(ARGV[1])
  when 'update'
    # def updateticket(ticketid, comment, status='open', is_public='true')

    command.updateticket(ARGV[1])
  when 'showticket'
    unless ARGV.length == 2
      raise ArgumentError.new('showticket requires a ticket number')
    end
    command.showticket(ARGV[1])
  else
    puts 'Error!
    Current commands include:
    - localinfo
    - me
    - alltickets
    - myworking
    - ticketinfo <ticketid> - Not useful on its own.
    - ticketcomments <ticketid> - Not useful on its own.
    - showticket <ticketid>
    - update <ticketid> <comment> [status] [public]

    <param> - required param
    [param] - optional param'
  end
end
