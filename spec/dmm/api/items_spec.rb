# -*- encoding: utf-8 -*-
require 'spec_helper'

describe Dmm::API::Items do
  context 'request with wrong affiliate id' do
    before do
      @client = wrong_client(
        :api_id       => 'API_ID',
        :affiliate_id => 'WRONG_AFFILIATE_ID',
        :fixture      => 'request_with_wrong_affiliate_id.xml')
    end

    subject { @client }

    it "should raise Dmm::Error with error message 'RequestError: Parameter not found (affiliate_id)'" do
      error_msg = 'RequestError: Parameter not found (affiliate_id)'
      lambda { subject.item_list(:keyword => '巨乳') }.should raise_error(Dmm::Error, error_msg)
    end
  end

  context 'request with wrong api id' do
    before do
      @client = wrong_client(
        :api_id       => 'WRONG_API_ID',
        :affiliate_id => 'AFFILIATE_ID',
        :fixture      => 'request_with_wrong_api_id.xml')
    end

    subject { @client }

    it "should raise Dmm::Error with error message 'LoginError: No existing account (login)'" do
      error_msg = 'LoginError: No existing account (login)'
      lambda { subject.item_list(:keyword => '巨乳') }.should raise_error(Dmm::Error, error_msg)
    end
  end

  context 'request with illegal parameter' do
    before do
      @client = client_with_illegal_param
    end

    subject { @client }

    it "should raise Dmm::Error 'RequestError: Parameter illegal (site)'" do
      error_msg = 'RequestError: Parameter illegal (site)'
      lambda { subject.item_list(:site => 'illegalparameter') }.should raise_error(Dmm::Error, error_msg)
    end
  end
end