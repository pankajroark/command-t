# Copyright 2010-2014 Greg Hurrell. All rights reserved.
# Licensed under the terms of the BSD 2-clause license.

require 'command-t/ext' # CommandT::Matcher
require 'net/http'
require 'uri'

module CommandT
  # Encapsulates a Scanner instance (which builds up a list of available files
  # in a directory) and a Matcher instance (which selects from that list based
  # on a search string).
  #
  # Specialized subclasses use different kinds of scanners adapted for
  # different kinds of search (files, buffers).
  class Finder
    include VIM::PathUtilities

    def initialize(path = Dir.pwd, options = {})
      raise RuntimeError, 'Subclass responsibility'
    end

    # Options:
    #   :limit (integer): limit the number of returned matches
    def sorted_matches_for(str, options = {})
      #@matcher.sorted_matches_for str, options
      uri = URI.parse("http://localhost:10120/#{str}")
      lines = Net::HTTP.get_response(uri).body
      lines.split("\n")
    end

    def open_selection(command, selection, options = {})
      ::VIM::command "silent #{command} #{selection}"
    end

    def path=(path)
      @scanner.path = path
    end
  end # class Finder
end # CommandT
