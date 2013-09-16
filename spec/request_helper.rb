# -*- encoding: utf-8 -*-
require 'uri/http'

module RequestHelper
  def sample_response
    time = Time.now.to_s.gsub(/\s/, '+')
    request_url = URI::HTTP.build(
      :host => 'affiliate-api.dmm.com',
      :path => '/',
      :query => 'api_id=API_ID' +
        '&affiliate_id=AFFILIATE_ID' +
        '&operation=ItemList' +
        '&version=2.00' +
        '&timestamp=' + time +
        '&site=DMM.co.jp' +
        '&keyword=%B5%F0%C6%FD'
      )
    stub_request(:get, request_url.to_s).to_return(:status => 200, :body => fixture('sample2.xml'))
    client = Dmm.new(:api_id => 'API_ID', :affiliate_id => 'AFFILIATE_ID')
    client.instance_variable_set(:@time, time)
    client.item_list(:keyword => '巨乳')
  end

  def response_with_error(status=[])
    time = Time.now.to_s.gsub(/\s/, '+')
    request_url = URI::HTTP.build(
      :host => 'affiliate-api.dmm.com',
      :path => '/',
      :query => 'api_id=API_ID' +
        '&affiliate_id=AFFILIATE_ID' +
        '&operation=ItemList' +
        '&version=2.00' +
        '&timestamp=' + time +
        '&site=DMM.co.jp' +
        '&keyword=%B5%F0%C6%FD'
      )
    stub_request(:get, request_url.to_s).to_return(:status => status)
    client = Dmm.new(:api_id => 'API_ID', :affiliate_id => 'AFFILIATE_ID')
    client.instance_variable_set(:@time, time)
    return client
  end

  def wrong_client(options={})
    time = Time.now.to_s.gsub(/\s/, '+')
    request_url = URI::HTTP.build(
      :host => 'affiliate-api.dmm.com',
      :path => '/',
      :query => 'api_id=' + options[:api_id] +
        '&affiliate_id=' + options[:affiliate_id] +
        '&operation=ItemList' +
        '&version=2.00'+
        '&timestamp=' + time +
        '&site=DMM.co.jp' +
        '&keyword=%B5%F0%C6%FD')
    stub_request(:get, request_url.to_s).to_return(:status => 200, :body => fixture(options[:fixture]))
    client = Dmm.new(:api_id => options[:api_id], :affiliate_id => options[:affiliate_id])
    client.instance_variable_set(:@time, time)
    return client
  end

  def client_with_illegal_param
    time = Time.now.to_s.gsub(/\s/, '+')
    request_url = URI::HTTP.build(
      :host => 'affiliate-api.dmm.com',
      :path => '/',
      :query => 'api_id=API_ID' +
        '&affiliate_id=AFFILIATE_ID' +
        '&operation=ItemList' +
        '&version=2.00'+
        '&timestamp=' + time +
        '&site=illegalparameter')
    stub_request(:get, request_url.to_s).to_return(:status => 200, :body => fixture('request_with_illegal_parameter.xml'))
    client = Dmm.new(:api_id => 'API_ID', :affiliate_id => 'AFFILIATE_ID')
    client.instance_variable_set(:@time, time)
    return client
  end
end