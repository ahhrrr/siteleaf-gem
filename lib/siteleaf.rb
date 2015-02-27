libdir = File.dirname(__FILE__)
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

require 'siteleaf/version'
require 'siteleaf/client'
require 'siteleaf/entity'
require 'siteleaf/asset'
require 'siteleaf/page'
require 'siteleaf/post'
require 'siteleaf/server'
require 'siteleaf/site'
require 'siteleaf/theme'
require 'siteleaf/user'
require 'rbconfig'

module Siteleaf

  @api_base = 'https://api.siteleaf.com/v1'

  class << self
    attr_accessor :api_key, :api_secret, :api_base
  end

  def self.api_url(url='')
    "#{@api_base}/#{url}"
  end

  def self.settings_file
    File.expand_path('~/.siteleaf')
  end

  def self.load_settings
    if ENV['SITELEAF_API_KEY'] && ENV['SITELEAF_API_SECRET']
      self.api_key = ENV['SITELEAF_API_KEY']
      self.api_secret = ENV['SITELEAF_API_SECRET']
    elsif File.exist?(self.settings_file)
      config = File.open(self.settings_file) do|file|
        Marshal.load(file)
      end
      self.api_key = config[:api_key] if config.has_key?(:api_key)
      self.api_secret = config[:api_secret] if config.has_key?(:api_secret)
    end
  end

end
